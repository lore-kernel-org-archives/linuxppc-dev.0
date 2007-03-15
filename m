Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D0C08DDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 08:17:27 +1100 (EST)
Subject: RE: Exception in kernel mode
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 15 Mar 2007 14:17:25 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A19B@MERCURY.inside.istor.com>
In-Reply-To: <7691A67C-C3D9-4882-9BCC-E3AA617AD11E@kernel.crashing.org>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: Chris Carlson <ccarlson@istor.com>, Kevin Smith <ksmith@istor.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I ran a couple of more tests and the system did not Oops in the
timer_interupt except for the first test this morning. The last two
times, the NIP was=20

Oops: Exception in kernel mode, sig: 4 [#1]
PREEMPT
NIP: C002CE68 LR: C002CEC8 CTR: 00003B25
REGS: c3119a00 TRAP: 0700   Not tainted  (2.6.17.11)
MSR: 00081032 <ME,IR,DR>  CR: 88022484  XER: 00000000
TASK =3D c3ecd870[920] 'tar' THREAD: c3118000

And

Oops: Exception in kernel mode, sig: 4 [#1]
PREEMPT
NIP: C00DEE18 LR: C00DEDD8 CTR: 00000000
REGS: c299dbc0 TRAP: 0700   Not tainted  (2.6.17.11)
MSR: 00081032 <ME,IR,DR>  CR: 84022488  XER: 20000000
TASK =3D c3e2b7d0[925] 'tar' THREAD: c299c000

For comparision, this is the original one from this morning

Oops: Exception in kernel mode, sig: 4 [#1]
PREEMPT
NIP: 00000900 LR: C00E579C CTR: 00003A55
REGS: c37f3b00 TRAP: 0700   Not tainted  (2.6.17.11)
MSR: 00081000 <ME>  CR: 24022484  XER: 00000000
TASK =3D c3eaf810[940] 'tar' THREAD: c37f2000

I have to conclude this is not necessarily a timer_interrupt problem.
Also, commenting out the innards of the timer_interrupt causes the
kernel to hang in its boot right after the message

Memory: xxxK available

So a properly functioning timer_interrupt is essential to the the kernel
booting.=20

But, ... At this point, I really don't know which way to jump.

Charles
