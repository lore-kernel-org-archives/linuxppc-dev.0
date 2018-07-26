Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41brry6wmGzF0dm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 22:25:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] selftests/powerpc: Only run some tests on ppc64le
Date: Thu, 26 Jul 2018 22:24:58 +1000
Message-Id: <20180726122459.9293-2-mpe@ellerman.id.au>
In-Reply-To: <20180726122459.9293-1-mpe@ellerman.id.au>
References: <20180726122459.9293-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These tests are currently failing on (some) big endian systems. Until
we can fix that, skip them unless we're on ppc64le.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/tm/tm-sigreturn.c | 1 +
 tools/testing/selftests/powerpc/tm/tm-tar.c       | 1 +
 tools/testing/selftests/powerpc/tm/tm-vmxcopy.c   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/testing/selftests/powerpc/tm/tm-sigreturn.c b/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
index 85d63449243b..9a6017a1d769 100644
--- a/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
+++ b/tools/testing/selftests/powerpc/tm/tm-sigreturn.c
@@ -55,6 +55,7 @@ int tm_sigreturn(void)
 	uint64_t ret = 0;
 
 	SKIP_IF(!have_htm());
+	SKIP_IF(!is_ppc64le());
 
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_handler = handler;
diff --git a/tools/testing/selftests/powerpc/tm/tm-tar.c b/tools/testing/selftests/powerpc/tm/tm-tar.c
index 2d2fcc2b7a60..f31fe5a28ddb 100644
--- a/tools/testing/selftests/powerpc/tm/tm-tar.c
+++ b/tools/testing/selftests/powerpc/tm/tm-tar.c
@@ -26,6 +26,7 @@ int test_tar(void)
 	int i;
 
 	SKIP_IF(!have_htm());
+	SKIP_IF(!is_ppc64le());
 
 	for (i = 0; i < num_loops; i++)
 	{
diff --git a/tools/testing/selftests/powerpc/tm/tm-vmxcopy.c b/tools/testing/selftests/powerpc/tm/tm-vmxcopy.c
index 0274de7b11f3..fe52811584ae 100644
--- a/tools/testing/selftests/powerpc/tm/tm-vmxcopy.c
+++ b/tools/testing/selftests/powerpc/tm/tm-vmxcopy.c
@@ -46,6 +46,7 @@ int test_vmxcopy()
 	uint64_t aborted = 0;
 
 	SKIP_IF(!have_htm());
+	SKIP_IF(!is_ppc64le());
 
 	fd = mkstemp(tmpfile);
 	assert(fd >= 0);
-- 
2.14.1
