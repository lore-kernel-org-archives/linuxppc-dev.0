Return-Path: <dwilder@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6AB5D67A62
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Apr 2006 08:25:39 +1000 (EST)
Received: from e33.co.us.ibm.com (e33.boulder.ibm.com [9.17.249.43])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3ALnCMH022488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 17:49:13 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e33.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k3ALmsAn000979
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 17:48:54 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3ALjRne039162
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 15:45:27 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3ALmsHn011631
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Apr 2006 15:48:54 -0600
Message-ID: <443ADCF5.60702@us.ibm.com>
Date: Mon, 10 Apr 2006 15:32:21 -0700
From: David Wilder <dwilder@us.ibm.com>
MIME-Version: 1.0
To: fastboot@lists.osdl.org, linuxppc-dev@ozlabs.org, akpm@osdl.org,
	mchintage@in.ibm.com, paulus@samba.org, hbabu@us.ibm.com
Subject: [PATCH] kdump-ppc64-xmon-stop-cpu
Content-Type: multipart/mixed; boundary="------------010604040804070009050406"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010604040804070009050406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 3 of 3

- During CPU(s) hang scenarios, kdump could not stop these CPUs. 
However, the user could invoke soft-reset to shoot down CPUs reliably. 
But, when the debugger is enabled, these CPUs are returned to hang state 
after they exited from the debugger. This patch fixes this issue by 
calling crash_kexec_secondary() before returns to previous state.

Please pick up this patch.

-- 
David Wilder
IBM Linux Technology Center
Beaverton, Oregon, USA 
dwilder@us.ibm.com
(503)578-3789


--------------010604040804070009050406
Content-Type: text/x-patch;
 name="kdump-ppc64-xmon-stop-cpu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kdump-ppc64-xmon-stop-cpu.patch"


- During CPU(s) hang scenarios, kdump could not stop these CPUs. However, the user could invoke soft-reset to shoot down CPUs reliably. But, when the debugger is enabled, these CPUs are returned to hang state after they exited from the debugger. This patch fixes this issue by calling crash_kexec_secondary() before returns to previous state.

Signed-off-by: David Wilder <dwilder@us.ibm.com>
Signed-off-by: Haren Myneni <haren@us.ibm.com>

--- 2617-rc1/arch/powerpc/kernel/traps.c.orig	2006-04-05 13:25:22.000000000 -0700
+++ 2617-rc1/arch/powerpc/kernel/traps.c	2006-04-05 13:25:33.000000000 -0700
@@ -206,6 +206,16 @@ void system_reset_exception(struct pt_re
 
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

--------------010604040804070009050406--
