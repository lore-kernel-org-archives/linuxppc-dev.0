Return-Path: <markc@mail.com>
Received: from relay04.roc.ny.frontiernet.net (relay04.roc.ny.frontiernet.net
	[66.133.131.37]) by ozlabs.org (Postfix) with ESMTP id 45B1B67A30
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Feb 2005 00:11:30 +1100 (EST)
Received: from filter02.roc.ny.frontiernet.net
	(filter02.roc.ny.frontiernet.net [66.133.131.177])
	by relay04.roc.ny.frontiernet.net (Postfix) with ESMTP id D213910685
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Feb 2005 13:11:25 +0000 (UTC)
Received: from relay04.roc.ny.frontiernet.net ([66.133.131.37])
	by filter02.roc.ny.frontiernet.net (filter02.roc.ny.frontiernet.net
	[66.133.131.177]) (amavisd-new, port 10024)
	with LMTP id 16961-60-97 for <linuxppc-embedded@ozlabs.org>;
	Wed, 2 Feb 2005 13:11:25 +0000 (UTC)
Received: from chuck2 (70-97-124-104.br1.rmn.wv.frontiernet.net
	[70.97.124.104])
	by relay04.roc.ny.frontiernet.net (Postfix) with ESMTP id 8FA8F1066E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Feb 2005 13:11:22 +0000 (UTC)
Message-ID: <002b01c50929$3bd6f720$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <DE2CC66C40EAB74EA6D66AC71BF98E1E03055B60@TQ-MAILSRV-1>
Date: Wed, 2 Feb 2005 08:15:11 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: The RS485 driver problem...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


linuxppc-embedded-bounces@ozlabs.org wrote on :
> If you want to connect a RS485 transceiver to a normal UART, you
> always have the problem of dealing with enabling/disabling
> transmitter and recveiver. I have seen hardware that misuses RS-232
> hardware handshaking lines (RTS/CTS) for this purpose. What I have
> not been able to find is a linux driver or software solution to this
> problem. 
> 
> Has anybody used the CPM uarts (or even a standard 16C550 uart) for
> this purpose? How?

I took a look at some old non-linux code for the MPC860, and it appears
that the RTSM bit in GSMR_H provides switched-RTS in UART mode.
It will negate RTS after the last character in a BD.  (SCCs only, not SMC)

Another trick you can use, depending on your hardware config, is to loop
your transmit data back to receive.  When you receive the last character
you sent you know it's safe to turn off RTS, and since you're getting an
interrupt it's deterministic.

Mark Chambers
