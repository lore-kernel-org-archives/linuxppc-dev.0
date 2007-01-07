Return-Path: <tnt@246tNt.com>
Received: from outmx018.isp.belgacom.be (outmx018.isp.belgacom.be
	[195.238.4.117])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0488DDE3A
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 10:40:32 +1100 (EST)
Received: from outmx018.isp.belgacom.be (localhost [127.0.0.1])
	by outmx018.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l07NeOAI006879
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Jan 2007 00:40:25 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <45A18467.8070302@246tNt.com>
Date: Mon, 08 Jan 2007 00:38:15 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>		<1166528379.19254.69.camel@localhost.localdomain>		<4587D338.7060906@246tNt.com>		<1166538553.25827.99.camel@pmac.infradead.org>		<1166558300.19254.71.camel@localhost.localdomain>		<1167773388.22068.443.camel@pmac.infradead.org>		<1167773863.6165.82.camel@localhost.localdomain>		<1167775493.3660.23.camel@shinybook.infradead.org>		<528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>		<45A01416.6080401@genesi-usa.com>	<528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>	<45A1535C.1080007@genesi-usa.com>	<f0c5df8b1d2bcc1abcd04894e0210cc1@kernel.crashing.org>	<45A16FF1.5000401@genesi-usa.com>
	<45A175B3.4010506@246tNt.com> <45A17D1A.4050201@genesi-usa.com>
In-Reply-To: <45A17D1A.4050201@genesi-usa.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC DEV <linuxppc-dev@ozlabs.org>, bbrv@genesi-usa.com,
	Paul Mackerras <paulus@samba.org>, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey wrote:
> So, giving it some other name is no problem at all. Just add the name
> into the
> list. You can never get rid of the list, and adding entries.. well..
> it may
> look clumsy, but it is not wrong! Especially if you're the first to
> name it.
> Linux should, I am saying, match against what the firmware provides, not
> vice-versa. I don't think it's logical for firmware vendors to keep
> changing
> names or maintain these huge lists... 
For devices themselves (like serial, fec, ...), if there was only issues
there,
I must admit I'd consider just adding the other "compatible" property (look
at the current mpc52xx_uart.c driver, it has an entry only for the efika).
BUT :
 - I'd really prefer to have it with the standard name, we're early
enough to
   change it and I love consistency ;)
 - The "other" name must _not_ conflict with the official one (and here
   that's not the case, mpc5200-ata would trigger activation of 5200 errata
   correction for ATA ... )
 - You will anyway release an update so _why_ not change that, I haven't
   heard so far a single good reason why not ...
 - For more "system" parts (like bestcomm/sram/pic), there it's a lot more
   annoying and I just want the received dt to exactly fit.

Since some changes couldn't be handled by just adding en entry to the
of_match
table (chrp type, missing irqs, sram type, ...) , I needed fixups anyway
so I
implemented all the fixups I'd like to see and deal with it in a single
place,
so at the end I have things exactly like for other 52xx boards ...

> just because of a philosophical difference
> on 2 lines of code in Linux? Especially when the other OS guys have
> not made
> any fuss..
But did the other OS support other 52xx board ? (question, I really
don't know)

If it only needed another "compatible" entry in the driver list of a
couple of
driver, and that there was no way the fw could ever change, I think we would
have (reluctantly ;) done it, but the problem is both deeper and the vendor
(you ;) have the clear opportunity to fix it better.


    Sylvain
