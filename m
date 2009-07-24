Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7265CB7CE8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 19:15:40 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 24 Jul 2009 19:15:27 +1000
Subject: [PATCH 10/20] powerpc: Clean ifdef usage in copy_thread()
In-Reply-To: <1248426902.401617.944220131651.qpush@grosgo>
Message-Id: <20090724091540.60EC6DDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, a single ifdef covers SLB related bits and more generic ppc64
related bits, split this in two separate ifdef's since 64-bit BookE will
need one but not the other.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/process.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-work.orig/arch/powerpc/kernel/process.c	2009-07-22 16:30:49.000000000 +1000
+++ linux-work/arch/powerpc/kernel/process.c	2009-07-22 16:31:02.000000000 +1000
@@ -664,6 +664,7 @@ int copy_thread(unsigned long clone_flag
 		sp_vsid |= SLB_VSID_KERNEL | llp;
 		p->thread.ksp_vsid = sp_vsid;
 	}
+#endif /* CONFIG_PPC_STD_MMU_64 */
 
 	/*
 	 * The PPC64 ABI makes use of a TOC to contain function 
@@ -671,6 +672,7 @@ int copy_thread(unsigned long clone_flag
 	 * to the TOC entry.  The first entry is a pointer to the actual
 	 * function.
  	 */
+#ifdef CONFIG_PPC64
 	kregs->nip = *((unsigned long *)ret_from_fork);
 #else
 	kregs->nip = (unsigned long)ret_from_fork;
