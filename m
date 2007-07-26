Return-Path: <daniel.schnell@marel.com>
Received: from mail.marel.com (mail.marel.com [213.167.134.96])
	by ozlabs.org (Postfix) with ESMTP id CCEA6DDE23
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jul 2007 19:37:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH] mpx5200_uart: drop port lock across tty_flip_buffer() call
Date: Thu, 26 Jul 2007 09:25:05 -0000
Message-ID: <DD39B5C3F4963040ADC9768BE7E430CB02178125@is-hdq-exchange.marel.net>
In-Reply-To: <1185392838.3227.13.camel@chaos>
References: <1185390656.3227.12.camel@chaos><fa686aa40707251242i6be0e30pd3b4019686308b0@mail.gmail.com>
	<1185392838.3227.13.camel@chaos>
From: "Daniel Schnell" <daniel.schnell@marel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thomas Gleixner wrote:

> On Wed, 2007-07-25 at 13:42 -0600, Grant Likely wrote:
>> On 7/25/07, Thomas Gleixner <tglx@linutronix.de> wrote:
>>> The port lock needs to be dropped across the tty_flip_buffer call,
>>> as it would lead to a deadlock with the spin_lock(&port->lock) in
>>> uart_start()=20
>>>=20
>>> Uncovered by lockdep / preempt-rt
>>>=20
>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

While you are at it 8=B0> ... the mpc5200-fec driver has serious =
problems with preempt-rt, similar to what the IBM emac had ....


Best regards,

Daniel Schnell.
