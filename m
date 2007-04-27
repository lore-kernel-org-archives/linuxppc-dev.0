Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C53D2DDFA8
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 04:05:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How do external irq's get mapped?
Date: Fri, 27 Apr 2007 11:05:38 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1F0@MERCURY.inside.istor.com>
In-Reply-To: <463236E0.8070409@ru.mvista.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Sergei Shtylyov" <sshtylyov@ru.mvista.com>
Cc: Randy Brown <rbrown@istor.com>, Chris Carlson <ccarlson@istor.com>,
	Kevin Smith <ksmith@istor.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

As I understand it, the 8541 and 8555 have 12 external IRQ[0..11], 21
internal interrupts, and 4 messaging interrupts.

In looking at the MPC8555ERM.pdf file, which is my main resource, it
looks like the internal interrupt numbers for the 1st TSEC are 19 for
transmit and 20 for receive.

A 'cat /proc/interrupts' shows the 1st TSEC transmit as 93 and the
receive as 94, so I am puzzled how we get from 19 to 93 for the transmit
and from 20 to 94 for the receive. Perhaps understanding this will help
me figure out what number to put into the pci_dev structure for external
IRQ0.

At this particular moment, I can put 16, 32 or other numbers into the
pci_dev and do a request_irq for my driver in Linux-2.6.17.11. The
driver interrupts are enabled, but when "__do_IRQ" executes, its irq
variable is zero, which it should not be.

I can also see with a printk in this same "__do_IRQ" that the TSEC tx is
indeed 93, the TSEC rx is indeed 94 and the uart is 106.

Sorry to be a bit dense here, but understanding this is important to
moving forward.

Charles Krinke
