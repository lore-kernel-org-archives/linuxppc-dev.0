Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4777BDDD0A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Mar 2007 05:55:27 +1100 (EST)
Subject: RE: Exception in kernel mode
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 15 Mar 2007 11:55:24 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A199@MERCURY.inside.istor.com>
In-Reply-To: <45F98F28.4060708@ru.mvista.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
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


> mtspr SPRN_SPRG0, r10=20
> mtspr SPRN_SPRG1, r11

> Which is, I believe, moving r10 to SPRG0 and r11 to SPRG1.

> So, how do we know that r10 and r11 are always valid in an interrupt
> context? Are we setting aside r10 and r11 somewhere else in

    That doesn't matter to kernel at all -- they are just *saved* in
SPRG regs=20
to avoid being trashed by the exception handler.

WBR, Sergei

Well, unfortunately, now I am more confused.

The original Oops was at an NIP of 00000900, which I think means it
faulted on the first mtspr from r10. I suppose one could argue that
pipeline issues might make it fault on the second one and appear to be
the first.

But, maybe I am confusing myself here. Would I be correct in assuming
that some further instruction in the ISR at 0x900 is the culprit?

Could there possibly be some user versus supervisor mode thing going on?

My key assumption is that the timer_tick (aka Decrementer) has worked
for many hundreds of thousands of interrupts and only when running some
particular user application, like tar is there a side effect from either
a mode or some register value, race condition, or other.

Charles
