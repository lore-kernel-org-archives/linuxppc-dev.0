Return-Path: <jan.kratochvil@redhat.com>
Received: from pauline.vellum.cz (pauline.vellum.cz [89.250.243.234])
	by ozlabs.org (Postfix) with ESMTP id E0466DDE2E
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 09:41:46 +1100 (EST)
Date: Mon, 26 Nov 2007 23:02:24 +0100
From: Jan Kratochvil <jan.kratochvil@redhat.com>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: PPC upstream kernel ignored DABR bug
Message-ID: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

this testcase:
	http://people.redhat.com/jkratoch/dabr-lost.c

reproduces a PPC DABR kernel bug.  The variable `variable' should not get
modified as the thread modifying it should be caught by its DABR:

$ ./dabr-lost
TID 30914: DABR 0x10012a77 NIP 0x80f6ebb318
TID 30915: DABR 0x10012a77 NIP 0x80f6ebb318
TID 30916: DABR 0x10012a77 NIP 0x80f6ebb318
TID 30914: hitting the variable
TID 30915: hitting the variable
TID 30916: hitting the variable
variable found = 30916, caught TID = 30914
TID 30916: DABR 0x10012a77
Variable got modified by a thread which has DABR still set!

At the `variable found =' line the parent ptracer found the TID thread 30916
wrote the value into the variable - despite it had DABR alrady set before.

As the behavior is dependent on the current weather I expect the scheduling
matters there.

It is important the target thread is in the `nanosleep' syscall.  If you define
WORKAROUND_SET_DABR_IN_SYSCALL in the testcase it busyloops in the userland and
the bug gets no longer reproduced.

I got it reproduced on a utrace-patched kernel on dual-CPU Power5 and Roland
McGrath reported it reproduced on the vanilla upstream kernel on a Mac G5.



Regards,
Jan Kratochvil
