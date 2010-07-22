Return-Path: <dvhltc@us.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DEE3EB70D2
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 04:24:28 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6MI7vVZ027968
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 14:07:57 -0400
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6MIONrh392008
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 14:24:23 -0400
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6MIOIo1030802
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 12:24:19 -0600
Message-ID: <4C488CCD.60004@us.ibm.com>
Date: Thu, 22 Jul 2010 11:24:13 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Gautham R Shenoy <ego@in.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Will Schmidt <willschm@us.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While testing CPU offline/online, we hit various preempt_count related
bugs. Various hacks have been employed for several theoretical corner
cases. One situation however is perfectly repeatable on 2.6.33.6 with
CONFIG_PREEMPT=y.

BUG: scheduling while atomic: swapper/0/0x00000065
Modules linked in: autofs4 sunrpc ipv6 dm_mirror dm_region_hash dm_log
dm_mod ehea sg ext4 jbd2 mbcache sd_mod crc_t10dif ibmvscsic
scsi_transport_srp scsi_tgt [last unloaded: scsi_wait_scan]
Call Trace:
[c00000010e9e39f0] [c0000000000144d4] .show_stack+0x74/0x1c0 (unreliable)
[c00000010e9e3aa0] [c00000000007a680] .__schedule_bug+0xa0/0xb0
[c00000010e9e3b30] [c00000000056dea4] .schedule+0x7a4/0xd60
[c00000010e9e3cd0] [c000000000016be8] .cpu_idle+0x1f8/0x220
[c00000010e9e3d80] [c00000000057d858] .start_secondary+0x388/0x3c0
[c00000010e9e3e30] [c000000000008278] .start_secondary_resume+0x10/0x14

With some instrumentation we were able to determine that the
preempt_count() appears to change across the extended_cede_processor()
call.  Specifically across the plpar_hcall_norets(H_CEDE) call. On
PREEMPT_RT we call this with preempt_count=1 and return with
preempt_count=0xffffffff. On mainline with CONFIG_PREEMPT=y, the value
is different (0x65) but is still incorrect.

Also of interest is that this path
cpu_idle()->cpu_die()->pseries_mach_cpu_die() to start_secondary()
enters with a preempt_count=1 if it wasn't corrupted across the hcall.
The early boot path from _start however appears to call
start_secondary() with a preempt_count of 0.

The following patch is most certainly not correct, but it does eliminate
the situation on mainline 100% of the time (there is still a 25%
reproduction rate on PREEMPT_RT). Can someone comment on:

1) How can the preempt_count() get mangled across the H_CEDE hcall?
2) Should we call preempt_enable() in cpu_idle() prior to cpu_die() ?

Hacked-up-by: Darren Hart <dvhltc@us.ibm.com>

Index: linux-2.6.33.6/arch/powerpc/platforms/pseries/hotplug-cpu.c
===================================================================
--- linux-2.6.33.6.orig/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ linux-2.6.33.6/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -138,6 +138,7 @@ static void pseries_mach_cpu_die(void)
 			 * Kernel stack will be reset and start_secondary()
 			 * will be called to continue the online operation.
 			 */
+			preempt_count() = 0;
 			start_secondary_resume();
 		}
 	}


-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
