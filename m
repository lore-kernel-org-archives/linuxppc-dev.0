Return-Path: <Bjorn.Ostby@combitech.se>
Received: from ms-101.aerotechtelub.se (ms-101.aerotechtelub.se
	[192.176.33.163]) by ozlabs.org (Postfix) with ESMTP id CD6F4679F4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Feb 2006 22:01:34 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: SCCx UART status on 8xx
Date: Tue, 21 Feb 2006 12:01:33 +0100
Message-ID: <004B1D7A5257174C9044A1B7BD0E60ED0178CC54@ratatosk.combitechsystems.com>
From: =?iso-8859-1?B?Qmr2cm4g1nN0Ynk=?= <Bjorn.Ostby@combitech.se>
To: "Aristeu Sergio Rozanski Filho" <aris@mandriva.com>
Cc: fbl@conectiva.com.br, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all again,

-----Original Message-----
From: Aristeu Sergio Rozanski Filho [mailto:aris@mandriva.com]=20
Sent: den 20 februari 2006 15:19
To: Bj=F6rn =D6stby
Cc: linuxppc-embedded@ozlabs.org; marcelo.tosatti@cyclades.com; =
fbl@conectiva.com.br
Subject: Re: SCCx UART status on 8xx


On Mon, Feb 20, 2006 at 02:37:23PM +0100, Bj=F6rn =D6stby wrote:
> Hello,
> I'm messing with a mpc823e based board trying to enable the SCC3 UART. =

> I'm using the 2.4.25 denx linux_ppc kernel and I've got SMC1 for =
console and SMC2 up and running but I'm in desperate need of another =
rs232 port (which is on SCC3 on my board).
> Reading quite a lot of old posts on this mailing list got me confused =
whether the SCCx UART support in the kernel is ready to be used on 8xx =
or if there will take a large amount of hacking to get things going =
(reading the header of 8xx_io/uart.c got me wondering even more).
> Current situation is that I have enabled the SCC3 UART in the kernel, =
set the correct CTS, RTS and CD signal options and finally disabled the =
SPI which (on my board at least) can override the UART on the third SCC =
port. During boot up I get the standard output:
>=20
> >ttyS0 at 0x0280 is on SMC1 using BRG1
> >ttyS1 at 0x0380 is on SMC2 using BRG2
> >ttyS2 at 0x0200 is on SCC3 using BRG3
>=20
> Writing to ttyS0 and ttyS1 works fine (the result pop up in the=20
> receiving terminal) but when trying ttyS2 nothing happens. I've=20
> checked the Tx signal and it appears as if data is sent (the signal=20
> gets noisy when starting the write procedure). I may also add that=20
> restaring the write application causes the kernel to hang (for ttyS2=20
> only of course).
>=20
> I've read some posts saying that Linux don't init other uart ports=20
> than the console port and that is the potential problem here, but it =
is unclear if this >>
>statement is true or not. I can also add to the problem description =
that my SMC2 port works >fine for writing, but reading just hangs in the =
read() call. So, can anyone confirm any >
>status on the SMCx and SCCx UART drivers for 2.4?

>please try the two attached patches. the first one configures each SCC =
to one BRG. the second one, makes use always of dpram memory. we're =
working on a decent fix.
>Marcelo: if you find the first one ok, you may apply it, but don't =
apply the second
>
>--=20
>Aristeu
>

I would like to thank everyone who has given input to the discussion. =
Unfortunately the problems remain. I have not been able to try the =
patches since I reckon they are for Linux 2.6 specific while I'm using =
the 2.4 kernel (could be good to have in for future projects though). I =
did however triy remove the CTS, RTS and CD signal from the config as =
suggested which stopped the kernel from hanging. Might be a step in the =
right direction.

Best regards,
Bjorn Ostby
