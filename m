Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE006.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B87091007D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Apr 2011 06:41:20 +1000 (EST)
Date: Fri, 15 Apr 2011 15:41:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: Eran Duchan <pavius@gmail.com>
Subject: Re: Non-console UART issues with 8xx
Message-ID: <20110415154110.1b523da0@schlenkerla.am.freescale.net>
In-Reply-To: <BANLkTik=ivFpWQEhqrVnYfr2LS4HSnTDuA@mail.gmail.com>
References: <BANLkTik=ivFpWQEhqrVnYfr2LS4HSnTDuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 15 Apr 2011 02:52:22 +0300
Eran Duchan <pavius@gmail.com> wrote:

> Hey list
>=20
> I have a custom MPC875 board running 2.6.37. SMC1 is the console, SCC4 is=
 a
> general purpose UART (DTS is set up accordingly). No hardware or software
> flow control for either.
>=20
> The issue is simple: the non-console UART transmits garbled characters at
> the end of the transmission.

Hmm, there's a wait_closing field in uart_cpm_port that doesn't seem to be
initialized anywhere.

The driver should also be sending the STOP_TX/GRA_STOP_TX command *before*
clearing the transmit enable bits, rather than after.

>  For example, set up SMC1 to console (works
> perfect) and SCC4 as non-console, run stty -F /dev/ttyCPM1 19200 raw and
> then echo -n 1234567890 > /dev/ttyCPM1 - transmission may be something li=
ke
> "1234567=C3=B8". Set the SCC4 as console (same baud rates) and the proble=
m is
> reversed (SCC4 works perfect, SMC1 transmit garbled).
>=20
> Rx direction seems fine, after some rudementary testing.
>=20
> I dived into the code and see that the console UART has a completely
> different initialization sequence than the non-console UART. Short of div=
ing
> into this ancient CPM architecture - does anyone have an idea?

The console is a bit different because it has a user that isn't tied to an
open file-handle -- which doesn't interact well with the driver's
(possibly misguided) desire to actually deconfigure the hardware when not
open.

-Scott
