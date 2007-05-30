Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 49394DDEBF
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 10:53:14 +1000 (EST)
Date: Tue, 29 May 2007 17:53:36 -0700
From: Dave Jiang <djiang@mvista.com>
To: galak@kernel.crashing.org
Subject: [PATCH/RFC 1/2] powerpc: BOOKE watchdog handler dump additional info
Message-ID: <20070530005336.GA8239@blade.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Have the watchdog handler to call die(). This allows some system information
such as registers, stack dump, and etc to be displayed. The die() handler
should handle the situation appropriately (i.e. kill process, call panic, 
or call crash_kexec)

The follow on patch will address any issues in regards to watchdog following the
call of panic. 

We have to keep the watchdog interrupt enabled because die() can just kill a
process and return the system to a running state instead of panic(). 
This will allow us to catch any new watchdog timeout exceptions if the system 
hangs again.

Signed-off-by: Dave Jiang <djiang@mvista.com>

---

 traps.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index bf6445a..837f742 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1095,8 +1095,7 @@ void unrecoverable_exception(struct pt_regs *regs)
 void __attribute__ ((weak)) WatchdogHandler(struct pt_regs *regs)
 {
 	/* Generic WatchdogHandler, implement your own */
-	mtspr(SPRN_TCR, mfspr(SPRN_TCR)&(~TCR_WIE));
-	return;
+	die("PowerPC Book-E Watchdog Exception", regs, SIGSEGV);
 }
 
 void WatchdogException(struct pt_regs *regs)
