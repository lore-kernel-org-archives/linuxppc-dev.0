Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fWtj2bzmzF14j
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 06:50:53 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Breno Leitao <leitao@debian.org>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 Jiri Olsa <jolsa@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 2/5] tools headers powerpc: Update asm/unistd.h copy to pick
 new
Date: Mon, 30 Jul 2018 17:50:28 -0300
Message-Id: <20180730205031.12853-3-acme@kernel.org>
In-Reply-To: <20180730205031.12853-1-acme@kernel.org>
References: <20180730205031.12853-1-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The new 'io_pgetevents' syscall was wired up in PowerPC in the following
cset:

  b2f82565f2ca ("powerpc: Wire up io_pgetevents")

Update tools/arch/powerpc/ copy of the asm/unistd.h file so that 'perf
trace' on PowerPC gets it in its syscall table.

This elliminated the following perf build warning:

  Warning: Kernel ABI header at 'tools/arch/powerpc/include/uapi/asm/unistd.h' differs from latest version at 'arch/powerpc/include/uapi/asm/unistd.h'

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: https://lkml.kernel.org/n/tip-9uvu7tz4ud3bxxfyxwryuz47@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/powerpc/include/uapi/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/powerpc/include/uapi/asm/unistd.h b/tools/arch/powerpc/include/uapi/asm/unistd.h
index ac5ba55066dd..985534d0b448 100644
--- a/tools/arch/powerpc/include/uapi/asm/unistd.h
+++ b/tools/arch/powerpc/include/uapi/asm/unistd.h
@@ -399,5 +399,6 @@
 #define __NR_pkey_free		385
 #define __NR_pkey_mprotect	386
 #define __NR_rseq		387
+#define __NR_io_pgetevents	388
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.14.4
