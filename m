Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6xky0QXqzDqN4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 16:36:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: BUILD_BUG_ON(!__builtin_constant_p(feature)) breaks bcc trace tool
In-Reply-To: <20170121120339.1c774b28@kryten>
References: <20170121120339.1c774b28@kryten>
Date: Tue, 24 Jan 2017 16:36:57 +1100
Message-ID: <87sho99fye.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> writes:
> We added:
>
> BUILD_BUG_ON(!__builtin_constant_p(feature)) 
>
> to cpu_has_feature() and mmu_has_feature() in order to catch usage
> issues (such as cpu_has_feature(cpu_has_feature(X)). Unfortunately LLVM
> isn't smart enough to resolve this, and it errors out.
>
> I work around it in my clang/LLVM builds of the kernel, but I have just
> discovered that it causes a lot of issues for the bcc (eBPF) trace tool
> (which uses LLVM).

I didn't understand that part, but Aneesh explained to me that it's
because bcc pulls in the kernel-internal headers.

I guess as a quick fix we just have to #ifdef it, can you confirm this
works?


diff --git a/arch/powerpc/include/asm/cpu_has_feature.h b/arch/powerpc/include/asm/cpu_has_feature.h
index b312b152461b..6e834caa3720 100644
--- a/arch/powerpc/include/asm/cpu_has_feature.h
+++ b/arch/powerpc/include/asm/cpu_has_feature.h
@@ -23,7 +23,9 @@ static __always_inline bool cpu_has_feature(unsigned long feature)
 {
 	int i;
 
+#ifndef __clang__ /* clang can't cope with this */
 	BUILD_BUG_ON(!__builtin_constant_p(feature));
+#endif
 
 #ifdef CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG
 	if (!static_key_initialized) {
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index a34c764ca8dd..233a7e8cc8e3 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -160,7 +160,9 @@ static __always_inline bool mmu_has_feature(unsigned long feature)
 {
 	int i;
 
+#ifndef __clang__ /* clang can't cope with this */
 	BUILD_BUG_ON(!__builtin_constant_p(feature));
+#endif
 
 #ifdef CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG
 	if (!static_key_initialized) {


cheers
