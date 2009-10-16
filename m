Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 17939B7BB6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Oct 2009 03:17:40 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9GGHbw4010461 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Oct 2009 09:17:37 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n9GGKWCo005083
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Oct 2009 11:20:32 -0500 (CDT)
Message-ID: <4AD89CBB.6040600@freescale.com>
Date: Fri, 16 Oct 2009 11:18:03 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Roberto Guerra <roberto.j.guerra@gmail.com>
Subject: Re: Support for S29JL064 in MPC8272ADS?
References: <7c4144600910090714g524bad07ubf6cad3aaf8085ff@mail.gmail.com>	
	<20091009170433.GA17372@b07421-ec1.am.freescale.net>	
	<7c4144600910091059o492c870cn3ea1c1a96d2f0823@mail.gmail.com>	
	<20091009181617.GA14304@loki.buserror.net>	
	<7c4144600910141434y26972dbbnb776c4ef89d15a17@mail.gmail.com>	
	<4AD6454C.60705@freescale.com>
	<7c4144600910160837y3d70ccd2yeeeb220da7e556c3@mail.gmail.com>
In-Reply-To: <7c4144600910160837y3d70ccd2yeeeb220da7e556c3@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Roberto Guerra wrote:
> mtdparts=phys:1600K(ROM)ro,6M(root),512K(U-Boot)ro,512K(unused)
> rootfstype=jffs2
> => bootm 200000 - 400000
> <snip>
> physmap platform flash device: 00800000 at ff800000
> physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
>  Amd/Fujitsu Extended Query Table at 0x0040
> physmap-flash.0: CFI does not contain boot bank location. Assuming
> top.

Hmm, you seem to be using physmap rather than physmap_of -- so it won't 
even be looking at your device tree node.

> List of all partitions:
> 0100       4096 ram0 (driver?)
> 0101       4096 ram1 (driver?)
> 0102       4096 ram2 (driver?)
> 0103       4096 ram3 (driver?)
> 0104       4096 ram4 (driver?)
> 0105       4096 ram5 (driver?)
> 0106       4096 ram6 (driver?)
> 0107       4096 ram7 (driver?)
> 0108       4096 ram8 (driver?)
> 0109       4096 ram9 (driver?)
> 010a       4096 ram10 (driver?)
> 010b       4096 ram11 (driver?)
> 010c       4096 ram12 (driver?)
> 010d       4096 ram13 (driver?)
> 010e       4096 ram14 (driver?)
> 010f       4096 ram15 (driver?)

Where are all these coming from?

> The key change in my kernel config was the BIG_ENDIAN=Y.
> The kernel probes the AMD chip, but it can't see the partitions.

Even without partiitons, you should see the whole flash device...

> I guess now I will have to define my mtd partitions in either FDT or
> in the kernel arguments.
> Which is the best way to define them?

If you're defining a standard layout for the platform that's unlikely to 
change, I'd go with the device tree.  Otherwise, I'd go with whatever's 
most convenient.

> If the partitions are defined in
> both FDT and bootargs, which one takes precedence?

The command line takes precedence.

-Scott
