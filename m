Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5AD64B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2012 14:25:17 +1100 (EST)
Received: from mail31-tx2 (localhost [127.0.0.1])	by mail31-tx2-R.bigfish.com
 (Postfix) with ESMTP id 3AEC21340458	for
 <linuxppc-dev@lists.ozlabs.org>;
 Thu, 15 Mar 2012 03:25:14 +0000 (UTC)
Received: from TX2EHSMHS025.bigfish.com (unknown [10.9.14.246])	by
 mail31-tx2.bigfish.com (Postfix) with ESMTP id 2D76715C0047	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2012 03:25:12 +0000 (UTC)
Date: Wed, 14 Mar 2012 22:25:09 -0500
From: Scott Wood <scottwood@freescale.com>
To: Huang Changming-R66093 <r66093@freescale.com>
Subject: Re: [PATCH 4/4] powerpc/85xx: add the P1020UTM-PC DTS support
Message-ID: <20120315032509.GA16517@schlenkerla.am.freescale.net>
References: <1331716110-25545-1-git-send-email-Chang-Ming.Huang@freescale.com>
 <1331716110-25545-2-git-send-email-Chang-Ming.Huang@freescale.com>
 <1331716110-25545-3-git-send-email-Chang-Ming.Huang@freescale.com>
 <1331716110-25545-4-git-send-email-Chang-Ming.Huang@freescale.com>
 <4F60E86C.7000603@freescale.com>
 <110EED8CC96DFC488B7E717A2027A27C04CBF1@039-SN1MPN1-003.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C04CBF1@039-SN1MPN1-003.039d.mgd.msft.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2012 at 09:30:27PM -0500, Huang Changming-R66093 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, March 15, 2012 2:50 AM
> > To: Huang Changming-R66093
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH 4/4] powerpc/85xx: add the P1020UTM-PC DTS support
> > 
> > On 03/14/2012 04:08 AM, Chang-Ming.Huang@freescale.com wrote:
> > > +&lbc {
> > > +	nor@0,0 {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <1>;
> > > +		compatible = "cfi-flash";
> > > +		reg = <0x0 0x0 0x2000000>;
> > > +		bank-width = <2>;
> > > +		device-width = <1>;
> > > +
> > > +		partition@0 {
> > > +			/* 256KB for DTB Image */
> > > +			reg = <0x0 0x00040000>;
> > > +			label = "NOR (RO) DTB Image";
> > > +			read-only;
> > > +		};
> > > +
> > > +		partition@40000 {
> > > +			/* 3.75 MB for Linux Kernel Image */
> > > +			reg = <0x00040000 0x003c0000>;
> > > +			label = "NOR (RO) Linux Kernel Image";
> > > +			read-only;
> > > +		};
> > > +
> > > +		partition@400000 {
> > > +			/* 27MB for Root file System */
> > > +			reg = <0x00400000 0x01b00000>;
> > > +			label = "NOR (RW) Root File System";
> > > +		};
> > > +
> > > +		partition@1f00000 {
> > > +			/* This location must not be altered  */
> > > +			/* 512KB for u-boot Bootloader Image */
> > > +			/* 512KB for u-boot Environment Variables */
> > > +			reg = <0x01f00000 0x00100000>;
> > > +			label = "NOR (RO) U-Boot Image";
> > > +			read-only;
> > > +		};
> > 
> > Don't put (RW) or (RO) in the label; that information is already there in
> > the read-only property.
> But for the user, after booting the kernel, he don't know these partition are read-only or can be wrote. 
> If add (RW) or (RO), user can know which partition can be wrote or can't directly.

So fix the Linux MTD code to properly tell the user the read-only status
of any partition.

-Scott
