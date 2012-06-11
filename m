Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78C5AB6FC2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 06:15:46 +1000 (EST)
Message-ID: <4FD65198.7000808@freescale.com>
Date: Mon, 11 Jun 2012 15:14:16 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kay One <kayone007@gmail.com>
Subject: Re: [Doubt] PPC Linux Device Tree Update
References: <CAL3nkH-HAwRngz2Ob7R_AB0YSDbSVGi6AWNEEaiwQXbcHvwGSw@mail.gmail.com>
In-Reply-To: <CAL3nkH-HAwRngz2Ob7R_AB0YSDbSVGi6AWNEEaiwQXbcHvwGSw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/2012 02:52 AM, Kay One wrote:
> Hi All,
> 
> Currently I am working on p1020rdb soc for some kernel bringing up activity.
> I have come across one requirement to update the memory map (MMAP) of
> kernel from evaluation board to
> some other board who is having the same soc.
> 
> for my eval board I have used the p1020rdb.dts file from 2.6.38 standard
> kernel source.

Why not start with the latest version?

> (PFA) which is working almost fine.
> But, I am really not able to find the following mapping as a part of the
> attached dts file what I am using.
> Can anyone please point me out that dts file is the only one to search
> out following base addresses selected in memory map or is there
> some specific file of kernel inside which I will be able to search
> through to find the following base addresses?
> 
> FFFF_F000 	4 KB 	.bootpg

This is not expressed in the device tree, though it is marked reserved
by U-Boot in the reserve map (part of the dtb, but not part of the
actual tree).

> FFE0_0000 	1 MB 	CCSR

That's the "soc" node.

> EC00_0000 	64 MB 	Flash + alias

/localbus@ffe05000/nor@0,0/

...but it's at 0xef00_0000 according to the tree you attached.

Read the ePAPR spec for a description of how the ranges property works.

> 8000_0000 	1 GB 	PCI[1:2] mem
> FFC0_0000 	256 KB 	PCI[1:2] I/O

These are encoded in the ranges property of the relevant PCIe node (see
version 1.0 of the ePAPR spec for how), but I don't see one with those
specific addresses.  I don't know what the [1:2] is supposed to mean.

> FFB0_0000 	1 MB 	VTSS

/localbus@ffe05000/L2switch@2,0/

> FFA0_0000 	1 MB 	CPLD

Not represented in the device tree.  The device tree shows NAND at this
address.

> FF80_0000 	1 MB 	NAND

/localbus@ffe05000/nand@1,0/

...but with a different address, as noted above.

> 0000_0000 	1 GB 	DDR

/memory

U-Boot fills in the reg property.

-Scott
