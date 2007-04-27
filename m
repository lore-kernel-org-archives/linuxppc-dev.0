Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7DC58DDFDA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 03:38:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How do external irq's get mapped?
Date: Fri, 27 Apr 2007 10:38:38 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1EF@MERCURY.inside.istor.com>
In-Reply-To: <46322CE4.1060004@ru.mvista.com>
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



-----Original Message-----
From: Sergei Shtylyov [mailto:sshtylyov@ru.mvista.com]=20
Sent: Friday, April 27, 2007 10:04 AM
To: Charles Krinke
Cc: Jon Loeliger; Randy Brown; Chris Carlson; Kevin Smith;
linuxppc-embedded@ozlabs.org
Subject: Re: How do external irq's get mapped?

Hello.

Charles Krinke wrote:

> Let me try a more simplified IRQ question a different way by only
> referring to the 8541.

> There are 12 external interrupt sources, irq[0..11] and as I
understand
> it, they all go through one vector, ExternalInput set in
> head_fsl_booke.S and this vector resolves to "do_IRQ()", which I
believe
> is in arch/powerpc/kernel/irq.c (not arch/ppc/kernel/...).

> I am striving to understand how mapping of these external pins
> irq[0..11] gets to IRQ numbers as shown with "cat /proc/interrupts".

    IIUC, the external IRQ #'s should follow those occupied by 32
internal IRQs.
    But those shown in that file are "virtual" numbers, i.e. they got
re-mapped by the kernel as it sees fit (basically, it tries to assign
the same # to IRQs above 15 and remaps those below)

> Could someone point me at some references I can read to understand
this
> nuance of the 8541 in a linux-2.6.17.11 kernel, please.

   I'm not sure arch/powerpc/ in 2.6.17 had the complete MPC8541
support...

WBR, Sergei

So would this mean that the external IRQ0 pin would map to irq #32 and
not irq #16 and the external IRQ11 pin would map to irq #43 and not irq
#27? So that if I want IRQ0, I would set my irq member of the pci_dev
struct to 32?

Charles=20
