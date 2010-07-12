Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 8587DB6F10
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 04:23:57 +1000 (EST)
Received: by iwn36 with SMTP id 36so4489031iwn.15
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 11:23:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinRCzjFdozxBqCS91deuzVRvenFYq21XVpQnzBh@mail.gmail.com>
References: <AANLkTikzt4mVGdYzRF2pgficbeinNydkr9E0YQjgJT1I@mail.gmail.com>
	<20100706152110.4f25e96b@schlenkerla.am.freescale.net>
	<AANLkTikNgYy9aAUAe9wTsNKDg3cNokSTVJ_6aA6n3SI9@mail.gmail.com>
	<20100706181811.4542df5a@schlenkerla.am.freescale.net>
	<AANLkTimUxcsTMXNPOFfJxybp8u7Wv7Mt_nhW1EE01RqG@mail.gmail.com>
	<AANLkTinNSzP-WvxC2kqZop2kvd1kSUMDuwI01GOBXApE@mail.gmail.com>
	<20100709105946.68832b3e@schlenkerla.am.freescale.net>
	<AANLkTinRCzjFdozxBqCS91deuzVRvenFYq21XVpQnzBh@mail.gmail.com>
Date: Mon, 12 Jul 2010 11:23:55 -0700
Message-ID: <AANLkTilIzkPgZuzm4diUmTNVtme811__2BE8p33_2aSv@mail.gmail.com>
Subject: Re: kernel boot stuck at udbg_putc_cpm()
From: Shawn Jin <shawnxjin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For some reason. This email was rejected. Resending...

On Sun, Jul 11, 2010 at 11:26 PM, Shawn Jin <shawnxjin@gmail.com> wrote:
> You're probably getting to the point where udbg is disabled because the
> real serial driver is trying to take over -- and something's going
> wrong with the real serial port driver. =A0Check to make sure the brg
> config is correct (both the input clock and the baud rate you're trying
> to switch to). =A0Commenting out the call to cpm_set_brg can be
> a quick way of determining if that's the problem.

It seems that the last CP command RESTART_TX never completes in the
cpm_uart_console_setup(). I commented out the writes to brgc1 in
cpm_setbrg() in cpm1.c so that the brgc1 value stays the same as
previously set.

The registers related to SMC1 are dumped below before the last
RESTART_TX command. The CPCR was 0x0090. But after issuing the
RESTART_TX command the CPCR kept at 0x0691. Is there any other obvious
reason for CPM not completing the command? It got to be something
related to the settings.

BDI>rd cpcr
cpcr =A0 =A0 =A0 =A0 =A0 : 0x0090 =A0 =A0 =A0144
BDI>rd rccr
rccr =A0 =A0 =A0 =A0 =A0 : 0x0001 =A0 =A0 =A01
BDI>rd rmds
rmds =A0 =A0 =A0 =A0 =A0 : 0x00 =A0 =A0 =A0 =A00
BDI>rd rctr1
rctr1 =A0 =A0 =A0 =A0 =A0: 0x0000 =A0 =A0 =A00
BDI>rd rctr2
rctr2 =A0 =A0 =A0 =A0 =A0: 0x0000 =A0 =A0 =A00
BDI>rd rctr3
rctr3 =A0 =A0 =A0 =A0 =A0: 0x802e =A0 =A0 =A0-32722
BDI>rd rctr4
rctr4 =A0 =A0 =A0 =A0 =A0: 0x802c =A0 =A0 =A0-32724
BDI>rd rter
rter =A0 =A0 =A0 =A0 =A0 : 0x0000 =A0 =A0 =A00
BDI>rd rtmr
rtmr =A0 =A0 =A0 =A0 =A0 : 0x0000 =A0 =A0 =A00
BDI>rd brgc1
brgc1 =A0 =A0 =A0 =A0 =A0: 0x00010618 =A067096
BDI>rd smcmr1
smcmr1 =A0 =A0 =A0 =A0 : 0x4823 =A0 =A0 =A018467
BDI>rd smce1
smce1 =A0 =A0 =A0 =A0 =A0: 0x00 =A0 =A0 =A0 =A00
BDI>rd smcm1
smcm1 =A0 =A0 =A0 =A0 =A0: 0x00 =A0 =A0 =A0 =A00

Thanks,
-Shawn.
