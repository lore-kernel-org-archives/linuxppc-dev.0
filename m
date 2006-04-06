Return-Path: <hbabu@us.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0FA5867A6C
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2006 08:44:34 +1000 (EST)
Received: from e31.co.us.ibm.com (e31.boulder.ibm.com [9.17.249.41])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k36KgdNQ008537
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2006 16:42:39 -0400
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k36KgaE6021868
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2006 16:42:36 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k36KdETA248472
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2006 14:39:14 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k36KgZeO007907
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2006 14:42:35 -0600
To: linuxppc-dev@ozlabs.org, fastboot@osdl.org
MIME-Version: 1.0
Subject: [PATCH/RFC] powerpc: could not stop CPU(s) even with soft-reset when
	debugger enabled
Message-ID: <OFF3123BC5.74ECB260-ON87257148.006EAC06-88257148.0071C438@us.ibm.com>
From: Haren Myneni <hbabu@us.ibm.com>
Date: Thu, 6 Apr 2006 13:47:11 -0700
Content-Type: multipart/alternative;
	boundary="=_alternative 0071C43588257148_="
Cc: michael@ellerman.id.au, David Wilder <wilder@us.ibm.com>, paulus@samba.org,
	miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 0071C43588257148_=
Content-Type: text/plain; charset="US-ASCII"

- During CPU(s) hang scenarios, kdump could not stop these CPUs. However, 
the user could invoke soft-reset to shoot down CPUs reliably. But, when 
the debugger is enabled, these CPUs are returned to hang state after they 
exited from the debugger. This patch fixes this issue by calling 
crash_kexec_secondary() before returns to previous state. 


Signed-off-by: Haren Myneni <haren@us.ibm.com>

--- 2617-rc1/arch/powerpc/kernel/traps.c.orig            2006-04-05 
13:25:22.000000000 -0700
+++ 2617-rc1/arch/powerpc/kernel/traps.c                 2006-04-05 
13:25:33.000000000 -0700
@@ -206,6 +206,16 @@ void system_reset_exception(struct pt_re
 
                 die("System Reset", regs, SIGABRT);
 
+                /*
+                 * Some CPUs which got released from debugger will 
execute this path.
+                 * These CPUs entered debugger first time via soft-reset 
- Means,
+                 * could be possible that these CPUs may not repond to an 
IPI later.
+                 * Therefore, has to call kdump func directly.
+                 * Not a problem if we exited from debugger to recover. 
In this case
+                 * there will not be any primary kexec CPU. Hence, will 
be returned.
+                 */
+                crash_kexec_secondary(regs);
+
                 /* Must die if the interrupt is not recoverable */
                 if (!(regs->msr & MSR_RI))
                                 panic("Unrecoverable System Reset");

--=_alternative 0071C43588257148_=
Content-Type: text/html; charset="US-ASCII"


<br>
<br><font size=2 face="sans-serif">- During CPU(s) hang scenarios, kdump
could not stop these CPUs. However, the user could invoke soft-reset to
shoot down CPUs reliably. But, when the debugger is enabled, these CPUs
are returned to hang state after they exited from the debugger. This patch
fixes this issue by calling crash_kexec_secondary() before returns to previous
state. </font>
<br>
<br>
<br><font size=2 face="sans-serif">Signed-off-by: Haren Myneni &lt;haren@us.ibm.com&gt;</font>
<br>
<br><font size=2><tt>--- 2617-rc1/arch/powerpc/kernel/traps.c.orig &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 2006-04-05
13:25:22.000000000 -0700<br>
+++ 2617-rc1/arch/powerpc/kernel/traps.c &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; 2006-04-05 13:25:33.000000000 -0700<br>
@@ -206,6 +206,16 @@ void system_reset_exception(struct pt_re<br>
 <br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;die(&quot;System
Reset&quot;, regs, SIGABRT);<br>
 <br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
/*<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* Some CPUs which got released from debugger will execute this path.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* These CPUs entered debugger first time via soft-reset - Means,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* could be possible that these CPUs may not repond to an IPI later.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* Therefore, has to call kdump func directly.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* Not a problem if we exited from debugger to recover. In this case<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;* there will not be any primary kexec CPU. Hence, will be returned.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;*/<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
crash_kexec_secondary(regs);<br>
+<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*
Must die if the interrupt is not recoverable */<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if
(!(regs-&gt;msr &amp; MSR_RI))<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
panic(&quot;Unrecoverable System Reset&quot;);<br>
</tt></font>
--=_alternative 0071C43588257148_=--
