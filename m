Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16B19DDEF4
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 May 2007 08:11:29 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How do external irq's get mapped?
Date: Wed, 2 May 2007 15:11:27 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A201@MERCURY.inside.istor.com>
In-Reply-To: <762644B1-26D0-4D16-BA36-55364CACB0D4@freescale.com>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Andy Fleming" <afleming@freescale.com>
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

> The new problem is that if I set the irq to 112, when it is =20
> insmodded, I
> get an error from open_pic.c of the form:
>
> Open_pic.c:720 invalid irq 112
>
> This seems to be coming from the macro at line 144 in open_pic.c
>
> #define check_arg_irq(irq) \
>     if (irq < open_pic_irq_offset || irq >=3D
> NumSources+open_pic_irq_offset \
> 	|| ISR[irq - open_pic_irq_offset] =3D=3D 0) { \
>       printk("open_pic.c:%d: invalid irq %d\n", __LINE__, irq); \
>       dump_stack(); }


Any  chance you can identify:

1) Where this macro is being called from when it fails

2) Which of the 3 conditions above are actually true

Andy

Dear Andy:

In our system, open_pic_irq_offset=3D80, numSources=3D60, *but* ISR[irq =
-
open_pic_irq_offset]=3DNULL when irq 112 is enabled.

It looks to me like each call to openpic_set_sources inits ISR[]
elements according to the first two arguments. We have two calls to
openpic_set_sources.=20

Internal irqs 00..31, 1st openpic_set_sources(0, 32) -- ISR[0..32]
External irqs 48..60, 2nd openpic_set_sources(48, 12) -- ISR[48..60]=20

But ISR[112] is never initialized in the source base.

I tried the cheap shot of adding a third openpic_set_sources(112, 12),
but I suspect the real answer is a bit more complicated then that.

Again, I thank you for your kind words while I struggle through this
external interrupt initalization for the PPC8541 in the Linux-2.6.17.11
kernel.

Charles Krinke
