Return-Path: <Martin.Krause@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [213.68.230.225])
	by ozlabs.org (Postfix) with ESMTP id 1037067A30
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Feb 2005 19:28:02 +1100 (EST)
Received: from tq-mailsrv-1.tq-net.de (tq-mailsrv-1 [172.20.1.1])
	by mail.tqs.de (Postfix) with ESMTP id 89FC33DDC
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Feb 2005 09:28:00 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 2 Feb 2005 09:27:59 +0100
Message-ID: <DE2CC66C40EAB74EA6D66AC71BF98E1E03055B60@TQ-MAILSRV-1>
From: "Martin Krause" <Martin.Krause@tqs.de>
To: "David Jander" <david.jander@protonic.nl>, <linuxppc-embedded@ozlabs.org>
Subject: AW: The RS485 driver problem...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

linuxppc-embedded-bounces@ozlabs.org wrote on :
> If you want to connect a RS485 transceiver to a normal UART, you
> always have the problem of dealing with enabling/disabling
> transmitter and recveiver. I have seen hardware that misuses RS-232
> hardware handshaking lines (RTS/CTS) for this purpose. What I have
> not been able to find is a linux driver or software solution to this
> problem.=20
>=20
> Has anybody used the CPM uarts (or even a standard 16C550 uart) for
> this purpose? How?

Yes, we used normal UARTs several times to form a RS485 interface. It=20
is a bit tricky, because you must disable the transmitter just in time
after the last bit of a message has been left the transmit shift
register. Otherwise the answer from the addressed bus node could be
(partly) overwritten. It depends on your bus protocol how much time
you could afford to disable the transmitter. Since linux is not a
real time OS, and the transmitter is controlled by software (we use
an GPIO for this), there is no guarantee that this works under all
circumstances fast enough.
For us it is working well with a baudrate of 38.400 und a maximum
time of < 400 us to disable the transmitter after sending a message.=20
We used a 16752 UART. The driver could be found in the 'linuxarm'=20
kernel tree on the Denx CVS server (look at www.denx.de). If you=20
couldn't use CVS I could send you the driver sources directly.

Regards,
Martin
