Return-Path: <anton@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A1B982C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 17:19:12 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anton@au1.ibm.com>;
 Wed, 12 Feb 2014 16:19:12 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E862F2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 17:19:09 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1C5xfZT1179990
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 16:59:41 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1C6J8GH017905
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Feb 2014 17:19:09 +1100
Date: Wed, 12 Feb 2014 17:18:50 +1100
From: Anton Blanchard <anton@au1.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 amodra@gmail.com
Subject: [PATCH 2/2] powerpc: Use unstripped VDSO image for more accurate
 profiling data
Message-ID: <20140212171850.2b209e47@kryten>
In-Reply-To: <20140212171705.71d2bd7c@kryten>
References: <20140212171705.71d2bd7c@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We are seeing a lot of hits in the VDSO that are not resolved by perf.
A while(1) gettimeofday() loop shows the issue:

27.64%  [vdso]  [.] 0x000000000000060c                        
22.57%  [vdso]  [.] 0x0000000000000628                        
16.88%  [vdso]  [.] 0x0000000000000610                        
12.39%  [vdso]  [.] __kernel_gettimeofday                     
 6.09%  [vdso]  [.] 0x00000000000005f8                        
 3.58%  test    [.] 00000037.plt_call.gettimeofday@@GLIBC_2.18
 2.94%  [vdso]  [.] __kernel_datapage_offset                  
 2.90%  test    [.] main                                      

We are using a stripped VDSO image which means only symbols with
relocation info can be resolved. There isn't a lot of point to
stripping the VDSO, the debug info is only about 1kB:

4680 arch/powerpc/kernel/vdso64/vdso64.so
5815 arch/powerpc/kernel/vdso64/vdso64.so.dbg

By using the unstripped image, we can resolve all the symbols in the
VDSO and the perf profile data looks much better:

76.53%  [vdso]  [.] __do_get_tspec                            
12.20%  [vdso]  [.] __kernel_gettimeofday                     
 5.05%  [vdso]  [.] __get_datapage                            
 3.20%  test    [.] main                                      
 2.92%  test    [.] 00000037.plt_call.gettimeofday@@GLIBC_2.18

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/arch/powerpc/kernel/vdso32/vdso32_wrapper.S b/arch/powerpc/kernel/vdso32/vdso32_wrapper.S
index 6e8f507..37e2e13 100644
--- a/arch/powerpc/kernel/vdso32/vdso32_wrapper.S
+++ b/arch/powerpc/kernel/vdso32/vdso32_wrapper.S
@@ -7,7 +7,7 @@
 	.globl vdso32_start, vdso32_end
 	.balign PAGE_SIZE
 vdso32_start:
-	.incbin "arch/powerpc/kernel/vdso32/vdso32.so"
+	.incbin "arch/powerpc/kernel/vdso32/vdso32.so.dbg"
 	.balign PAGE_SIZE
 vdso32_end:
 
diff --git a/arch/powerpc/kernel/vdso64/vdso64_wrapper.S b/arch/powerpc/kernel/vdso64/vdso64_wrapper.S
index b8553d6..01e7799 100644
--- a/arch/powerpc/kernel/vdso64/vdso64_wrapper.S
+++ b/arch/powerpc/kernel/vdso64/vdso64_wrapper.S
@@ -7,7 +7,7 @@
 	.globl vdso64_start, vdso64_end
 	.balign PAGE_SIZE
 vdso64_start:
-	.incbin "arch/powerpc/kernel/vdso64/vdso64.so"
+	.incbin "arch/powerpc/kernel/vdso64/vdso64.so.dbg"
 	.balign PAGE_SIZE
 vdso64_end:
 
