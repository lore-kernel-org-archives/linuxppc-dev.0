Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 0A8D21007D2
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jul 2010 05:16:12 +1000 (EST)
Received: by iwn36 with SMTP id 36so3043641iwn.15
	for <linuxppc-dev@ozlabs.org>; Fri, 02 Jul 2010 12:16:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100702124713.2e2d300c@schlenkerla.am.freescale.net>
References: <AANLkTinA2ghLxBU41aFAsLM1oXQ8HMASx1eQMDVvi56n@mail.gmail.com>
	<20100629185617.GA24285@schlenkerla.am.freescale.net>
	<AANLkTik48Ht-jeq_U1yh9c9WzFYE8yYpALiz_N8SzF4N@mail.gmail.com>
	<4C2B6DF5.7030403@freescale.com>
	<AANLkTinYnoqfZAJWlYg633VbVyjWXhvFk2p406eP3o0c@mail.gmail.com>
	<AANLkTilZm-TRkjgYBc0xj9iFYUJl7bb19Zvrcj2R-wJd@mail.gmail.com>
	<4C2CD395.90409@freescale.com>
	<AANLkTikuI49rzT6j9glIB-Vmp6kZSTVT5ri3Hb-JHgKO@mail.gmail.com>
	<4C2CF9A7.7010801@freescale.com>
	<AANLkTikELusybzh2uTh3KJ6QwelgSHW6HWWPLh-4Zc0b@mail.gmail.com>
	<20100702124713.2e2d300c@schlenkerla.am.freescale.net>
Date: Fri, 2 Jul 2010 12:16:11 -0700
Message-ID: <AANLkTimX7G59glJ9CQZpT-Zlb3EUsJ1Lil4_80BOi1Nk@mail.gmail.com>
Subject: Re: machine check in kernel for a mpc870 board
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

>> The chipselect? Isn't it just the child-bus-addr? BTW, do we have to
>> define the #address-cells to 2? 1 is not enough?
>
> The first cell of the child bus address is the chip select, the second
> cell is the offset into the chip select.

I see. So the #address-sells of 2 doesn't necessarily indicate the
address is 64 bits? Different processors can interpret it differently?
Where can I find such info? Is there any doc on this?

I have a question on the serial settings. Why does it locate at 0xa80?
According to MPC885RM.pdf, the SMC1's registers start from 0xa82. What
does the reg property specify here for SMC1, the first set of <0xa80
0x10> and the 2nd <0x3e80 0x40>?

                        console: serial@a80 {
                                device_type = "serial";
                                compatible = "fsl,mpc875-smc-uart",
                                             "fsl,cpm1-smc-uart";
                                reg = <0xa80 0x10 0x3e80 0x40>;
                                interrupts = <4>;
                                interrupt-parent = <&CPM_PIC>;
                                fsl,cpm-brg = <1>;
                                fsl,cpm-command = <0x0090>;
                                current-speed = <115200>;

Thanks a lot,
-Shawn.
