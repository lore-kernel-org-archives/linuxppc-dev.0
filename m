Return-Path: <ktdann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.196])
	by ozlabs.org (Postfix) with ESMTP id 479E567E03
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  1 Aug 2005 12:00:30 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i30so1243848wra
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 31 Jul 2005 19:00:29 -0700 (PDT)
Message-ID: <9b7ca6570507311900212f0179@mail.gmail.com>
Date: Mon, 1 Aug 2005 11:00:29 +0900
From: Daniel Ann <ktdann@gmail.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: openpic_init() functionality
Reply-To: Daniel Ann <ktdann@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi folks,

Just been reading openpic_init() function and found something weird,
so I thought I might turn to pro.
It's a part where it initialises all external sources. Code goes
something like this,
[begin]
    /* Init all external sources, including possibly the cascade. */
    for (i =3D 0; i < NumSources; i++) {
        int sense;

        if (ISR[i] =3D=3D 0)
            continue;
[snip]
      openpic_initirq(i, 8, i+offset, (sense & IRQ_POLARITY_MASK),
              (sense & IRQ_SENSE_MASK));
[end]

I can see what openpic_initirq does. But what I dont see is enable
part. openpic_initirq only configures interrupt but does not enable
it. And going thru the rest of the code, nothing calls
openpic_enable_irq().
Can somebody tell me how should these interrupts get enabled ?

Reason is, if I dont force openpic_enable_irq() after
openpic_initirq(), then at the end of booting, I see none of my
interrupts enabled. Im sure somewhere down the line it should get
enabled, but where ?

I'd appreciate your thoughts on this.

--=20
Daniel
