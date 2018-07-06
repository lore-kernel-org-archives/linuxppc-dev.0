Return-Path: <labbott@redhat.com>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41MGN301FRzF2Q4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 10:49:54 +1000 (AEST)
Received: by mail-qt0-f196.google.com with SMTP id m13-v6so8716108qth.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jul 2018 17:49:54 -0700 (PDT)
From: Laura Abbott <labbott@redhat.com>
To: Andy Lutomirski <luto@kernel.org>, mjw@fedoraproject.org,
 "H . J . Lu" <hjl.tools@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Laura Abbott <labbott@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>,
 linux-kernel@vger.kernel.org, Nick Clifton <nickc@redhat.com>,
 Cary Coutant <ccoutant@gmail.com>, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
Subject: [PATCHv6 2/4] x86: Add build salt to the vDSO
Date: Thu,  5 Jul 2018 17:49:38 -0700
Message-Id: <20180706004940.32587-3-labbott@redhat.com>
In-Reply-To: <20180706004940.32587-1-labbott@redhat.com>
References: <20180706004940.32587-1-labbott@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The vDSO needs to have a unique build id in a similar manner
to the kernel and modules. Use the build salt macro.

Acked-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v6: Ack from Andy
---
 arch/x86/entry/vdso/vdso-note.S   | 3 +++
 arch/x86/entry/vdso/vdso32/note.S | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/entry/vdso/vdso-note.S b/arch/x86/entry/vdso/vdso-note.S
index 79a071e4357e..79423170118f 100644
--- a/arch/x86/entry/vdso/vdso-note.S
+++ b/arch/x86/entry/vdso/vdso-note.S
@@ -3,6 +3,7 @@
  * Here we can supply some information useful to userland.
  */
 
+#include <linux/build-salt.h>
 #include <linux/uts.h>
 #include <linux/version.h>
 #include <linux/elfnote.h>
@@ -10,3 +11,5 @@
 ELFNOTE_START(Linux, 0, "a")
 	.long LINUX_VERSION_CODE
 ELFNOTE_END
+
+BUILD_SALT
diff --git a/arch/x86/entry/vdso/vdso32/note.S b/arch/x86/entry/vdso/vdso32/note.S
index 9fd51f206314..e78047d119f6 100644
--- a/arch/x86/entry/vdso/vdso32/note.S
+++ b/arch/x86/entry/vdso/vdso32/note.S
@@ -4,6 +4,7 @@
  * Here we can supply some information useful to userland.
  */
 
+#include <linux/build-salt.h>
 #include <linux/version.h>
 #include <linux/elfnote.h>
 
@@ -14,6 +15,8 @@ ELFNOTE_START(Linux, 0, "a")
 	.long LINUX_VERSION_CODE
 ELFNOTE_END
 
+BUILD_SALT
+
 #ifdef CONFIG_XEN
 /*
  * Add a special note telling glibc's dynamic linker a fake hardware
-- 
2.17.1
