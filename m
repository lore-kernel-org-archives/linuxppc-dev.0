Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 96C512C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 07:27:30 +1000 (EST)
Received: from mail91-db8 (localhost [127.0.0.1])	by mail91-db8-R.bigfish.com
 (Postfix) with ESMTP id E8FB1DA01D1	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,
 26 Sep 2013 21:27:24 +0000 (UTC)
Received: from DB8EHSMHS030.bigfish.com (unknown [10.174.8.243])	by
 mail91-db8.bigfish.com (Postfix) with ESMTP id 322D0D8004B	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 21:27:22 +0000 (UTC)
Message-ID: <1380230838.24959.322.camel@snotra.buserror.net>
Subject: Re: [PATCH V4 3/3] powerpc/85xx: Add TWR-P1025 board support
From: Scott Wood <scottwood@freescale.com>
To: Xie Xiaobo-R63061 <r63061@freescale.com>
Date: Thu, 26 Sep 2013 16:27:18 -0500
In-Reply-To: <69EC9ED88E3CC04094A78F8074A7986D600530@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1380019739-8196-1-git-send-email-X.Xie@freescale.com>
 <1380019739-8196-3-git-send-email-X.Xie@freescale.com>
 <1380064944.24959.143.camel@snotra.buserror.net>
 <69EC9ED88E3CC04094A78F8074A7986D5FF91C@039-SN1MPN1-003.039d.mgd.msft.net>
 <1380150578.24959.213.camel@snotra.buserror.net>
 <69EC9ED88E3CC04094A78F8074A7986D600530@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Johnston Michael-R49610 <r49610@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-09-26 at 04:27 -0500, Xie Xiaobo-R63061 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, September 26, 2013 7:10 AM
> > To: Xie Xiaobo-R63061
> > Cc: Wood Scott-B07421; linuxppc-dev@lists.ozlabs.org; Johnston Michael-
> > R49610
> > Subject: Re: [PATCH V4 3/3] powerpc/85xx: Add TWR-P1025 board support
> > 
> > On Wed, 2013-09-25 at 04:50 -0500, Xie Xiaobo-R63061 wrote:
> > > Hi Scott,
> > >
> > > See the reply inline.
> > >
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Wednesday, September 25, 2013 7:22 AM
> > > > To: Xie Xiaobo-R63061
> > > > Cc: linuxppc-dev@lists.ozlabs.org; Johnston Michael-R49610
> > > > Subject: Re: [PATCH V4 3/3] powerpc/85xx: Add TWR-P1025 board
> > > > support
> > > >
> > > > On Tue, 2013-09-24 at 18:48 +0800, Xie Xiaobo wrote:
> > > > > +		partition@80000 {
> > > > > +			/* 3.5 MB for Linux Kernel Image */
> > > > > +			reg = <0x00080000 0x00380000>;
> > > > > +			label = "NOR Linux Kernel Image";
> > > > > +		};
> > > >
> > > > Is this enough?
> > >
> > > I will enlarge it to 6MB.
> > >
> > > >
> > > > > +		partition@400000 {
> > > > > +			/* 58.75MB for JFFS2 based Root file System */
> > > > > +			reg = <0x00400000 0x03ac0000>;
> > > > > +			label = "NOR Root File System";
> > > > > +		};
> > > >
> > > > Don't specify jffs2.
> > >
> > > OK, I will remove "jffs2"
> > >
> > > >
> > > > > +	/* CS2 for Display */
> > > > > +	ssd1289@2,0 {
> > > > > +		#address-cells = <1>;
> > > > > +		#size-cells = <1>;
> > > > > +		compatible = "ssd1289";
> > > > > +		reg = <0x2 0x0000 0x0002
> > > > > +		       0x2 0x0002 0x0002>;
> > > > > +	};
> > > >
> > > > Node names should be generic.  What does ssd1289 do?  If this is
> > > > actually the display device, then it should be called "display@2,0".
> > >
> > > OK. The ssd1289 is a LCD controller.
> > >
> > > >
> > > > How about a vendor prefix on that compatible?  Why
> > > > #address-cells/#size- cells despite no child nodes?  Where is a
> > > > binding that says what each of those two reg resources mean?
> > >
> > > I will add the vendor prefix. I review the ssd1289 driver, and the
> > #address-cells/#size-cells were un-used. I will remove them.
> > 
> > And a binding?
> > 
> > Why do you need two separate reg resources rather than just <2 0 4>?
> > Will they ever be discontiguous?
> 
> [Xie] I review the ssd1289 driver code, and found the driver need two reg resources, 

The device tree describes the hardware, not the current state of Linux
drivers.  Especially drivers that aren't yet in Linux. :-)

> if change the dts, the driver also should be modified accordingly. So I
> remove the ssd1289 node from this patch. I will submit new patch
> include the dts modification, ssd1289 driver and the binding.   

Ideally all devices (and bindings) should be described when the device
tree is initally added, regardless of whether you have a driver yet.

-Scott
