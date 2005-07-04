Return-Path: <f.janot@ateme.fr>
Received: from postman.ateme.net (postman.ateme.net [217.167.236.59])
	by ozlabs.org (Postfix) with ESMTP id A8E1767C26
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Jul 2005 20:13:40 +1000 (EST)
Received: from pc179 (pc-179.ateme.net [172.16.16.179])
	by postman.ateme.net (Postfix) with SMTP id 228E84B8019
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Jul 2005 11:45:23 +0200 (CEST)
Message-ID: <00aa01c5807d$192ca230$b31010ac@pc179>
From: "Frederic Janot" <f.janot@ateme.fr>
To: <linuxppc-embedded@ozlabs.org>
Date: Mon, 4 Jul 2005 11:45:23 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: mpc5200 i2c bus problem
Reply-To: Frederic Janot <f.janot@ateme.fr>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I send a message here to indicate an hardware problem with mpc5200 i2c
module. This bug is not describe in the mpc5200 errata document.
I can reproduce it on revA and revB of the silicium. After contacting
Freescale, they recognize the problem.

The problem is that, sometime, the 9th pulse clock on SCL is missing !!!!
I can send a scope screen capture which shows that if someone wants.

When it happens, the slave does not release SDA bus because it waits to send
its acknowledge
=> the bus is locked (we cannot get slave status and we cannot generate stop
condition to release the bus)

The problem appears more frequently with IPB clock at 132MHz than with IPB
clock at 66MHz (looks like a timing problem into i2c module)
Freescale advice to set i2c clock at 86 kHz but the problem still appears
with my board !

I used a kernel based on Denk's one (2.4.25). The i2c driver call
wait_for_bb (bus busy) with a timeout. When the bus is locked, this function
always return with an error code => no more i2c transferts possible.

To workaround this problem, the solution is to "manually" generate the 9th
pulse clock.

The sequence is the following :
mcr = 0x00 (disable i2c module)
mcr = 0x80 (re-enable i2c module)
mcr = 0x30 (re-disabling i2c bus, it makes SCL goes high)          => not
really sure if we should send 0x30 or if 0x00 is enough, I will try
mcr = 0xb0 (generate a start condition, it makes SCL goes low)
mcr = 0x80 (generate a stop condition, it makes SCL goes high)

After that, the bus is available again.
We have to re-send last i2c transfert (the one which locked the bus) because
we can not be sure that slave well understand the i2c request.

Hope it can help,
Frederic
