Return-Path: <dwilder@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D23C5679E9
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 03:55:37 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3QHtYV9023256
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 13:55:34 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3QHpkUh272256
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 11:51:46 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3QHtYYO029389
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 11:55:34 -0600
Received: from [9.67.65.168] ([9.67.65.168])
	by d03av02.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	k3QHtXpU026437
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 11:55:34 -0600
Message-ID: <444FBDFB.1070004@us.ibm.com>
Date: Wed, 26 Apr 2006 11:37:47 -0700
From: David Wilder <dwilder@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc64-xmon-stop-cpu.patch
Content-Type: multipart/mixed; boundary="------------060302010902060904000407"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060302010902060904000407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please pick up this patch
- During CPU(s) hang scenarios, kdump could not stop these CPUs. 
However, the user could invoke soft-reset to shoot down CPUs reliably. 
But, when the debugger is enabled, these CPUs are returned to hang state 
after they exited from the debugger. This patch fixes this issue by 
calling crash_kexec_secondary() before returns to previous state.

-- 
David Wilder
IBM Linux Technology Center
Beaverton, Oregon, USA 
dwilder@us.ibm.com
(503)578-3789


--------------060302010902060904000407
Content-Type: text/x-patch;
 name="ppc64-xmon-stop-cpu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc64-xmon-stop-cpu.patch"

- During CPU(s) hang scenarios, kdump could not stop these CPUs. However, the user could invoke soft-reset to shoot down CPUs reliably. But, when the debugger is enabled, these CPUs are returned to hang state after they exited from the debugger. This patch fixes this issue by calling crash_kexec_secondary() before returns to previous state.

Signed-off-by: David Wilder <dwilder@us.ibm.com>
Signed-off-by: Haren Myneni <haren@us.ibm.com>


diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 064a525..9a509f8 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -208,6 +208,16 @@ void system_reset_exception(struct pt_re
 
 	die("System Reset", regs, SIGABRT);
 
+	/*
+	 * Some CPUs which got released from debugger will execute this path.
+	 * These CPUs entered debugger first time via soft-reset - Means,
+	 * could be possible that these CPUs may not repond to an IPI later.
+	 * Therefore, has to call kdump func directly.
+	 * Not a problem if we exited from debugger to recover. In this case
+	 * there will not be any primary kexec CPU. Hence, will be returned.
+	 */
+	crash_kexec_secondary(regs);
+
 	/* Must die if the interrupt is not recoverable */
 	if (!(regs->msr & MSR_RI))
 		panic("Unrecoverable System Reset");

--------------060302010902060904000407--
