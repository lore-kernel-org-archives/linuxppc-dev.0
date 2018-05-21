Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qKDL6RRpzF16f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 23:21:21 +1000 (AEST)
From: Michal Suchanek <msuchanek@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Balbir Singh <bsingharora@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Breno Leitao <leitao@debian.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH] powerpc/xmon: really enable xmon when a breakpoint is set
Date: Mon, 21 May 2018 15:21:08 +0200
Message-Id: <20180521132108.7938-1-msuchanek@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When single-stepping kernel code from xmon without a debug hook enabled
the kernel crashes. This can happen when kernel starts with xmon on
crash disabled but xmon is entered using sysrq.

Commit e1368d0c9edb ("powerpc/xmon: Setup debugger hooks when first
break-point is set") adds force_enable_xmon function that prints
"xmon: Enabling debugger hooks" but does not enable them.

Add the call to xmon_init to install the debugger hooks in
force_enable_xmon and also call force_enable_xmon when single-stepping
in xmon.

Fixes: e1368d0c9edb ("powerpc/xmon: Setup debugger hooks when first
break-point is set")

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/powerpc/xmon/xmon.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index a0842f1ff72c..504bd1c3d8b0 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -179,6 +179,9 @@ static const char *getvecname(unsigned long vec);
 
 static int do_spu_cmd(void);
 
+static void xmon_init(int enable);
+static inline void force_enable_xmon(void);
+
 #ifdef CONFIG_44x
 static void dump_tlb_44x(void);
 #endif
@@ -1094,6 +1097,7 @@ static int do_step(struct pt_regs *regs)
 	unsigned int instr;
 	int stepped;
 
+	force_enable_xmon();
 	/* check we are in 64-bit kernel mode, translation enabled */
 	if ((regs->msr & (MSR_64BIT|MSR_PR|MSR_IR)) == (MSR_64BIT|MSR_IR)) {
 		if (mread(regs->nip, &instr, 4) == 4) {
@@ -1275,6 +1279,7 @@ static inline void force_enable_xmon(void)
 	if (!xmon_on) {
 		printf("xmon: Enabling debugger hooks\n");
 		xmon_on = 1;
+		xmon_init(1);
 	}
 }
 
-- 
2.13.6
