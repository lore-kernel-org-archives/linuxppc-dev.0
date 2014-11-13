Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E27E51A1E98
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Nov 2014 11:19:49 +1100 (AEDT)
Message-Id: <100b0720dcbf9746070e1f9a9ec2a95b6f8694a8.1415837218.git.geoff@infradead.org>
In-Reply-To: <cover.1415837218.git.geoff@infradead.org>
References: <cover.1415837218.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH V3 3/4] kexec: Add bit definitions for kimage entry flags
To: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 13 Nov 2014 00:19:32 +0000
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Define new kexec preprocessor macros IND_*_BIT that define the bit position of
the kimage entry flags.  Change the existing IND_* flag macros to be defined as
bit shifts of the corresponding IND_*_BIT macros.  Also wrap all C language code
in kexec.h with #if !defined(__ASSEMBLY__) so assembly files can include kexec.h
to get the IND_* and IND_*_BIT macros.

Some CPU instruction sets have tests for bit position which are convenient in
implementing routines that operate on the kimage entry list.  The addition of
these bit position macros in a common location will avoid duplicate definitions
and the chance that changes to the IND_* flags will not be propagated to
assembly files.

Signed-off-by: Geoff Levand <geoff@infradead.org>
Acked-by: Vivek Goyal <vgoyal@redhat.com>
---
 include/linux/kexec.h | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9d957b7..25e039c 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -1,6 +1,18 @@
 #ifndef LINUX_KEXEC_H
 #define LINUX_KEXEC_H
 
+#define IND_DESTINATION_BIT 0
+#define IND_INDIRECTION_BIT 1
+#define IND_DONE_BIT        2
+#define IND_SOURCE_BIT      3
+
+#define IND_DESTINATION  (1 << IND_DESTINATION_BIT)
+#define IND_INDIRECTION  (1 << IND_INDIRECTION_BIT)
+#define IND_DONE         (1 << IND_DONE_BIT)
+#define IND_SOURCE       (1 << IND_SOURCE_BIT)
+
+#if !defined(__ASSEMBLY__)
+
 #include <uapi/linux/kexec.h>
 
 #ifdef CONFIG_KEXEC
@@ -64,10 +76,6 @@
  */
 
 typedef unsigned long kimage_entry_t;
-#define IND_DESTINATION  0x1
-#define IND_INDIRECTION  0x2
-#define IND_DONE         0x4
-#define IND_SOURCE       0x8
 
 struct kexec_segment {
 	/*
@@ -313,4 +321,7 @@ struct task_struct;
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 #endif /* CONFIG_KEXEC */
+
+#endif /* !defined(__ASSEBMLY__) */
+
 #endif /* LINUX_KEXEC_H */
-- 
1.9.1
