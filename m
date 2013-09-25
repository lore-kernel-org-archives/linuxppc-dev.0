Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 57F892C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 09:09:48 +1000 (EST)
Received: from mail111-co9 (localhost [127.0.0.1])	by
 mail111-co9-R.bigfish.com (Postfix) with ESMTP id D0465A40117	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 23:09:43 +0000 (UTC)
Received: from CO9EHSMHS022.bigfish.com (unknown [10.236.132.239])	by
 mail111-co9.bigfish.com (Postfix) with ESMTP id 0EFDB100040	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 23:09:42 +0000 (UTC)
Message-ID: <1380150578.24959.213.camel@snotra.buserror.net>
Subject: Re: [PATCH V4 3/3] powerpc/85xx: Add TWR-P1025 board support
From: Scott Wood <scottwood@freescale.com>
To: Xie Xiaobo-R63061 <r63061@freescale.com>
Date: Wed, 25 Sep 2013 18:09:38 -0500
In-Reply-To: <69EC9ED88E3CC04094A78F8074A7986D5FF91C@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1380019739-8196-1-git-send-email-X.Xie@freescale.com>
 <1380019739-8196-3-git-send-email-X.Xie@freescale.com>
 <1380064944.24959.143.camel@snotra.buserror.net>
 <69EC9ED88E3CC04094A78F8074A7986D5FF91C@039-SN1MPN1-003.039d.mgd.msft.net>
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

On Wed, 2013-09-25 at 04:50 -0500, Xie Xiaobo-R63061 wrote:
> Hi Scott,
> 
> See the reply inline.
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, September 25, 2013 7:22 AM
> > To: Xie Xiaobo-R63061
> > Cc: linuxppc-dev@lists.ozlabs.org; Johnston Michael-R49610
> > Subject: Re: [PATCH V4 3/3] powerpc/85xx: Add TWR-P1025 board support
> > 
> > On Tue, 2013-09-24 at 18:48 +0800, Xie Xiaobo wrote:
> > > +		partition@80000 {
> > > +			/* 3.5 MB for Linux Kernel Image */
> > > +			reg = <0x00080000 0x00380000>;
> > > +			label = "NOR Linux Kernel Image";
> > > +		};
> > 
> > Is this enough?
> 
> I will enlarge it to 6MB.
>  
> > 
> > > +		partition@400000 {
> > > +			/* 58.75MB for JFFS2 based Root file System */
> > > +			reg = <0x00400000 0x03ac0000>;
> > > +			label = "NOR Root File System";
> > > +		};
> > 
> > Don't specify jffs2.
> 
> OK, I will remove "jffs2"
> 
> > 
> > > +	/* CS2 for Display */
> > > +	ssd1289@2,0 {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <1>;
> > > +		compatible = "ssd1289";
> > > +		reg = <0x2 0x0000 0x0002
> > > +		       0x2 0x0002 0x0002>;
> > > +	};
> > 
> > Node names should be generic.  What does ssd1289 do?  If this is actually
> > the display device, then it should be called "display@2,0".
> 
> OK. The ssd1289 is a LCD controller.
> 
> > 
> > How about a vendor prefix on that compatible?  Why #address-cells/#size-
> > cells despite no child nodes?  Where is a binding that says what each of
> > those two reg resources mean?
> 
> I will add the vendor prefix. I review the ssd1289 driver, and the #address-cells/#size-cells were un-used. I will remove them.

And a binding?

Why do you need two separate reg resources rather than just <2 0 4>?
Will they ever be discontiguous?

-Scott
