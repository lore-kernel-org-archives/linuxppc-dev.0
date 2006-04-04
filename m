Return-Path: <Bjorn.Ostby@combitech.se>
Received: from ms-101.aerotechtelub.se (ms-101.aerotechtelub.se
	[192.176.33.163]) by ozlabs.org (Postfix) with ESMTP id 8DCB6679A6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Apr 2006 23:35:18 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Can't get serial SMC1 and SMC2 working together
Date: Tue, 4 Apr 2006 15:34:45 +0200
Message-ID: <004B1D7A5257174C9044A1B7BD0E60ED0177AA10@ratatosk.combitechsystems.com>
From: =?iso-8859-1?B?Qmr2cm4g1nN0Ynk=?= <Bjorn.Ostby@combitech.se>
To: "Kenneth Poole" <kpoole@mrv.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>
>>I'm using a TQM823L board, ELDK and Linux 2.4.25 (from denx). My=20
>>problem is that i can't use both SMC1 and SMC2 at the same time when I =

>>disable the console (console=3Dnull).
>
>Serial port interactions can result from incorrect mapping of the baud
>rate generators (BRGs) to the ports. I'm looking at source from 2.4.19,
>and this may have changed, but the serial driver init function =
(rs_8xx_init)
>calls m8xx_cpm_setbrg() with 'baud_idx' as the argument that selects =
which
>BRG. 'baud_idx' is set in serial_console_setup(). If you don't =
configure
>a console, 'baud_idx' may not be initialized.
>
>In any event, make sure that the BRGs are mapped to the ports as=20
>required for your specific board.
>
>Ken Poole
>MRV Communications, INC.
>

I had the same problem with a custom 823 based card a few weeks ago. =
Turned=20
out smc1 and smc2 indeed became wired to the same BRG when =
console=3D....=20
was passed as argument. My solution was a fast bypass hack in uart.c and =

no console=3D argument_

long __init console_8xx_init(long kmem_start, long kmem_end)
{
  /* register_console(&sercons); */
  sercons.setup(&sercons, NULL);
  return kmem_start;
}

A very static and ugly solution since time was of big essence, but that=20
could possibly help you.

Regards,
Bj=F6rn =D6stby


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org =
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
