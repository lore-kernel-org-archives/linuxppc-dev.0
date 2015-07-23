Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 606951A0615
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 20:21:27 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>, keescook@chromium.org, luto@amacapital.net,
 wad@chromium.org, strosake@linux.vnet.ibm.com,
 bogdan.purcareata@freescale.com
Subject: [PATCH 10/11] selftests/seccomp: Make seccomp tests work on big endian
Date: Thu, 23 Jul 2015 20:21:10 +1000
Message-Id: <1437646871-3195-10-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1437646871-3195-1-git-send-email-mpe@ellerman.id.au>
References: <1437646871-3195-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The seccomp_bpf test uses BPF_LD|BPF_W|BPF_ABS to load 32-bit values
from seccomp_data->args. On big endian machines this will load the high
word of the argument, which is not what the test wants.

Borrow a hack from samples/seccomp/bpf-helper.h which changes the offset
on big endian to account for this.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index c5abe7fd7590..2303a8dff9a2 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -82,7 +82,13 @@ struct seccomp_data {
 };
 #endif
 
+#if __BYTE_ORDER == __LITTLE_ENDIAN
 #define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]))
+#elif __BYTE_ORDER == __BIG_ENDIAN
+#define syscall_arg(_n) (offsetof(struct seccomp_data, args[_n]) + sizeof(__u32))
+#else
+#error "wut? Unknown __BYTE_ORDER?!"
+#endif
 
 #define SIBLING_EXIT_UNKILLED	0xbadbeef
 #define SIBLING_EXIT_FAILURE	0xbadface
-- 
2.1.0
