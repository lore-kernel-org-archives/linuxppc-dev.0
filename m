Return-Path: <takahiro.akashi@linaro.org>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rpPhx4ZM0zDqwH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2016 11:37:21 +1000 (AEST)
Received: by mail-pf0-x22d.google.com with SMTP id t190so768689pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 18:37:21 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com,
 bhe@redhat.com, bauerman@linux.vnet.ibm.com, arnd@arndb.de
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 1/3] syscall: add kexec_file_load to generic unistd.h
Date: Tue, 12 Jul 2016 10:41:59 +0900
Message-Id: <20160712014201.11456-2-takahiro.akashi@linaro.org>
In-Reply-To: <20160712014201.11456-1-takahiro.akashi@linaro.org>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently kexec_file_load is supported only on x86, but it will be
supported on powerpc and arm64 in near future. Since both archs
use asm-generic/unistd.h, this patch adds the entry to this file.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 include/uapi/asm-generic/unistd.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a26415b..9ead10f 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -724,9 +724,15 @@ __SYSCALL(__NR_copy_file_range, sys_copy_file_range)
 __SC_COMP(__NR_preadv2, sys_preadv2, compat_sys_preadv2)
 #define __NR_pwritev2 287
 __SC_COMP(__NR_pwritev2, sys_pwritev2, compat_sys_pwritev2)
+#define __NR_kexec_file_load 288
+#ifdef CONFIG_KEXEC_FILE
+__SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)
+#else
+__SYSCALL(__NR_kexec_file_load, sys_ni_syscall)
+#endif /* CONFIG_KEXEC_FILE */
 
 #undef __NR_syscalls
-#define __NR_syscalls 288
+#define __NR_syscalls 289
 
 /*
  * All syscalls below here should go away really,
-- 
2.9.0
