Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id DA856B7092
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Jul 2010 06:17:21 +1000 (EST)
Received: by iwn36 with SMTP id 36so1984027iwn.15
	for <linuxppc-dev@ozlabs.org>; Thu, 01 Jul 2010 13:17:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C2CD395.90409@freescale.com>
References: <AANLkTinA2ghLxBU41aFAsLM1oXQ8HMASx1eQMDVvi56n@mail.gmail.com>
	<20100629185617.GA24285@schlenkerla.am.freescale.net>
	<AANLkTik48Ht-jeq_U1yh9c9WzFYE8yYpALiz_N8SzF4N@mail.gmail.com>
	<4C2B6DF5.7030403@freescale.com>
	<AANLkTinYnoqfZAJWlYg633VbVyjWXhvFk2p406eP3o0c@mail.gmail.com>
	<AANLkTilZm-TRkjgYBc0xj9iFYUJl7bb19Zvrcj2R-wJd@mail.gmail.com>
	<4C2CD395.90409@freescale.com>
Date: Thu, 1 Jul 2010 13:17:19 -0700
Message-ID: <AANLkTikuI49rzT6j9glIB-Vmp6kZSTVT5ri3Hb-JHgKO@mail.gmail.com>
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

>>> How do I find the address, reg, and range for nodes like localbus,
>>> soc, eth0, cpm, serial etc.?
>
> If your CCSRBAR is 0xfa200000, then pretty much anywhere you see 0xff0xxx=
xx
> change it to 0xfa2xxxxx.

I'm not sure about the range settings of 0xfe000000. How do you get this?

       localbus@fa200100 {
               compatible =3D "fsl,mpc885-localbus", "fsl,pq1-localbus",
                            "simple-bus";
               #address-cells =3D <2>;
               #size-cells =3D <1>;
               reg =3D <0xfa200100 0x40>;

               ranges =3D <
                       0 0 0xfe000000 0x01000000    // I'm not sure about t=
his?
               >;
       };


>> =A0 =A0 Linux/PowerPC load: root=3D/dev/ram
>> =A0 =A0 Finalizing device tree... flat tree at 0x59e300
>>
>> The gdb showed deadbeef.
>> =A0 =A0 (gdb) target remote ppcbdi:2001
>> =A0 =A0 Remote debugging using ppcbdi:2001
>> =A0 =A0 0xdeadbeef in ?? ()
>> =A0 =A0 (gdb)
>>
>> The kernel doesn't seem to start. What could go wrong here?
>
> Pretty much anything. :-)

I realized that. :-P The kernel booting was able to stop at
start_kernel(). I'm going to trace further.

> Make sure that you've got Linux platform code enabled that matches the
> top-level compatible of your device tree. =A0Try enabling PPC_EARLY_DEBUG=
_CPM,
> making sure to update PPC_EARLY_DEBUG_CPM_ADDR to 0xfa202008.

I enabled this early debug feature but don't know this address change.
I'll try it later.

Thanks a lot, Scott.

-Shawn.
