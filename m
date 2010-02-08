Return-Path: <john.jarvis@tel.com>
Received: from chrysaor.tel.co.jp (chrysaor.tel.co.jp [218.45.244.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7E7A1B7D14
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Feb 2010 20:54:51 +1100 (EST)
Received: from euryale.tel.co.jp (euryale.tel.co.jp [192.168.117.39])
	by chrysaor.tel.co.jp (8.13.8/8.13.8) with SMTP id o189MBSX023734
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2010 18:22:11 +0900
Received: from TELIS0024.asia.tel.com ([10.163.142.134])
	by medusa.tel.co.jp (8.13.8/8.13.8) with ESMTP id o189MBsP021345
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2010 18:22:11 +0900
From: <john.jarvis@tel.com>
To: <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 8 Feb 2010 18:22:09 +0900
Subject: CPU usage spikes with MPC8377E IRQs
Message-ID: <55734BD5AF9AFC4EBFB8652657DE8A79BEC813ECE6@TELIS6322.asia.tel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I'm developing software for a custom MPC8377E-based board. I've run
into a strange problem that has me completely stumped and I would be
forever grateful for any suggestions or pointers.

I have a kernel module that basically handles IRQs produced every 1ms
and wakes up any processes that are blocked waiting. (The event is
saved in case a process has requested notification but is not waiting
at the moment the IRQ occurs.)

This works, except that every 28 seconds the IRQ thread, workqueue,
and user task all suddenly take up 100% CPU for 3 or 4 seconds.
(around 97% sys, then 97% IRQ, according to top) When this happens,
deadlines aren't met, watchdogs bark, motors crash, global warming
occurs...

Removing the workqueue and user task from the system simply isolates
an IRQ thread whose CPU usage spikes every 28 seconds. This has been
observed with both GTM and external IRQs. (I haven't tested others)

So, basically, for the GTM, the execution path is:

IRQ =3D> IPIC =3D> IRQ thread ACKs timer and returns IRQ_HANDLED =3D> IPIC =
=3D> IRQ

That's all. Spikes every 28 seconds.

System specs
------------------
CPU: MPC8377E (33.333Mhz timebase/133Mhz csb/400Mhz core)
Board: Custom
System controller: FPGA connected to the eLBC
Memory: DDR 1GB
ROM: NOR Flash connected to the FCM
RTC: None

Bootloader: U-Boot 1.3.3
Kernel: Linux 2.6.29-rt24
LTIB: mpc837xerdb-20081113=20
        (w/custom configs. We started on an MPC8313ERDB)

Some notes:

* Spinlocks don't make a difference. (It's single-core anyway)
* Using a workqueue adds a thread to the workflow, but the spikes
  still occur at the same frequency. (Actually, IRQ thread jumps
  around 2s after workqueue)
* Changing the frequency of IRQs changes the time between spikes
   between 1ms increments.  1ms, 2ms, 3ms are all the same. Fractions
   are different.
* RT_PREEMPT kernel + real-time priority on user space task makes the
  spikes shorter, but they still occur every 28 seconds.
* Kernel debug options seem to have no effect.

I have a version which sets up GTM1/Timer1 and ACKs event IRQs which I
can share if anyone is interested. It's a 3KB tgz. You'll have to modify th=
e=20
Makefile to fit your cross-compiler environment, and maybe edit the registe=
r=20
offset macros, too. But I think it's pretty generic code.

If there is a more approriate place to make this inquiry, please let me kno=
w.
(I think the traffic here is mostly kernel patches?)

Thank you,
John Jarvis =
