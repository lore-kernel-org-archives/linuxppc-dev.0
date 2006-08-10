Return-Path: <benwei@veriwave.com>
Received: from cia.veriwave.com (mail.veriwave.com [64.1.198.186])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4912967B7E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 09:34:07 +1000 (EST)
Received: from [10.100.2.152] ([10.100.2.152]) (authenticated bits=0)
	by cia.veriwave.com (8.12.11.20060308/8.12.8) with ESMTP id
	k7AN3kqO015042
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linuxppc-embedded@ozlabs.org>; Thu, 10 Aug 2006 16:03:46 -0700
Subject: Realtime preemption patch on PPC
From: Ben Weintraub <benwei@veriwave.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Thu, 10 Aug 2006 16:04:32 -0700
Message-Id: <1155251072.5950.80.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Howdy,

I'm wondering if anyone has had success getting Ingo Molnar's realtime
preemption patch (the one here:
http://people.redhat.com/mingo/realtime-preempt/ ) working on the ppc
arch.  

I'm working with patch-2.6.17-rt8 (the latest) and linux-2.6.17.  The
realtime-preempt patch seems to include the generic timeofday patch, but
with no support for the ppc arch, only powerpc, so I've hacked in
support for ppc by basically replicating the powerpc arch-specific stuff
found here:
http://sr71.net/~jstultz/tod/archive/linux-2.6.17-rc3_timekeeping_C2/broken-out/linux-2.6.17-rc3_timeofday-arch-ppc_C2.patch

I can attach my patch if anyone would like, but for all I know it could
be wildly inaccurate.  

Anyhow, when I boot on an MPC8555 with my hack, I get an endless stream
of:

BUG: sleeping function called from invalid context init(1) at
arch/powerpc/math-emu/math.c:226
in_atomic():0 [00000000], irqs_disabled():1
Call Trace:
[A0BB3E90] [A000934C] show_stack+0x48/0x194 (unreliable)
[A0BB3EC0] [A001B7DC] __might_sleep+0xe8/0xf4
[A0BB3EE0] [A00136C0] do_mathemu+0x30/0x8c8
[A0BB3F00] [A00036AC] program_check_exception+0x1ac/0x514
[A0BB3F40] [A0002A08] ret_from_except_full+0x0/0x4c

Line 226 in arch/powerpc/math-emu/math.c is part of the do_mathemu()
function, and contains a call to get_user(), which calls
__might_sleep(), causing this problem.  

I did find this message in the LKML archives describing a very similar
problem:
http://lkml.org/lkml/2006/2/23/312

And so tried putting a call to local_irq_enable() before the call to
do_mathemu() in program_check_excpetion(), but this causes a hard lockup
with no messages printed when I try to bring up my network interface.  I
assume this means I've done something Very Bad with interrupts by adding
in local_irq_enable() at the wrong spot.  I also tried adding it at the
exact same spot as the patch given by Paul in his reply, but in this
case I still get the endless stream of BUG messages.

Can anyone offer some guidance or advice?

Thanks so much,
Ben 
