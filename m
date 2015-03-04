Return-Path: <keescook@www.outflux.net>
Received: from smtp.outflux.net (smtp.outflux.net
 [IPv6:2001:19d0:2:6:c0de:0:736d:7470])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F14D1A0A52
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Mar 2015 08:14:19 +1100 (AEDT)
From: Kees Cook <keescook@chromium.org>
To: akpm@linux-foundation.org
Subject: [PATCH v4 01/10] arm: factor out mmap ASLR into mmap_rnd
Date: Wed,  4 Mar 2015 13:10:45 -0800
Message-Id: <1425503454-7531-2-git-send-email-keescook@chromium.org>
In-Reply-To: <1425503454-7531-1-git-send-email-keescook@chromium.org>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
Cc: linux-mips@linux-mips.org, Arun Chandran <achandran@mvista.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Min-Hua Chen <orca.chen@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Ismael Ripoll <iripoll@upv.es>, Yann Droneaud <ydroneaud@opteya.com>,
 linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Andrey Ryabinin <a.ryabinin@samsung.com>, x86@kernel.org,
 Hector Marco-Gisbert <hecmargi@upv.es>, Ingo Molnar <mingo@redhat.com>,
 "David A. Long" <dave.long@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Borislav Petkov <bp@suse.de>,
 Ben Hutchings <ben@decadent.org.uk>, Kees Cook <keescook@chromium.org>,
 Will Deacon <will.deacon@arm.com>, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 linux-arm-kernel@lists.infradead.org, Jeff Bailey <jeffbailey@google.com>,
 Paul Burton <paul.burton@imgtec.com>, Oleg Nesterov <oleg@redhat.com>,
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

In preparation for splitting out ET_DYN ASLR, this moves the ASLR calculations
for mmap on ARM into a separate routine, similar to x86. This also removes
the redundant check of personality (PF_RANDOMIZE is already set before calling
arch_pick_mmap_layout).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/mm/mmap.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index 5e85ed371364..15a8160096b3 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -169,14 +169,22 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	return addr;
 }
 
+static unsigned long mmap_rnd(void)
+{
+	unsigned long rnd;
+
+	/* 8 bits of randomness in 20 address space bits */
+	rnd = (unsigned long)get_random_int() % (1 << 8);
+
+	return rnd << PAGE_SHIFT;
+}
+
 void arch_pick_mmap_layout(struct mm_struct *mm)
 {
 	unsigned long random_factor = 0UL;
 
-	/* 8 bits of randomness in 20 address space bits */
-	if ((current->flags & PF_RANDOMIZE) &&
-	    !(current->personality & ADDR_NO_RANDOMIZE))
-		random_factor = (get_random_int() % (1 << 8)) << PAGE_SHIFT;
+	if (current->flags & PF_RANDOMIZE)
+		random_factor = mmap_rnd();
 
 	if (mmap_is_legacy()) {
 		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
-- 
1.9.1
