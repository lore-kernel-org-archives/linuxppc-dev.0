Return-Path: <robherring2@gmail.com>
Message-ID: <4D6551EF.70207@gmail.com>
Date: Wed, 23 Feb 2011 12:29:03 -0600
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 02/15] dt: add a match table pointer to struct device
References: <20110223043015.20795.37090.stgit@localhost6.localdomain6>
	<20110223043345.20795.2936.stgit@localhost6.localdomain6>
In-Reply-To: <20110223043345.20795.2936.stgit@localhost6.localdomain6>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: sfr@canb.auug.org.au, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant,

On 02/22/2011 10:33 PM, Grant Likely wrote:
> Add a new .of_match field to struct device which points at the
> matching device driver .of_match_table entry when a device is probed
> via the device tree
>
> Signed-off-by: Grant Likely<grant.likely@secretlab.ca>
> ---
>   include/linux/device.h    |    1 +
>   include/linux/of_device.h |    5 +++--
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index ca5d252..8d8e267 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -441,6 +441,7 @@ struct device {
>   	struct dev_archdata	archdata;
>
>   	struct device_node	*of_node; /* associated device tree node */
> +	const struct of_device_id *of_match; /* matching of_device_id from driver */

Couldn't of_match/of_match_table be merged into the platform dev/drv 
id_entry/id_table. Handling MODALIAS for a driver that does both OF 
style and normal platform device matching may be a problem though.

Rob
