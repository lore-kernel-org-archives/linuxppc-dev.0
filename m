Return-Path: <dwilder@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2FDE367B3A
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 07:36:31 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5TLaRrd013772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 17:36:27 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5TLaiwV181230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 15:36:44 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5TLaQuc003793
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 15:36:26 -0600
Message-ID: <44A4517A.2050509@us.ibm.com>
Date: Thu, 29 Jun 2006 15:17:30 -0700
From: David Wilder <dwilder@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	haren@us.ibm.com
Subject: [PATCH] Xmon stops CPUs for kdump
Content-Type: multipart/mixed; boundary="------------060906020803090600030105"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060906020803090600030105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

In the case of a system hang, the user will invoke soft-reset to 
initiate the kdump boot.  If xmon is enabled, the CPU(s) enter into the 
xmon debugger.   Unfortunately, the secondary CPU(s) will return to the 
hung state when they exit from the debugger (returned from die() -> 
system_reset_exception()).  This causes a problem in kdump since the 
hung CPU(s) will not respond to the IPI sent from kdump.  This patch 
fixes the issue by calling crash_kexec_secondary() directly from 
system_reset_exception() without returning to the previous state.  These 
secondary CPUs wait 5ms until the kdump boot is started by the primary 
CPU.   In the case we exited from the debugger to "recover" (command 'x' 
in xmon) the primary and the secondary CPUs will all return from die() 
-> system_reset_exception() ->crash_kexec_secondary() wait 5ms, then 
return to the previous state.  A kdump boot is not started in this case.

Signed-off-by: Haren Myneni <haren@us.ibm.com>
Signed-off-by: David Wilder <dwilder@us.ibm.com>

-- 
David Wilder
IBM Linux Technology Center
Beaverton, Oregon, USA 
dwilder@us.ibm.com
(503)578-3789


--------------060906020803090600030105
Content-Type: text/x-patch;
 name="ppc64-x-mon-stop-cpu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc64-x-mon-stop-cpu.patch"

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index fa6bd97..49679c3 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -216,6 +216,19 @@ void system_reset_exception(struct pt_re
 
 	die("System Reset", regs, SIGABRT);
 
+	/*
+	 * Some CPUs when released from the debugger will execute this path.
+	 * These CPUs entered the debugger via a soft-reset. If the CPU was 
+	 * hung before entering the debugger it will return to the hung 
+	 * state when exiting this function.  This causes a problem in
+	 * kdump since the hung CPU(s) will not respond to the IPI sent
+	 * from kdump. To prevent the problem we call crash_kexec_secondary()
+	 * here. If a kdump had not been initiated or we exit the debugger
+	 * with the "exit and recover" command (x) crash_kexec_secondary()
+	 * will return after 5ms and the CPU returns to its previous state.
+	 */
+	crash_kexec_secondary(regs);
+
 	/* Must die if the interrupt is not recoverable */
 	if (!(regs->msr & MSR_RI))
 		panic("Unrecoverable System Reset");

--------------060906020803090600030105--
