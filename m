Return-Path: <jarno.manninen@tut.fi>
Received: from pne-smtpout3-sn2.hy.skanova.net
	(pne-smtpout3-sn2.hy.skanova.net [81.228.8.111])
	by ozlabs.org (Postfix) with ESMTP id BB1EA67B52
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Nov 2006 06:59:18 +1100 (EST)
From: Jarno Manninen <jarno.manninen@tut.fi>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH/RFC] ata: Add support for the MPC52xx ATA controller using
	libata
Date: Fri, 17 Nov 2006 20:49:48 +0200
References: <11637151391017-git-send-email-tnt@246tNt.com>
In-Reply-To: <11637151391017-git-send-email-tnt@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611172049.49260.jarno.manninen@tut.fi>
Cc: Linux IDE <linux-ide@vger.kernel.org>, Sven Luther <sl@bplan-gmbh.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 17 November 2006 00:12, Sylvain Munaut wrote:

> * The manual states we should check for the TIP bit before all
> PIO transaction. That's not really supported by libata and requires
> reimplementing almost all the hooks. But after talking to Freescale,
> it turnsout it's not really necessary. So this driver doesn't implement
> that check. I noticed no problem so far ...

I've had some bad experiences with 2.4 line kernel when using BAPI 2.2 on Rev. 
A 5200 while imposing heavy I/O load. Problems manifested as hanging XLB-bus 
and so on. Funny thing is that combinations like Rev.A + BAPI 2.1 and Rev.B + 
BAPI 2.[12] seem to be immune while doing similar stress tests.

Problems went away after wrapping PIO access like this:

1. Stop XLB-pipelining
2. Wait for TIP bit to go down.
3. Do the access
4. Restore XLB-pipelining.

Just polling for the TIP bit is not enough due to errata on Rev. A if the 
pipelining is enabled.

Just in case if someone else is having mysterious hangs on Rev.A:s with newer 
microcode. :)

- Jarno
