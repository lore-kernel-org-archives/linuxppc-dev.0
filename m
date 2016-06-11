Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rRMgn6fz4zDqXs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jun 2016 12:00:21 +1000 (AEST)
Message-ID: <1465610416.22191.160.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Russell
 King <linux@arm.linux.org.uk>, Bhupesh Sharma
 <bhupesh.sharma@freescale.com>,  "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, Santosh Shilimkar
 <ssantosh@kernel.org>, "linux-mmc@vger.kernel.org"
 <linux-mmc@vger.kernel.org>,  Xiaobo Xie <xiaobo.xie@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Rob
 Herring <robh+dt@kernel.org>,  "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>, Claudiu Manoil <claudiu.manoil@freescale.com>,
 Yangbo Lu <yangbo.lu@nxp.com>, Kumar Gala <galak@codeaurora.org>, Yang-Leo
 Li <leoyang.li@nxp.com>,  "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Qiang Zhao <qiang.zhao@nxp.com>
Date: Fri, 10 Jun 2016 21:00:16 -0500
In-Reply-To: <3851136.KiJNtFycNm@wuerfel>
References: <1462417950-46796-1-git-send-email-yangbo.lu@nxp.com>
 <6110875.0k1HlSKhzn@wuerfel> <1464829874.16584.163.camel@buserror.net>
 <3851136.KiJNtFycNm@wuerfel>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 3/4] mmc: sdhci-of-esdhc: fix host version for
 T4240-R1.0-R2.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-06-02 at 10:52 +0200, Arnd Bergmann wrote:
> On Wednesday, June 1, 2016 8:11:14 PM CEST Scott Wood wrote:
> > > +#define T4240_HOST_VER ((VENDOR_V_23 << SDHCI_VENDOR_VER_SHIFT) |
> > > SDHCI_SPEC_200)
> > > +static const struct soc_device_attribute esdhc_t4240_quirk = {
> > > +     /* T4240 revision < 0x20 uses vendor version 23, SDHCI version 200
> > > */
> > > +     { .soc_id = "T4*(0x824000)", .revision = "0x[01]?",
> > > +       .data = (void *)(uintptr_t)(T4240_HOST_VER) },
> > 
> > Why should this code need to care that the string begins with "T4"?  This
> > creates dual maintenance if that were to change.  It's also broken because
> > T4240 has compatible = "fsl,t4240-device-config", "fsl,qoriq-device-config
> > -2.0" and thus with these patches it would incorrectly show up as "P
> > series
> > (0x824000)".  The compatible string of this node was never meant to be a
> > key
> > for choosing a string to describe the system to userspace.
> 
> This is an artifact of not knowing the specific SoC name, and we can change
> that by looking up the name from the SVR value in the soc_device driver.

...or we could keep it simple and just match the number.

> > 0x824000 is a magic number which should be represented symbolically.
> 
> Sure, feel free to change the format of the soc_device string in any
> name,

That's not what I was asking for...  The match should be numeric but the
knowledge of what the number is should come from a symbolic #define.

> > If T4240 is affected, then so are the reduced-core variants T4160 and
> > T4080,
> > but 0x824000 doesn't match them (Yangbo's patch had the same problem). 
> >  And
> > please don't respond with "0x824*"
> > 
> > You also didn't strip out the E bit of SVR which indicates encryption
> > capability and nothing else (Yangbo's patch did not have this problem
> > because
> > it used SVR_SOC_VER).
> 
> Ok, that should be easy enough to fix in the soc_device driver.

No, because the soc_device driver doesn't know whether the consumer of the ID
cares about the E bit.

> > What happens if the revision condition is more complicated, such as <=
> > 0x20
> > with 0x21 being fine?  Multiple quirk entries where before we had as
> > simple
> > comparison?
> 
> I guess yes. I would really hope that there is no need to use this interface
> pervasively, it's really just to work around the cases where there is no
> way to pass the information in DT otherwise.

How does putting it in the DT work when you have multiple versions of the same
SoC, some of which have the bug and some which don't?

> > I fail to see how this approach is an improvement (much less one that
> > needs to
> > hold up a patchset that is fixing a problem and is not touching any
> > generic
> > code).  Why does this need to be a string?
> 
> A string is what user space gets in /sys/devices/soc/*,

It is rare that the kernel accesses information in the exact same way that
userspace does.  And once we expose this to userspace we're stuck with it, so
exporting anything other than a simple number is even less desirable.

>  and we already have
> code that does the same things there to work around quirks, here we just
> use the same interface in a completely generic way. Note that not every
> SoC family uses numbers in the same way, some have multiple subrevisions,
> some have names etc.

Where is the need for a "completely generic way" for one piece of vendor
-specific code to get information that is inherently specific to that vendor,
that is supplied by code specific to that vendor?

-Scott
