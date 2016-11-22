Return-Path: <chunkeey@googlemail.com>
Received: from mail-wj0-x243.google.com (mail-wj0-x243.google.com
 [IPv6:2a00:1450:400c:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNd1c6pjlzDvwl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 07:51:48 +1100 (AEDT)
Received: by mail-wj0-x243.google.com with SMTP id xy5so7230801wjc.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 12:51:48 -0800 (PST)
From: Christian Lamparter <chunkeey@googlemail.com>
To: John Youn <John.Youn@synopsys.com>
Cc: Christian Lamparter <chunkeey@googlemail.com>,
 Rob Herring <robh@kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>,
 Felipe Balbi <balbi@kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 2/4] usb: dwc2: Add binding for AHB burst
Date: Tue, 22 Nov 2016 21:51:42 +0100
Message-ID: <1495076.fZ1uLW9fli@debian64>
In-Reply-To: <0677657e-043d-c6d4-783e-9b471d12afcb@synopsys.com>
References: <cover.1479339900.git.johnyoun@synopsys.com>
 <2016796.9qgSSGQn9z@debian64>
 <0677657e-043d-c6d4-783e-9b471d12afcb@synopsys.com>
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

On Monday, November 21, 2016 7:32:30 PM CET John Youn wrote:
> On 11/21/2016 1:10 PM, Christian Lamparter wrote:
> > On Monday, November 21, 2016 12:16:31 PM CET John Youn wrote:
> >> On 11/18/2016 12:18 PM, Christian Lamparter wrote:
> >>> On Friday, November 18, 2016 8:16:08 AM CET Rob Herring wrote:
> >>>> Also, perhaps you should allow that the compatible string can define the 
> >>>> default.
> >>>>
> >>> I hoped you would say that :).
> >>>
> >>> I've attached a patch (on top of John Youn changes) [...]
> >>> ---
> >>> Subject: [PATCH] usb: dwc2: add a default ahb-burst setting for amcc,dwc-otg
> >>> [...]
> >>> @@ -1097,6 +1097,22 @@ static const char *const ahb_bursts[] = {
> >>> +/* [...] */
> >>> +static const struct of_device_id dwc2_compat_ahb_bursts[] = {
> >>> +	{
> >>> +		.compatible = "amcc,dwc-otg",
> >>> +		.data = (void *) GAHBCFG_HBSTLEN_INCR16,
> >>> +	},
> >>> +};
> [...]
> > >>> @@ -1107,6 +1123,12 @@ static int dwc2_get_property_ahb_burst(struct dwc2_hsotg *hsotg)
> >>>  	ret = device_property_read_string(hsotg->dev, "snps,ahb-burst", &str);
> >>>  	if (ret < 0) {
> >>> +		const struct of_device_id *match;
> >>> +
> >>> +		match = of_match_node(dwc2_compat_ahb_bursts, node);
> >>> +		if (match)
> >>> +			ret = (int)match->data;
> >>> +
> [...]
> >> I'd prefer if you use the binding which requires no extra code in
> >> dwc2.
> > I'm fine with either option. However it think that this would require
> > that either Mark or Rob would allow an exception to the "keep existing
> > dts the way they are) and ack the following change to the canyonlands.dts. 
> 
> I don't know about that. Under what circumstance can the dts change?
As far as I know, the justification for not changing the DTS is that a
compiled DTB might be stored in an read-only ROM on a board. So it would
be impossible to update it. Hence, the driver have work with the existing
(and sometimes buggy or incomplete) information to stay compatible.

(Note: Thankfully, the canyonlands dtb is stored in flash, it's possible
to update it. But it is an extra step that's not done automatically
with make install). 

> The canyonlands dts was binding to an external vendor driver. So it
> wasn't documented nor expected to work with dwc2 until your recent
> patch adding the compatible string.

Oh, no that's not what happend. Let me explain why there was no "external 
vendor driver": AMCC/APM were planing to upstream their hole platform. And
in fact, the devs tried very hard to include their driver back in 2011 [0].
But this driver was denied inclusion back then due to:

"[...]
I would also like to point out that the same Synopsys USB controller
is used in a number of other SoCs (especially ARM chips), and
supported by other drivers, some of these even in mainline.

See http://thread.gmane.org/gmane.linux.usb.general/61714/focus=62139
for a related thread.

Instead of trying to add a completely new driver to mainline (and one
which has been repeatedly been rejected), I vote for focusing on the
existing driver code that is already in mainline, and testing and
improving this so we can use a single implementation of this driver
code for all SoCs that use the same IP block." [1]

Of course: The listed link goes the "USB Host driver for i.MX28" driver.
And this is an ehci-hcd like driver... Which is as you are well aware not
that similar to the dwc2 OTG. And as far as I can tell: AMCC abandoned
the patch series right there. 

Note: AMCC did however succeed in pushing your employer's Synopsys
DesignWare SATA and DMA drivers to the kernel back then. And I'm happy
to report that both drivers are still around and working fine for the 460EX 
(sata_dwc_460ex.c[2] and the DW AHB DMA [3]). (The drivers also work for
different platforms than the original PPC. I know that because I helped
Andy Shevchenko with testing and pushing some fixes to it when he was
adding support for the Intel Quark SoC, which uses the DWC SATA and DMA).

So Please?
> Systems that use the vendor driver will still work with the dts. If
> you remove the vendor driver and configure it to use dwc2, it won't
> work due to a quirk of the canyonlands hardware, for which you need to
> add a dts property.
Sadly, there is no up to date vendor driver. The canyonlands.dts binding
is still in place and the hardware works fine. I'm interested in this
platform since it is a cheap BigEndian system which is useful for usb
driver development (carl9170 and rtl8192su)... and I would like to
have out-of-the-box support.

> I think this is reasonable. Rob or Mark, any feedback?
I recall that Rob has already voiced his opinion about the ahb-burst setting: 
"Also, perhaps you should allow that the compatible string can define the default."

And based on that, I made the "add a default ahb-burst setting for amcc,dwc-otg"
patch above. Of course, it would be nice to have any feedback too. But unless I
hear otherwise, I'll continue with posting patches to the dwc2 driver :). 

> One of the reasons I don't want to add the code in dwc2 is because I'm
> trying to make dwc2 a generic IP driver like dwc3.
I understand that. And let me say, that I also have a dwc3 in my IPQ4019. 
And adding support for it was as simple as adding just one compatible
binding in dwc-of-simple [4].

Regards,
Christian

[0] <http://thread.gmane.org/gmane.linux.usb.general/53348/focus=53913>
[1] <https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-May/097850.html>
[2] <http://lxr.free-electrons.com/source/drivers/ata/sata_dwc_460ex.c>
[3] <http://lxr.free-electrons.com/source/drivers/dma/dw/core.c>
[4] <https://github.com/chunkeey/LEDE-IPQ40XX/blob/staging/target/linux/ipq40xx/patches-4.8/830-usb-dwc3-register-qca-ipq4019-dwc3-in-dwc3-of-simple.patch>
