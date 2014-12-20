Return-Path: <rickard_strandqvist@spectrumdigital.se>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED2FF1A060F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Dec 2014 01:57:18 +1100 (AEDT)
Received: by mail-wg0-f46.google.com with SMTP id x13so3551259wgg.33
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Dec 2014 06:57:14 -0800 (PST)
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
To: Geoff Levand <geoff@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] arch: powerpc: platforms: ps3: repository.c: Remove unused
 function
Date: Sat, 20 Dec 2014 16:00:01 +0100
Message-Id: <1419087601-4889-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Cc: cbe-oss-dev@lists.ozlabs.org,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the function ps3_repository_write_highmem_info() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/powerpc/platforms/ps3/platform.h   |    2 --
 arch/powerpc/platforms/ps3/repository.c |   10 ----------
 2 files changed, 12 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/platform.h b/arch/powerpc/platforms/ps3/platform.h
index d71329a..f15507c 100644
--- a/arch/powerpc/platforms/ps3/platform.h
+++ b/arch/powerpc/platforms/ps3/platform.h
@@ -201,8 +201,6 @@ int ps3_repository_write_highmem_base(unsigned int region_index,
 	u64 highmem_base);
 int ps3_repository_write_highmem_size(unsigned int region_index,
 	u64 highmem_size);
-int ps3_repository_write_highmem_info(unsigned int region_index,
-	u64 highmem_base, u64 highmem_size);
 int ps3_repository_delete_highmem_info(unsigned int region_index);
 
 /* repository pme info */
diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index bfccdc7..2d5e56a 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -1160,16 +1160,6 @@ int ps3_repository_write_highmem_size(unsigned int region_index,
 		highmem_size, 0);
 }
 
-int ps3_repository_write_highmem_info(unsigned int region_index,
-	u64 highmem_base, u64 highmem_size)
-{
-	int result;
-
-	result = ps3_repository_write_highmem_base(region_index, highmem_base);
-	return result ? result
-		: ps3_repository_write_highmem_size(region_index, highmem_size);
-}
-
 static int ps3_repository_delete_highmem_base(unsigned int region_index)
 {
 	return delete_node(
-- 
1.7.10.4
