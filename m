Return-Path: <labbott@redhat.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41L0pH5D8qzF1RL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 09:34:47 +1000 (AEST)
Received: by mail-oi0-f66.google.com with SMTP id b15-v6so7204599oib.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 16:34:47 -0700 (PDT)
From: Laura Abbott <labbott@redhat.com>
To: mjw@fedoraproject.org, "H . J . Lu" <hjl.tools@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>
Cc: Laura Abbott <labbott@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, X86 ML <x86@kernel.org>,
 linux-kernel@vger.kernel.org, Nick Clifton <nickc@redhat.com>,
 Cary Coutant <ccoutant@gmail.com>, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCHv5 4/4] arm64: Add build salt to the vDSO
Date: Tue,  3 Jul 2018 16:34:30 -0700
Message-Id: <20180703233430.14416-5-labbott@redhat.com>
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
v5: I was previously focused on x86 only but since powerpc gave a patch,
I figured I would do arm64 since the changes were also fairly simple.
---
 arch/arm64/kernel/vdso/note.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/vdso/note.S b/arch/arm64/kernel/vdso/note.S
index b82c85e5d972..2c429dfd3f45 100644
--- a/arch/arm64/kernel/vdso/note.S
+++ b/arch/arm64/kernel/vdso/note.S
@@ -22,7 +22,10 @@
 #include <linux/uts.h>
 #include <linux/version.h>
 #include <linux/elfnote.h>
+#include <linux/build-salt.h>
 
 ELFNOTE_START(Linux, 0, "a")
 	.long LINUX_VERSION_CODE
 ELFNOTE_END
+
+BUILD_SALT;
-- 
2.17.1
