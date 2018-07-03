Return-Path: <labbott@redhat.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41L0pF2bStzF1QL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 09:34:45 +1000 (AEST)
Received: by mail-oi0-f66.google.com with SMTP id c6-v6so7259239oiy.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 16:34:45 -0700 (PDT)
From: Laura Abbott <labbott@redhat.com>
To: mjw@fedoraproject.org, "H . J . Lu" <hjl.tools@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Laura Abbott <labbott@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>,
 linux-kernel@vger.kernel.org, Nick Clifton <nickc@redhat.com>,
 Cary Coutant <ccoutant@gmail.com>, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
Subject: [PATCHv5 3/4] powerpc: Add build salt to the vDSO
Date: Tue,  3 Jul 2018 16:34:29 -0700
Message-Id: <20180703233430.14416-4-labbott@redhat.com>
In-Reply-To: <20180703233430.14416-1-labbott@redhat.com>
References: <20180703233430.14416-1-labbott@redhat.com>
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

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v5: New approach with the BUILD_SALT macro
---
 arch/powerpc/kernel/vdso32/note.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/vdso32/note.S b/arch/powerpc/kernel/vdso32/note.S
index d4b5be4f3d5f..ec1d05265c75 100644
--- a/arch/powerpc/kernel/vdso32/note.S
+++ b/arch/powerpc/kernel/vdso32/note.S
@@ -5,6 +5,7 @@
 
 #include <linux/uts.h>
 #include <linux/version.h>
+#include <linux/build-salt.h>
 
 #define ASM_ELF_NOTE_BEGIN(name, flags, vendor, type)			      \
 	.section name, flags;						      \
@@ -23,3 +24,5 @@
 	ASM_ELF_NOTE_BEGIN(".note.kernel-version", "a", UTS_SYSNAME, 0)
 	.long LINUX_VERSION_CODE
 	ASM_ELF_NOTE_END
+
+BUILD_SALT;
-- 
2.17.1
