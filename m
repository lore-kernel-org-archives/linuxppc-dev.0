Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sT5vP4jl2zDrvH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 22:46:41 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc <linux-mmc@vger.kernel.org>,
 Scott Wood <oss@buserror.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Russell King <linux@arm.linux.org.uk>, Jochen Friedrich <jochen@scram.de>,
 Joerg Roedel <joro@8bytes.org>, Claudiu Manoil <claudiu.manoil@freescale.com>,
 Bhupesh Sharma <bhupesh.sharma@freescale.com>, Qiang Zhao <qiang.zhao@nxp.com>,
 Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 Yang-Leo Li <leoyang.li@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>
Subject: Re: [v11, 7/8] base: soc: introduce soc_device_match() interface
Date: Tue, 06 Sep 2016 14:46:08 +0200
Message-ID: <6515108.aCEls7dUuW@wuerfel>
In-Reply-To: <CAPDyKFrvg3Qr5m3xXvywsCoVvaiF7ggHAj0Aw=WCOXg65Pt0PQ@mail.gmail.com>
References: <1473150503-9550-1-git-send-email-yangbo.lu@nxp.com>
 <1473150503-9550-8-git-send-email-yangbo.lu@nxp.com>
 <CAPDyKFrvg3Qr5m3xXvywsCoVvaiF7ggHAj0Aw=WCOXg65Pt0PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, September 6, 2016 1:44:23 PM CEST Ulf Hansson wrote:
> On 6 September 2016 at 10:28, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> > We keep running into cases where device drivers want to know the exact
> > version of the a SoC they are currently running on. In the past, this has
> > usually been done through a vendor specific API that can be called by a
> > driver, or by directly accessing some kind of version register that is
> > not part of the device itself but that belongs to a global register area
> > of the chip.

Please add "From: Arnd Bergmann <arnd@arndb.de>" as the first line, to
preserve authorship. If you use "git send-email" or "git format-patch",
that should happen automatically if the author field is set right
(if not, use 'git commit --amend --author="Arnd Bergmann <arnd@arndb.de>"'
to fix it).

> > +
> > +/*
> > + * soc_device_match - identify the SoC in the machine
> > + * @matches: zero-terminated array of possible matches
> 
> Perhaps also express the constraint on the matching entries. As you
> need at least one of the ->machine(), ->family(), ->revision() or
> ->soc_id() callbacks implemented, right!?

They are not callbacks, just strings. Having an empty entry indicates
the end of the array, and this is not called.

> > + *
> > + * returns the first matching entry of the argument array, or NULL
> > + * if none of them match.
> > + *
> > + * This function is meant as a helper in place of of_match_node()
> > + * in cases where either no device tree is available or the information
> > + * in a device node is insufficient to identify a particular variant
> > + * by its compatible strings or other properties. For new devices,
> > + * the DT binding should always provide unique compatible strings
> > + * that allow the use of of_match_node() instead.
> > + *
> > + * The calling function can use the .data entry of the
> > + * soc_device_attribute to pass a structure or function pointer for
> > + * each entry.
> 
> I don't get the use case behind this, could you elaborate?
> 
> Perhaps we should postpone adding the .data entry until we actually
> see a need for it?

I think the interface is rather useless without a way to figure
out which entry you got. Almost all users of of_match_node()
actually use the returned ->data field, and I expect this to
be the same here.

> > + */
> > +const struct soc_device_attribute *soc_device_match(
> > +       const struct soc_device_attribute *matches)
> > +{
> > +       struct device *dev;
> > +       int ret;
> > +
> > +       for (ret = 0; ret == 0; matches++) {
> 
> This loop looks a bit weird and unsafe.

Ah, and I thought I was being clever ;-)

> 1) Perhaps using a while loop makes this more readable?
> 2) As this is an exported API, I guess validation of the ->matches
> pointer needs to be done before accessing it.

Sounds fine.

> > +               if (!(matches->machine || matches->family ||
> > +                     matches->revision || matches->soc_id))
> > +                       return NULL;
> > +               dev = NULL;
> 
> There's no need to use a struct device just to assign it to NULL.
> Instead just provide the function below with NULL.
>
> > +               ret = bus_for_each_dev(&soc_bus_type, dev, (void *)matches,
> > +                                      soc_device_match_one);


I don't remember what led to this, I think you are right, we should
just pass NULL as most other callers.

Thanks for the review.

	ARnd
