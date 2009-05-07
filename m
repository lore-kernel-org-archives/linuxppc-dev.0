Return-Path: <Christopher.Varlese@keymile.com>
Received: from mail.ch.keymile.com (mail.ch.keymile.com [193.17.201.103])
	by ozlabs.org (Postfix) with SMTP id 0EA87DDF80
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 04:01:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH] 83xx: add support for the kmeter1 board.
Date: Thu, 7 May 2009 19:49:51 +0200
Message-ID: <D839955AA28B9A42A61B9181506E27C40182F50E@SRVCHBER1212.ch.keymile.net>
In-Reply-To: <49F544DE.1010307@denx.de>
References: <49F00605.1080605@denx.de><6B76A454-649E-408C-A8DF-AAEEE6011929@kernel.crashing.org>
	<49F544DE.1010307@denx.de>
From: "Varlese, Christopher" <Christopher.Varlese@keymile.com>
To: <hs@denx.de>,"Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,

(FYI I working on the kmeter1)

kmeter1.c reuses the same QE_ENET10 RGMII errata workaround code from =
mpc836x_mds.c (MPC8360EMDS eval board).

In my view errata nodes in the dts is overkill.   Maybe the errata code =
can go into a reusable function somewhere in 83xx/ or in ucc_geth.c?

I also think the original errata code needs improving:
	- mask some SVR bits so activated for all matching CPU models, e.g. =
MPC8360 & MPC8360E.
	- The code in mpc836x_mds.c and kmeter1.c does not do exactly what =
Freescale errata says!

Here the errata document:
	http://www.freescale.com/files/32bit/doc/errata/MPC8360ECE.pdf

Because kmeter1 is using an MPC8360 CPU model the workaround doesn't =
actually trigger.  So to kill 2 birds with 1 stone we tested a Uboot =
patch (below) doing what QE_ENET10 says.   It seemed to work fine for =
us.
        /* RGMII timing Errata workaround for rev 2.1 silicon
         * (ref: MPC8360ECE rev.1 12/2007 QE_ENET10 UCC2 option 1)
         */
        void *reg =3D (void *)(CONFIG_SYS_IMMR + 0x14ac);
        clrsetbits_be32 (reg, 0x000000F0, 0x000000A0);

>From my point of view:
	- The workaround code in kmeter1.c could go for now.
	- An improved errata workaround for 836x boards would be nice (..who is =
motivated? :-))


Best regards
Christopher Varlese
R&D Software
________________________________________=A0
KEYMILE AG
Schwarzenburgstrasse 73
3097 Bern, Switzerland
www.keymile.com=A0

-----Original Message-----
From: linuxppc-dev-bounces+christopher.varlese=3Dkeymile.com@ozlabs.org =
[mailto:linuxppc-dev-bounces+christopher.varlese=3Dkeymile.com@ozlabs.org=
] On Behalf Of Heiko Schocher
Sent: Monday, April 27, 2009 7:39 AM
To: Kumar Gala
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] 83xx: add support for the kmeter1 board.

Hello Kumar,

Kumar Gala wrote:
[...]
>> diff --git a/arch/powerpc/platforms/83xx/kmeter1.c
>> b/arch/powerpc/platforms/83xx/kmeter1.c
>> new file mode 100644
>> index 0000000..99cf5c6
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/83xx/kmeter1.c
>> @@ -0,0 +1,170 @@
>> +/*
[...]
>> +    np =3D of_find_compatible_node(NULL, "network", "ucc_geth");
>> +    if (np !=3D NULL) {
>> +        uint svid;
>> +
>> +        /* handle mpc8360ea rev.2.1 erratum 2: RGMII Timing */
>> +        svid =3D mfspr(SPRN_SVR);
>> +        if (svid =3D=3D 0x80480021) {
>> +            void __iomem *immap;
>> +
>> +            immap =3D ioremap(get_immrbase() + 0x14a8, 8);
>=20
> we should add a proper device node to cover whatever register space =
this
> is.


What if we do something like the following:

1) add in the soc node an "errata" node and in this "errata" node
   we can add all CPU specific errata as an example the qe_enet10
   errata, which above code covers:

        soc8360@e0000000 {
	[...]
                errata {
                        device_type =3D "errata";
                        compatible =3D "fsl,mpc83xx_errata";
                        #address-cells =3D <1>;
                        #size-cells =3D <1>;

                        qe_enet10@14a8 {
                                device_type =3D "errata";
                                compatible =3D =
"fsl,mpc83xx_errata_qe_enet10";
                                reg =3D <0x14a8 0x08>;
                        };
                };
	[...]
	};

2) we add in arch/powerpc/sysdev/fsl_soc.c a

   static int __init mpc83xx_errata_init(void)

   function, which holds the code for the errata


If you agree with that, I can make a patch ...

Hmm.. Is it OK, if I first sent a v2 of the "83xx: add support for
the kmeter1 board." with the QE_ENET10 errata in kmeter1.c (as it is
also for the mpc836x_mds board), and then send a seperate patch, which
removes this errata from the two boards?

bye
Heiko
--=20
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
