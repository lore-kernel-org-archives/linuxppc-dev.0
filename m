Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0136.outbound.protection.outlook.com [157.56.110.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDB321A0AB3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 08:34:21 +1000 (AEST)
Message-ID: <1428446044.22867.475.camel@freescale.com>
Subject: Re: Old regression with MTD devices disappearing from a Kurobox HD/HG
From: Scott Wood <scottwood@freescale.com>
To: =?ISO-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Date: Tue, 7 Apr 2015 17:34:04 -0500
In-Reply-To: <20150404054022.GA15572@ime.usp.br>
References: <20150404054022.GA15572@ime.usp.br>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-04-04 at 02:40 -0300, Rogério Brito wrote:
> Unfortunately, right now, what I see with Linus's tree
> (4.0.0-rc6-00009-g6c310bc) is the following:
> 
> ,----
> | physmap platform flash device: 00400000 at ffc00000
> | physmap-flash.0: Found 1 x16 devices at 0x0 in 8-bit bank. Manufacturer ID 0x000004 Chip ID 0x00007e
> | Amd/Fujitsu Extended Query Table at 0x0040
> |   Amd/Fujitsu Extended Query version 1.3.
> | physmap-flash.0: Swapping erase regions for top-boot CFI table.
> | number of CFI chips: 1
> `----
> 
> I note that arch/powerpc/boot/dts/kuroboxH{D,G}.dts have, as one of their
> first lines, the following comment: [0][1]
> 
>     XXXX add flash parts, rtc, ??
> 
> [0]: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/boot/dts/kuroboxHD.dts?id=1cced5015b171415169d938fb179c44fe060dc15#n17
> [1]: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/boot/dts/kuroboxHG.dts?id=1cced5015b171415169d938fb179c44fe060dc15#n17
> 
> Is this a problem that can be fixed via additions to the DTS files?  Or
> would the problem be solved in a different way?

What are your bootargs?

I suggest putting the flash device into the dts (instead of using
physmap), and specifying the partitions on the command-line using
mtdparts.  Putting the partitions in the dts is an option as well, but
less flexible if users may want to change the partition layout -- though
that may be less of a concern here than with reference boards.

-Scott
