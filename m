Return-Path: <rickard_strandqvist@spectrumdigital.se>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 026E61A09D0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 04:54:18 +1100 (AEDT)
Received: by mail-wi0-f170.google.com with SMTP id bs8so5358200wib.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Dec 2014 09:54:15 -0800 (PST)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH] arch: powerpc: kernel: sys_ppc32.c:  Remove unused function
Date: Sun,  7 Dec 2014 18:56:54 +0100
Message-Id: <1417975014-13883-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the function compat_sys_mmap2() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/powerpc/kernel/sys_ppc32.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index 8a28587..8f32cf8 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -61,14 +61,6 @@ asmlinkage long ppc32_select(u32 n, compat_ulong_t __user *inp,
 	return compat_sys_select((int)n, inp, outp, exp, compat_ptr(tvp_x));
 }
 
-unsigned long compat_sys_mmap2(unsigned long addr, size_t len,
-			  unsigned long prot, unsigned long flags,
-			  unsigned long fd, unsigned long pgoff)
-{
-	/* This should remain 12 even if PAGE_SIZE changes */
-	return sys_mmap(addr, len, prot, flags, fd, pgoff << 12);
-}
-
 /* 
  * long long munging:
  * The 32 bit ABI passes long longs in an odd even register pair.
-- 
1.7.10.4
