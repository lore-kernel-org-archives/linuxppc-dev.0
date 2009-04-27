Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 35F6BDDE22
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 16:53:51 +1000 (EST)
Message-ID: <49F544DE.1010307@denx.de>
Date: Mon, 27 Apr 2009 07:38:38 +0200
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] 83xx: add support for the kmeter1 board.
References: <49F00605.1080605@denx.de>
	<6B76A454-649E-408C-A8DF-AAEEE6011929@kernel.crashing.org>
In-Reply-To: <6B76A454-649E-408C-A8DF-AAEEE6011929@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

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
>> +    np = of_find_compatible_node(NULL, "network", "ucc_geth");
>> +    if (np != NULL) {
>> +        uint svid;
>> +
>> +        /* handle mpc8360ea rev.2.1 erratum 2: RGMII Timing */
>> +        svid = mfspr(SPRN_SVR);
>> +        if (svid == 0x80480021) {
>> +            void __iomem *immap;
>> +
>> +            immap = ioremap(get_immrbase() + 0x14a8, 8);
> 
> we should add a proper device node to cover whatever register space this
> is.


What if we do something like the following:

1) add in the soc node an "errata" node and in this "errata" node
   we can add all CPU specific errata as an example the qe_enet10
   errata, which above code covers:

        soc8360@e0000000 {
	[...]
                errata {
                        device_type = "errata";
                        compatible = "fsl,mpc83xx_errata";
                        #address-cells = <1>;
                        #size-cells = <1>;

                        qe_enet10@14a8 {
                                device_type = "errata";
                                compatible = "fsl,mpc83xx_errata_qe_enet10";
                                reg = <0x14a8 0x08>;
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
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
