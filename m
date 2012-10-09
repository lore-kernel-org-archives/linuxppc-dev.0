Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 19/20] powerpc/xmon: Remove externs for non-existant routines
Date: Wed, 10 Oct 2012 01:20:46 +1100
Message-Id: <1349792447-15714-19-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
References: <1349792447-15714-1-git-send-email-michael@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The implementation of both xmon_enter() & xmon_leave() was removed in
commit 51d3082 "Unify udbg (#2)".

I can't find any reference to exc_prolog or dec_exc since the epoch.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/xmon/xmon.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 9eb1d34..ded6c56 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -155,9 +155,6 @@ static void dump_tlb_book3e(void);
 
 static int xmon_no_auto_backtrace;
 
-extern void xmon_enter(void);
-extern void xmon_leave(void);
-
 #ifdef CONFIG_PPC64
 #define REG		"%.16lx"
 #else
@@ -1629,9 +1626,6 @@ write_spr(int n, unsigned long val)
 	}
 }
 
-extern char exc_prolog;
-extern char dec_exc;
-
 static void super_regs(void)
 {
 	static unsigned long regno;
-- 
1.7.9.5
