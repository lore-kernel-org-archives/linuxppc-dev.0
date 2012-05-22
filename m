Return-Path: <ddaney.cavm@gmail.com>
Message-ID: <4FBBECC2.10503@gmail.com>
Date: Tue, 22 May 2012 12:45:06 -0700
From: David Daney <ddaney.cavm@gmail.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] of: Add prefix parameter to of_modalias_node().
References: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com>
 <1336773923-17866-2-git-send-email-ddaney.cavm@gmail.com>
 <20120520055436.13AF03E03B8@localhost> <20120520060802.03CE73E03B8@localhost>
In-Reply-To: <20120520060802.03CE73E03B8@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.de>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
 Mark Brown <broonie@opensource.wolfsonmicro.com>,
 Tabi Timur-B04825 <B04825@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <rob.herring@calxeda.com>, Jaroslav Kysela <perex@perex.cz>,
 David Daney <ddaney.cavm@gmail.com>,
 "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Liam Girdwood <lrg@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/19/2012 11:08 PM, Grant Likely wrote:
> On Sat, 19 May 2012 23:54:36 -0600, Grant Likely<grant.likely@secretlab.ca>  wrote:
>> On Fri, 11 May 2012 15:05:21 -0700, David Daney<ddaney.cavm@gmail.com>  wrote:
>>> From: David Daney<david.daney@cavium.com>
>>>
>>> When generating MODALIASes, it is convenient to add things like "spi:"
>>> or "i2c:" to the front of the strings.  This allows the standard
>>> modprobe to find the right driver when automatically populating bus
>>> children from the device tree structure.
>>>
>>> Add a prefix parameter, and adjust callers.  For
>>> of_register_spi_devices() use the "spi:" prefix.
>>>
>>> Signed-off-by: David Daney<david.daney@cavium.com>
>>
>> Applied, thanks.  Some notes below...
>
> Wait... why is this necessary?

Because in of_register_spi_devices() in of_spi.c, you do:

	request_module(spi->modalias);

The string passed to request_module() must have the "spi:" prefix.


> The module type prefix isn't stored in
> the modalias value for any other bus type as far as I can see,

It is only useful with the prefix, so I though I would add it to the 
stored value.

> and
> with this series it appears that the "spi:" prefix may or may not be
> present in the modalias.  That doesn't look right.

Perhaps, but the with the combination of patches 1/3 and 2/3 I tried to 
ensure that the prefix would always be present for SPI devices.

>
> Why isn't prefixing spi: at uevent time sufficient?

Because udev may not be loading the driver.

> IIUC, modprobe
> depends on either UEVENT or the modalias attribute to know which
> driver to probe.  It does look like the attribute is missing the spi:
> prefix though.  Does the following change work instead of these two
> patches?
>

No.

> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 3d8f662..da8aac7 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -51,7 +51,7 @@ modalias_show(struct device *dev, struct device_attribute *a, char *buf)
>   {
>          const struct spi_device *spi = to_spi_device(dev);
>
> -       return sprintf(buf, "%s\n", spi->modalias);
> +       return sprintf(buf, "%s%s\n", SPI_MODULE_PREFIX, spi->modalias);
>   }
>
> So, I've dropped this patch from my tree.  If the change above works
> for you then I'll push it out.
>
> g.
>
