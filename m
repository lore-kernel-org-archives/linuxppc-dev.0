Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id DA1494768F
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 07:09:36 +1100 (EST)
Date: Wed, 17 Dec 2008 23:09:35 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 7/7] powerpc/64/kdump: Use ppc_save_regs() in
	crash_setup_regs()
Message-ID: <20081217200935.GG4624@oksana.dev.rtsoft.ru>
References: <20081217200610.GA31887@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081217200610.GA31887@oksana.dev.rtsoft.ru>
Cc: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch replaces internal registers dump implementation with
ppc_save_regs(). From now on PPC64 and PPC32 are using the same
code for crash_setup_regs().

NOTE: The old regs dump implementation was capturing SP (r1) directly
as is, so you could see crash_kexec() function on top of the back-trace.
But ppc_save_regs() goes up one stack frame, so you'll not see it
anymore, at the top-level you'll see who actually triggered the crash
dump instead.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

p.s.
The patch is the last in the series, so you can easily drop it
until somebody actually test it (I don't have any PPC64 machine,
so I'm looking for volunteers. :-)

 arch/powerpc/include/asm/kexec.h |   55 --------------------------------------
 1 files changed, 0 insertions(+), 55 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 6dbffc9..7e06b43 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -48,63 +48,8 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 {
 	if (oldregs)
 		memcpy(newregs, oldregs, sizeof(*newregs));
-#ifdef __powerpc64__
-	else {
-		/* FIXME Merge this with xmon_save_regs ?? */
-		unsigned long tmp1, tmp2;
-		__asm__ __volatile__ (
-			"std    0,0(%2)\n"
-			"std    1,8(%2)\n"
-			"std    2,16(%2)\n"
-			"std    3,24(%2)\n"
-			"std    4,32(%2)\n"
-			"std    5,40(%2)\n"
-			"std    6,48(%2)\n"
-			"std    7,56(%2)\n"
-			"std    8,64(%2)\n"
-			"std    9,72(%2)\n"
-			"std    10,80(%2)\n"
-			"std    11,88(%2)\n"
-			"std    12,96(%2)\n"
-			"std    13,104(%2)\n"
-			"std    14,112(%2)\n"
-			"std    15,120(%2)\n"
-			"std    16,128(%2)\n"
-			"std    17,136(%2)\n"
-			"std    18,144(%2)\n"
-			"std    19,152(%2)\n"
-			"std    20,160(%2)\n"
-			"std    21,168(%2)\n"
-			"std    22,176(%2)\n"
-			"std    23,184(%2)\n"
-			"std    24,192(%2)\n"
-			"std    25,200(%2)\n"
-			"std    26,208(%2)\n"
-			"std    27,216(%2)\n"
-			"std    28,224(%2)\n"
-			"std    29,232(%2)\n"
-			"std    30,240(%2)\n"
-			"std    31,248(%2)\n"
-			"mfmsr  %0\n"
-			"std    %0, 264(%2)\n"
-			"mfctr  %0\n"
-			"std    %0, 280(%2)\n"
-			"mflr   %0\n"
-			"std    %0, 288(%2)\n"
-			"bl     1f\n"
-		"1:     mflr   %1\n"
-			"std    %1, 256(%2)\n"
-			"mtlr   %0\n"
-			"mfxer  %0\n"
-			"std    %0, 296(%2)\n"
-			: "=&r" (tmp1), "=&r" (tmp2)
-			: "b" (newregs)
-			: "memory");
-	}
-#else
 	else
 		ppc_save_regs(newregs);
-#endif /* __powerpc64__ */
 }
 
 extern void kexec_smp_wait(void);	/* get and clear naca physid, wait for
-- 
1.5.6.5
