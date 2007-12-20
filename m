Return-Path: <roland@redhat.com>
Received: from QMTA05.emeryville.ca.mail.comcast.net
	(qmta05.emeryville.ca.mail.comcast.net [76.96.30.48])
	by ozlabs.org (Postfix) with ESMTP id 642F8DDE46
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 23:02:39 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: Roland McGrath's message of  Thursday,
	20 December 2007 03:52:00 -0800
	<20071220115200.C767E26F98A@magilla.localdomain>
References: <20071220115200.C767E26F98A@magilla.localdomain>
Subject: [PATCH -mm 20/43] powerpc SPE core dump
Message-Id: <20071220115828.6C16826F98A@magilla.localdomain>
Date: Thu, 20 Dec 2007 03:58:28 -0800 (PST)
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This makes the SPE register data appear in ELF core dumps,
using the new n_type value NT_PPC_SPE (0x101).  This new
note type is not used by any consumers of core files yet,
but support can be added.  I don't even have any hardware
with SPE capabilities, so I've never seen such a note.
But this demonstrates how simple it is to export register
information in core dumps when the user_regset style is
used for the low-level code.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/ptrace.c |    2 +-
 include/linux/elf.h          |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index e961e10..0231e7d 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -642,7 +642,7 @@ static const struct user_regset compat_regsets[] = {
 #endif
 #ifdef CONFIG_SPE
 	[REGSET_SPE] = {
-		.n = 35,
+		.core_note_type = NT_PPC_SPE, .n = 35,
 		.size = sizeof(u32), .align = sizeof(u32),
 		.active = evr_active, .get = evr_get, .set = evr_set
 	},
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 576e83b..ba268b2 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -355,6 +355,7 @@ typedef struct elf64_shdr {
 #define NT_AUXV		6
 #define NT_PRXFPREG     0x46e62b7f      /* copied from gdb5.1/include/elf/common.h */
 #define NT_PPC_VMX	0x100		/* PowerPC Altivec/VMX registers */
+#define NT_PPC_SPE	0x101		/* PowerPC SPE/EVR registers */
 
 
 /* Note header in a PT_NOTE section */
-- 
1.5.3.6
