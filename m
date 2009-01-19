Return-Path: <Lee.Nipper@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1B03BDDF2A
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 07:50:00 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0JKnpUS004485
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 13:49:57 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n0JKnoPV000797
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 14:49:50 -0600 (CST)
Subject: powerpc ftrace functionality
From: Lee Nipper <lee.nipper@freescale.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 19 Jan 2009 14:51:18 -0600
Message-Id: <1232398278.24188.318.camel@al08linux99>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is ftrace functional with latest kernel on powerpc (32-bit) ?

I was checking basic functionality using the README steps.
The output of tracing/trace includes the header but nothing more (no trace lines).
It appears broken unless I'm missing something.

Below is the interaction.

Lee

# mkdir /debug
# mount -t debugfs nodev /debug
# cat /debug/tracing/available_tracers
wakeup function sched_switch nop
# cat /debug/tracing/current_tracer
nop
# echo sched_switch > /debug/tracing/current_tracer
# cat /debug/tracing/current_tracer
sched_switch
# cat /debug/tracing/trace_options
print-parent nosym-offset nosym-addr noverbose noraw nohex nobin noblock nostack
trace nosched-tree ftrace_printk noftrace_preempt nobranch annotate nouserstackt
race nosym-userobj noprintk-msg-only 
# echo 1 > /debug/tracing/tracing_enabled
# sleep 1
# cat /debug/tracing/trace > /tmp/trace.txt
# echo 0 > /debug/tracing/tracing_enabled
# cat /tmp/trace.txt
# tracer: sched_switch
#
#           TASK-PID    CPU#    TIMESTAMP  FUNCTION
#              | |       |          |         |
#
#
#
# uname -a
Linux freescale 2.6.29-rc2-00013-gf3b8436 #12 Mon Jan 19 11:28:33 CST 2009 ppc unknown
# 
# gunzip -c - < /proc/config.gz | egrep 'FTRACE|FUNCTION|SCHED_TRACER'
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_FUNCTION_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_SELFTEST=y
CONFIG_FTRACE_STARTUP_TEST=y
# dmesg | grep trace
ftrace: allocating 8054 entries in 40 pages
Testing tracer nop: PASSED
Testing tracer sched_switch: PASSED
Testing tracer function: PASSED
Testing dynamic ftrace: PASSED
Testing tracer wakeup: PASSED
# 
