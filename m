Return-Path: <shawnxjin@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id 18446B6F04
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Jul 2010 17:50:09 +1000 (EST)
Received: by iwn36 with SMTP id 36so1399306iwn.15
	for <linuxppc-dev@ozlabs.org>; Thu, 01 Jul 2010 00:50:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinYnoqfZAJWlYg633VbVyjWXhvFk2p406eP3o0c@mail.gmail.com>
References: <AANLkTinA2ghLxBU41aFAsLM1oXQ8HMASx1eQMDVvi56n@mail.gmail.com>
	<20100629185617.GA24285@schlenkerla.am.freescale.net>
	<AANLkTik48Ht-jeq_U1yh9c9WzFYE8yYpALiz_N8SzF4N@mail.gmail.com>
	<4C2B6DF5.7030403@freescale.com>
	<AANLkTinYnoqfZAJWlYg633VbVyjWXhvFk2p406eP3o0c@mail.gmail.com>
Date: Thu, 1 Jul 2010 00:50:08 -0700
Message-ID: <AANLkTilZm-TRkjgYBc0xj9iFYUJl7bb19Zvrcj2R-wJd@mail.gmail.com>
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

Hi Scott,

> How do I find the address, reg, and range for nodes like localbus,
> soc, eth0, cpm, serial etc.? Do the addresses of localbus and soc
> relate to IMMR? So my localbus and soc should be as follows?
>
> =A0 =A0 =A0 =A0localbus@fa200100 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D "fsl,mpc885-localbus", "fsl=
,pq1-localbus",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "simple-bus";
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#address-cells =3D <2>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D <1>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0xfa200100 0x40>;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ranges =3D <
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 0 0xfe000000 0x01000000 =
=A0 =A0// I'm not sure about this?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0>;
> =A0 =A0 =A0 =A0};

I managed to proceed a little bit further.
    Memory <- <0x0 0x8000000> (128MB)
    ENET0: local-mac-address <- 00:09:9b:01:58:64
    CPU clock-frequency <- 0x7270e00 (120MHz)
    CPU timebase-frequency <- 0x393870 (4MHz)
    CPU bus-frequency <- 0x3938700 (60MHz)

    zImage starting: loaded at 0x00400000 (sp: 0x07d1ccd0)
    Allocating 0x186bdd bytes for kernel ...
    gunzipping (0x00000000 <- 0x0040c000:0x00591c30)...done 0x173b18 bytes

    Linux/PowerPC load: root=3D/dev/ram
    Finalizing device tree... flat tree at 0x59e300

The gdb showed deadbeef.
    (gdb) target remote ppcbdi:2001
    Remote debugging using ppcbdi:2001
    0xdeadbeef in ?? ()
    (gdb)

The kernel doesn't seem to start. What could go wrong here?

Thanks a lot,
-Shawn.
