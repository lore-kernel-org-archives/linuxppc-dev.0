Return-Path: <nacc@us.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 5032A1007D5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 10:37:15 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@us.ibm.com>;
 Mon, 7 Nov 2011 18:37:11 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pA7NawBJ2441470
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2011 18:36:58 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pA7Naw4b020416
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2011 21:36:58 -0200
Date: Mon, 7 Nov 2011 15:36:56 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: [PATCH] powerpc/kvm: fix build with older toolchains
Message-ID: <20111107233656.GB20208@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix KVM build for older toolchains (found with .powerpc64-unknown-linux-gnu-gcc
(crosstool-NG-1.8.1) 4.3.2):

  AS      arch/powerpc/kvm/book3s_hv_rmhandlers.o
arch/powerpc/kvm/book3s_hv_rmhandlers.S: Assembler messages:
arch/powerpc/kvm/book3s_hv_rmhandlers.S:1388: Error: Unrecognized opcode: `popcntw'
make[1]: *** [arch/powerpc/kvm/book3s_hv_rmhandlers.o] Error 1
make: *** [_module_arch/powerpc/kvm] Error 2
    
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 0607909..a053db1 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -1385,7 +1385,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_206)
 	addi	r6,r5,VCORE_NAPPING_THREADS
 31:	lwarx	r4,0,r6
 	or	r4,r4,r0
-	popcntw	r7,r4
+	PPC_POPCNTW(r7,r4)
 	cmpw	r7,r8
 	bge	2f
 	stwcx.	r4,0,r6

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
