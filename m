Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E4CB0B7B88
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  8 Aug 2009 07:03:27 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 343FCDDD0B
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Aug 2009 07:03:26 +1000 (EST)
Subject: Re: sequoia: The final kernel image would overwrite the device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <alpine.LRH.2.00.0908071740410.22357@vixen.sonytel.be>
References: <alpine.LRH.2.00.0907281524510.29006@vixen.sonytel.be>
	<alpine.LRH.2.00.0908071740410.22357@vixen.sonytel.be>
Content-Type: text/plain
Date: Sat, 08 Aug 2009 07:03:11 +1000
Message-Id: <1249678991.10143.1.camel@pasglop>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-08-07 at 17:48 +0200, Geert Uytterhoeven wrote:
> | Allocating 0x85e784 bytes for kernel ...
> | platform_ops.vmlinux_alloc = 0x00000000
> | _end = 0x792000
> | The final kernel image would overwrite the device tree?
> 
> and it reboots.
> 
> However, nm says _end = c085f000.
> 
> So in both cases _end is not correct in
> arch/powerpc/boot/main.c:prep_kernel()?
> But depending on CONFIG_PROVE_LOCKING, the test for
> ((unsigned long)_end < ei.memsize) gives different results, and the
> kernel
> boots or doesn't boot?
> 
Well, "Allocating 0x85e784" looks right...

My experience, however, with a Canyonlands board, is that uBoot has
a bug that makes it always allocate the device-tree below 8M and clash
with the kernel when it gets too big.

I think Stefan fixed that recently, you may need to rebuild your uboot,
I'll let him tell you the details about the fix.

Cheers,
Ben.
