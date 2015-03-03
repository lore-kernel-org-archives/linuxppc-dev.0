Return-Path: <keescook@www.outflux.net>
Received: from smtp.outflux.net (smtp.outflux.net
 [IPv6:2001:19d0:2:6:c0de:0:736d:7470])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408601A01BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 11:39:43 +1100 (AEDT)
From: Kees Cook <keescook@chromium.org>
To: akpm@linux-foundation.org
Subject: [PATCH 3/5] mm: move randomize_et_dyn into ELF_ET_DYN_BASE
Date: Mon,  2 Mar 2015 16:19:46 -0800
Message-Id: <1425341988-1599-4-git-send-email-keescook@chromium.org>
In-Reply-To: <1425341988-1599-1-git-send-email-keescook@chromium.org>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
Cc: linux-mips@linux-mips.org, Arun Chandran <achandran@mvista.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
 Min-Hua Chen <orca.chen@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Yann Droneaud <ydroneaud@opteya.com>, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>,
 Andrey Ryabinin <a.ryabinin@samsung.com>, x86@kernel.org,
 Hector Marco-Gisbert <hecmargi@upv.es>, "David A. Long" <dave.long@linaro.org>,
 Borislav Petkov <bp@suse.de>, Ben Hutchings <ben@decadent.org.uk>,
 Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>,
 linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 linux-arm-kernel@lists.infradead.org, Jeff Bailey <jeffbailey@google.com>,
 Paul Burton <paul.burton@imgtec.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Andy Lutomirski <luto@amacapital.net>,
 Vineeth Vijayan <vvijayan@mvista.com>,
 Markos Chandras <markos.chandras@imgtec.com>,
 =?UTF-8?q?Jan-Simon=20M=C3=B6ller?= <dl9pf@gmx.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 linuxppc-dev@lists.ozlabs.org, Alex Smith <alex@alex-smith.me.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation for moving ET_DYN randomization into the ELF loader
(which requires a static ELF_ET_DYN_BASE), this redefines s390's existing
ET_DYN randomization away from a separate function (randomize_et_dyn)
and into ELF_ET_DYN_BASE and a call to arch_mmap_rnd(). This refactoring
results in the same ET_DYN randomization on s390. Additionally removes
a copy/pasted unused arm64 extern.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/elf.h |  1 -
 arch/s390/include/asm/elf.h  |  9 +++++----
 arch/s390/mm/mmap.c          | 11 -----------
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 1f65be393139..f724db00b235 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -125,7 +125,6 @@ typedef struct user_fpsimd_state elf_fpregset_t;
  * the loader.  We need to make sure that it is out of the way of the program
  * that it will "exec", and that there is sufficient room for the brk.
  */
-extern unsigned long randomize_et_dyn(unsigned long base);
 #define ELF_ET_DYN_BASE	(2 * TASK_SIZE_64 / 3)
 
 /*
diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index c9df40b5c0ac..9ed68e7ee856 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -161,10 +161,11 @@ extern unsigned int vdso_enabled;
 /* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
    use of this is to invoke "./ld.so someprog" to test out a new version of
    the loader.  We need to make sure that it is out of the way of the program
-   that it will "exec", and that there is sufficient room for the brk.  */
-
-extern unsigned long randomize_et_dyn(void);
-#define ELF_ET_DYN_BASE		randomize_et_dyn()
+   that it will "exec", and that there is sufficient room for the brk. 64-bit
+   tasks are aligned to 4GB. */
+#define ELF_ET_DYN_BASE (arch_mmap_rnd() + (is_32bit_task() ? \
+				(STACK_TOP / 3 * 2) : \
+				(STACK_TOP / 3 * 2) & ~((1UL << 32) - 1)))
 
 /* This yields a mask that user programs can use to figure out what
    instruction set this CPU supports. */
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 77759e35671b..ec4c20448aef 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -179,17 +179,6 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	return addr;
 }
 
-unsigned long randomize_et_dyn(void)
-{
-	unsigned long base;
-
-	base = STACK_TOP / 3 * 2;
-	if (!is_32bit_task())
-		/* Align to 4GB */
-		base &= ~((1UL << 32) - 1);
-	return base + arch_mmap_rnd();
-}
-
 #ifndef CONFIG_64BIT
 
 /*
-- 
1.9.1
