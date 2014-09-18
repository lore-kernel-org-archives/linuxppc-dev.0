Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 587101A0929
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 09:40:28 +1000 (EST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 amodra@gmail.com, torvalds@linux-foundation.org
Subject: [PATCH 3/3] powerpc: Enable DCACHE_WORD_ACCESS on ppc64le
Date: Fri, 19 Sep 2014 09:40:21 +1000
Message-Id: <1411083621-12064-4-git-send-email-anton@samba.org>
In-Reply-To: <1411083621-12064-1-git-send-email-anton@samba.org>
References: <1411083621-12064-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Enable on DCACHE_WORD_ACCESS on ppc64le. It should work on
ppc64 and ppc32 but we need to do some testing first.

A somewhat reasonable testcase used to show the performance
improvement - a repeated stat of a 33 byte filename that
doesn't exist:

 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>

 #define ITERATIONS 10000000

 #define PATH "123456781234567812345678123456781"

 int main(void)
 {
 	unsigned long i;
 	struct stat buf;

 	for (i = 0; i < ITERATIONS; i++)
 		stat(PATH, &buf);

 	return 0;
 }

runs 27% faster on POWER8.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 90fe77a..7992f35 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -148,6 +148,7 @@ config PPC
 	select HAVE_ARCH_AUDITSYSCALL
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select HAVE_PERF_EVENTS_NMI if PPC64
+	select DCACHE_WORD_ACCESS if PPC64 && CPU_LITTLE_ENDIAN
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
-- 
1.9.1
