Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A60E21A076F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 11:21:48 +1100 (EST)
Message-Id: <02c3a7b33169e92de6f749b0956fd93d032f0c62.1412640584.git.geoff@infradead.org>
In-Reply-To: <cover.1412640584.git.geoff@infradead.org>
References: <cover.1412640584.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH V23/5] kexec: Add bit definitions for kimage entry flags
To: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 07 Oct 2014 00:21:30 +0000
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
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
index 4b2a0e1..8c628ca 100644
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
@@ -312,4 +320,7 @@ struct task_struct;
 static inline void crash_kexec(struct pt_regs *regs) { }
 static inline int kexec_should_crash(struct task_struct *p) { return 0; }
 #endif /* CONFIG_KEXEC */
+
+#endif /* !defined(__ASSEBMLY__) */
+
 #endif /* LINUX_KEXEC_H */
-- 
1.9.1
