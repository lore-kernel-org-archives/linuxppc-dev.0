Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 91CA2B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 02:07:21 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7HG76xo017046
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 12:07:06 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7HG7Gsq248762
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 12:07:16 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7HG7F0T012745
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2009 12:07:16 -0400
Date: Mon, 17 Aug 2009 12:07:13 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] powerpc: Fix __flush_icache_range on 44x
Message-ID: <20090817160713.GE8710@zod.rchland.ibm.com>
References: <20090817134136.GB8710@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090817134136.GB8710@zod.rchland.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 17, 2009 at 09:41:36AM -0400, Josh Boyer wrote:
>The ptrace POKETEXT interface allows a process to modify the text pages of
>a child process being ptraced, usually to insert breakpoints via trap
>instructions.  The kernel eventually calls copy_to_user_page, which in turn
>calls __flush_icache_range to invalidate the icache lines for the child
>process.
>
>However, this function does not work on 44x due to the icache being virtually
>indexed.  This was noticed by a breakpoint being triggered after it had been
>cleared by ltrace on a 440EPx board.  The convenient solution is to do a
>flash invalidate of the icache in the __flush_icache_range function.
>
>Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>
>---
>
>diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
>index 15f28e0..c9805a4 100644
>--- a/arch/powerpc/kernel/misc_32.S
>+++ b/arch/powerpc/kernel/misc_32.S
>@@ -346,6 +346,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
> 2:	icbi	0,r6
> 	addi	r6,r6,L1_CACHE_BYTES
> 	bdnz	2b
>+#ifdef CONFIG_44x
>+	iccci	r0, r0
>+#endif

Olof pointed out that we could probably do the iccci before the icbi loop and
just skip that loop entirely on 44x.  This is most certainly valid, but at
this particular moment I don't have time to try and reproduce the issue with
an alternative fix and I wanted to get _something_ out there to fix the issue.  

I suck for that, I know.

josh
