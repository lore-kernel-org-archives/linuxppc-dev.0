Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402JGx6VbszF17N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 06:16:25 +1100 (AEDT)
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Nicholas Piggin <npiggin@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 David Gibson <david@gibson.dropbear.id.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Joe Perches <joe@perches.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Tobin C. Harding" <me@tobin.cc>, Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH RFC rebase 4/9] powerpc/64s: Use barrier_nospec in
 RFI_FLUSH_SLOT
Date: Thu, 15 Mar 2018 20:15:53 +0100
Message-Id: <89e52fff32b76d01d5c0c961f6558dade0676f7a.1521141122.git.msuchanek@suse.de>
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
In-Reply-To: <cover.1521141122.git.msuchanek@suse.de>
References: <cover.1521141122.git.msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The RFI flush support patches the speculation barrier into
RFI_FLUSH_SLOT as part of the RFI flush. Use separate barrier_nospec
instead.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/include/asm/exception-64s.h | 2 +-
 arch/powerpc/lib/feature-fixups.c        | 9 +++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 471b2274fbeb..bb5a3052b29b 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -81,9 +81,9 @@
  * L1-D cache when returning to userspace or a guest.
  */
 #define RFI_FLUSH_SLOT							\
+	barrier_nospec_asm;						\
 	RFI_FLUSH_FIXUP_SECTION;					\
 	nop;								\
-	nop;								\
 	nop
 
 #define RFI_TO_KERNEL							\
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 35f80ab7cbd8..4cc2f0c5c863 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -119,7 +119,7 @@ void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 #ifdef CONFIG_PPC_BOOK3S_64
 void do_rfi_flush_fixups(enum l1d_flush_type types)
 {
-	unsigned int instrs[3], *dest;
+	unsigned int instrs[2], *dest;
 	long *start, *end;
 	int i;
 
@@ -128,15 +128,13 @@ void do_rfi_flush_fixups(enum l1d_flush_type types)
 
 	instrs[0] = 0x60000000; /* nop */
 	instrs[1] = 0x60000000; /* nop */
-	instrs[2] = 0x60000000; /* nop */
 
 	if (types & L1D_FLUSH_FALLBACK)
-		/* b .+16 to fallback flush */
-		instrs[0] = 0x48000010;
+		/* b .+12 to fallback flush */
+		instrs[0] = 0x4800000c;
 
 	i = 0;
 	if (types & L1D_FLUSH_ORI) {
-		instrs[i++] = 0x63ff0000; /* ori 31,31,0 speculation barrier */
 		instrs[i++] = 0x63de0000; /* ori 30,30,0 L1d flush*/
 	}
 
@@ -150,7 +148,6 @@ void do_rfi_flush_fixups(enum l1d_flush_type types)
 
 		patch_instruction(dest, instrs[0]);
 		patch_instruction(dest + 1, instrs[1]);
-		patch_instruction(dest + 2, instrs[2]);
 	}
 
 	printk(KERN_DEBUG "rfi-flush: patched %d locations (%s flush)\n", i,
-- 
2.13.6
