Return-Path: <rmcguire@uwbt.com>
Received: from mail19d.g19.rapidsite.net (mail19d.dulles19-verio.com
	[204.202.242.120]) by ozlabs.org (Postfix) with SMTP id BE111679F2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Feb 2006 23:22:29 +1100 (EST)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: "'Jenkins, Clive'" <Clive.Jenkins@xerox.com>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: 82xx_io UART BRG's vs BUS CLK
Date: Mon, 20 Feb 2006 04:22:17 -0800
Message-ID: <000601c63618$4bd19820$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <35786B99AB3FDC45A8215724617919736D9236@gbrwgceumf01.eu.xerox.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Everyone,

Found a bug in the Linux 2.4.25 -> 2.4.26 and perhaps newer PPC kernels.

However, thanks for the U-boot tree, as it already had the fix. Thanks to
those who had hinted at something like this already. I have tested this out
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
 
         /* This is good enough to get SMCs running.....
         */
         if (brg < 4) {
                 bp = (uint *)&cpm2_immr->im_brgc1;
         }
         else {
                 bp = (uint *)&cpm2_immr->im_brgc5;
                 brg -= 4;
         }
         bp += brg;
         *bp = ((BRG_UART_CLK / rate) << 1) | CPM_BRG_EN;
 }
----------------------------------------
I recently put the correct frequency in U-boot to pass to linux, i.e.
66,666,666Mhz instead of 66,000,000Mhz. And this broke the BRG setups and I
could no longer run 115200 Baudrate.

So after looking around, I found that the Uboot 1.1.2 and newer code already
has a modified version of this code, and that it works correctly. Thanks
DENX!

See correct code below: note the cd--
-------------------------------------------------
void m8260_cpm_setbrg(uint brg, uint rate)
{
	volatile uint	*bp;
	uint cd = BRG_UART_CLK / rate;
	if ((BRG_UART_CLK % rate) < (rate / 2))
		cd--;
	if (brg < 4) {
		bp = (uint *)&immr->im_brgc1;
	}
	else {
		bp = (uint *)&immr->im_brgc5;
		brg -= 4;
	}
	bp += brg;
	*bp = (cd << 1) | CPM_BRG_EN;  
}
----------------------------------------------------

-----Original Message-----
From: Jenkins, Clive [mailto:Clive.Jenkins@xerox.com] 
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

  divisor = clock / (baudrate * 32)

To get a rounded result using real numbers:

  divisor = integer_part_of((clock / (baudrate * 32)) + 1/2)

Using integer arithmetic, you can code this in C as:

  divisor = ((clock / baudrate /16) + 1) >> 1;

I would check whether or not the code is doing this, or the equivalent,
and if not, change it. If the code is doing this, the divisor should be
18 in both cases.

Clive
