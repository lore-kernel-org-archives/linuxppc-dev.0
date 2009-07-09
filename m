Return-Path: <wg@grandegger.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7BCC5B707D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 06:33:45 +1000 (EST)
Message-ID: <4A565423.6010207@grandegger.com>
Date: Thu, 09 Jul 2009 22:33:39 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Bestcomm trouble with NAPI for MPC5200 FEC
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I'm currently trying to implement NAPI for the FEC on the MPC5200 to
solve the well known problem, that network packet storms can cause
interrupt flooding, which may totally block the system. The NAPI
implementation, in principle, is straight forward and works
well under normal and moderate network load. It just calls disable_irq()
in the receive interrupt handler to defer packet processing to the NAPI
poll callback, which calls enable_irq() when it has processed all
packets. Unfortunately, under heavy network load (packet storm),
problems show up:

- With DENX 2.4.25, the Bestcomm RX task gets and remains stopped after
  a while under additional system load. I have no idea how and when
  Bestcom tasks are stopped. In the auto-start mode, the firmware should
  poll forever for the next free descriptor block.

- With 2.6.31-rc2, the RFIFO error occurs quickly which does reset the
  FEC and Bestcomm (unfortunately, this does trigger an oops because
  it's called from the interrupt context, but that's another issue).

I'm realized that working with Bestcomm is a pain :-( but so far I have
little knowledge of the Bestcomm limitations and quirks. Any idea what
might go wrong or how to implement NAPI for that FEC properly.

TIA,

Wolfgang.
