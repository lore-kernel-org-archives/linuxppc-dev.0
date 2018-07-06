Return-Path: <labbott@redhat.com>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41MGN94CYLzF2Wl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2018 10:50:01 +1000 (AEST)
Received: by mail-qk0-f195.google.com with SMTP id y4-v6so5500320qka.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jul 2018 17:50:01 -0700 (PDT)
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
Subject: [PATCHv6 4/4] arm64: Add build salt to the vDSO
Date: Thu,  5 Jul 2018 17:49:40 -0700
Message-Id: <20180706004940.32587-5-labbott@redhat.com>
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

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v6: Remove the semi-colon, Ack from Will
---
 arch/arm64/kernel/vdso/note.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/vdso/note.S b/arch/arm64/kernel/vdso/note.S
index b82c85e5d972..e20483b104d9 100644
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
+BUILD_SALT
-- 
2.17.1
