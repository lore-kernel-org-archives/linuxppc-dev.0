Return-Path: <allanjos@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.196])
	by ozlabs.org (Postfix) with ESMTP id A54AB68A7A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 29 Jan 2006 10:02:53 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id z31so828954nzd
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Jan 2006 15:02:51 -0800 (PST)
Message-ID: <7a2435710601281502k2b302ea2mfa73033fe7062a32@mail.gmail.com>
Date: Sat, 28 Jan 2006 19:02:51 -0400
From: Moloko Vellocet <allanjos@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: MPC5200 - Problem with PSC mode
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, I'm configuring a MPC5200 in PSC3 mode to communicate with a
telephony board that send information to the MPC5200 continuously. In
the osciloscope I see the signals comming via RX pin, but when I read
RX buffer it doesn't contain anything and when I write in the TX
buffer the flags show that buffer is not empty, but in the osciloscope
I don't see any signal in TX pin. I can't enable the interrupt mode
too.

Can anyone help me?

Part of the configuration code:

out_8(&psc->command, MPC5xxx_PSC_TX_DISABLE | MPC5xxx_PSC_RX_DISABLE);

val32 =3D in_be32(&gpio->port_config);
val32 &=3D ~0x700;
val32 |=3D 0x600;
out_be32(&gpio->port_config, val32);

out_8(&psc->command, MPC5xxx_PSC_RST_RX |
         MPC5xxx_PSC_RST_TX |
         MPC5xxx_PSC_SEL_MODE_REG_1 |
         MPC5xxx_PSC_RST_ERR_STAT);

out_be16(&psc->mpc5xxx_psc_imr, 0);

out_be16(&psc->rfalarm, 0x0004);

out_be16(&psc->tfalarm, 0x0004);

out_be32(&psc->sicr, 0x221000);

out_8(&psc->command, MPC5xxx_PSC_RST_RX |
         MPC5xxx_PSC_RST_TX |
         MPC5xxx_PSC_SEL_MODE_REG_1 |
         MPC5xxx_PSC_RST_ERR_STAT);

spin_lock_irqsave(&mpc5xxx_serial_lock, my_flags);

val16 =3D in_be16(&psc->mpc5xxx_psc_imr);

val16 =3D MPC5xxx_PSC_IMR_TXRDY | MPC5xxx_PSC_IMR_RXRDY;

out_be16(&psc->mpc5xxx_psc_imr, val16);

spin_unlock_irqrestore(&mpc5xxx_serial_lock, my_flags);

out_8(&psc->command, MPC5xxx_PSC_RX_ENABLE | MPC5xxx_PSC_TX_ENABLE);


So.. with this I tried to read the RX and write in TX buffer.




Thank you.




--
_______________________________
Allann J. O. Silva

"I received the fundamentals of my education in school, but that was
not enough. My real education, the superstructure, the details, the
true architecture, I got out of the public library. For an
impoverished child whose family could not afford to buy books, the
library was the open door to wonder and achievement, and I can never
be sufficiently grateful that I had the wit to charge through that
door and make the most of it." (from I. Asimov, 1994)
