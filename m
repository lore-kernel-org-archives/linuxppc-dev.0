Return-Path: <Clive.Jenkins@xerox.com>
Received: from wvmler2.mail.xerox.com (wvmler2.mail.xerox.com [13.8.138.217])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "wvmler2.mail.xerox.com",
	Issuer "wvmler2.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8E985679E1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Feb 2006 00:34:11 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: 82xx_io UART BRG's vs BUS CLK
Date: Mon, 20 Feb 2006 13:32:21 -0000
Message-ID: <35786B99AB3FDC45A8215724617919736D9240@gbrwgceumf01.eu.xerox.net>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Russell McGuire" <rmcguire@uwbt.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Russ
In fact the CD field of the hardware register needs to be
programmed with (divisor - 1), so in a sense you were right
about "adding a constant -1"! But it still needs the rounding
I suggested.
The Denx code combines the rounding and decrementing.
Clive

-----Original Message-----
From: Russell McGuire [mailto:rmcguire@uwbt.com]=20
Sent: 20 February 2006 12:22
To: Jenkins, Clive; linuxppc-embedded@ozlabs.org
Subject: RE: 82xx_io UART BRG's vs BUS CLK


Everyone,

Found a bug in the Linux 2.4.25 -> 2.4.26 and perhaps newer PPC kernels.

However, thanks for the U-boot tree, as it already had the fix. Thanks
to
those who had hinted at something like this already. I have tested this
out
and it works good for me on a MPC8280, with U-boot 1.1.2 and DENX Linux
2.4.25.

I don't have a patch file but the change is real simple if someone would
like to provide one.

/linux/arch/ppc/8260_io/commproc.c there is this bit of code.
--------------------------------------
/* This function is used by UARTS, or anything else that uses a 16x
 * oversampled clock.  */
 void cpm2_setbrg(uint brg, uint rate)
 {
         volatile uint   *bp;
=20
         /* This is good enough to get SMCs running.....
         */
         if (brg < 4) {
                 bp =3D (uint *)&cpm2_immr->im_brgc1;
         }
         else {
                 bp =3D (uint *)&cpm2_immr->im_brgc5;
                 brg -=3D 4;
         }
         bp +=3D brg;
         *bp =3D ((BRG_UART_CLK / rate) << 1) | CPM_BRG_EN;
 }
----------------------------------------
I recently put the correct frequency in U-boot to pass to linux, i.e.
66,666,666Mhz instead of 66,000,000Mhz. And this broke the BRG setups
and I
could no longer run 115200 Baudrate.

So after looking around, I found that the Uboot 1.1.2 and newer code
already
has a modified version of this code, and that it works correctly. Thanks
DENX!

See correct code below: note the cd--
-------------------------------------------------
void m8260_cpm_setbrg(uint brg, uint rate)
{
	volatile uint	*bp;
	uint cd =3D BRG_UART_CLK / rate;
	if ((BRG_UART_CLK % rate) < (rate / 2))
		cd--;
	if (brg < 4) {
		bp =3D (uint *)&immr->im_brgc1;
	}
	else {
		bp =3D (uint *)&immr->im_brgc5;
		brg -=3D 4;
	}
	bp +=3D brg;
	*bp =3D (cd << 1) | CPM_BRG_EN; =20
}
----------------------------------------------------

-----Original Message-----
From: Jenkins, Clive [mailto:Clive.Jenkins@xerox.com]=20
Sent: Tuesday, February 14, 2006 3:24 AM
To: Russell McGuire; linuxppc-embedded@ozlabs.org
Subject: RE: 82xx_io UART BRG's vs BUS CLK

> I did some math on the BRG calculations and with 66Mhz the BRG divisor
is
> 17.8 I am assuming 17 gets written, and with 66.666Mhz then its 18.02
so
> thus 18 probably gets written. Should perhaps a constant minus 1 be
added to
> the code?

> Using:
> U-boot 1.1.2
> DENX Linux 2.4.25

> Is anyone aware of similar issues, or are there bug fixes past the
2.4.25
> Kernel for this?

> -Russ

Hi Russ

I am not familiar with your hardware, nor have I checked the code that
calculated the Baud rate divisor.

I would advise against "adding a constant -1", in favour of rounding
to the nearest integer. From your figures:

  divisor =3D clock / (baudrate * 32)

To get a rounded result using real numbers:

  divisor =3D integer_part_of((clock / (baudrate * 32)) + 1/2)

Using integer arithmetic, you can code this in C as:

  divisor =3D ((clock / baudrate /16) + 1) >> 1;

I would check whether or not the code is doing this, or the equivalent,
and if not, change it. If the code is doing this, the divisor should be
18 in both cases.

Clive
