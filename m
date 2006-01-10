Return-Path: <serue@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D211B689E1
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jan 2006 08:20:27 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0ALKLwn027187
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jan 2006 16:20:21 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id
	k0ALKLu1116076
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jan 2006 16:20:21 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k0ALKL6w007778
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jan 2006 16:20:21 -0500
Date: Tue, 10 Jan 2006 15:20:20 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Message-ID: <20060110212020.GB10837@sergelap.austin.ibm.com>
References: <20060107052221.61d0b600.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060107052221.61d0b600.akpm@osdl.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.15-mm2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Quoting Andrew Morton (akpm@osdl.org):
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm2/

With both this and 2.6.15-mm1, but not with 2.6.15, I get the following
error:

mm/built-in.o(*ABS*+0x39c3c7ac): In function `__crc___handle_mm_fault':
slab.c: multiple definition of `__crc___handle_mm_fault'
make: *** [.tmp_vmlinux1] Error 1

The culprit appears to be that there are two places where
__handle_mm_fault is EXPORT_SYMBOL_GPLed.  The following trivial patch
fixes it for me.

Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Index: linux-2.6.15/arch/powerpc/kernel/ppc_ksyms.c
===================================================================
--- linux-2.6.15.orig/arch/powerpc/kernel/ppc_ksyms.c	2006-01-10 04:59:11.000000000 -0600
+++ linux-2.6.15/arch/powerpc/kernel/ppc_ksyms.c	2006-01-10 09:07:40.000000000 -0600
@@ -240,8 +240,6 @@ EXPORT_SYMBOL(next_mmu_context);
 EXPORT_SYMBOL(set_context);
 #endif
 
-EXPORT_SYMBOL_GPL(__handle_mm_fault);
-
 #ifdef CONFIG_PPC_STD_MMU_32
 extern long mol_trampoline;
 EXPORT_SYMBOL(mol_trampoline); /* For MOL */


thanks,
-serge
