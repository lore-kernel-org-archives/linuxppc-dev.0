Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 181C7DE201
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 01:54:31 +1000 (EST)
Message-ID: <49F08023.4060607@denx.de>
Date: Thu, 23 Apr 2009 16:50:11 +0200
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
>> diff --git a/arch/powerpc/boot/dts/kmeter1.dts
>> b/arch/powerpc/boot/dts/kmeter1.dts
>> new file mode 100644
>> index 0000000..4f343ca
>> --- /dev/null
>> +++ b/arch/powerpc/boot/dts/kmeter1.dts
>> @@ -0,0 +1,518 @@
>> +/*
>> + * Keymile KMETER1 Device Tree Source
>> + *

[...]

>> +
>> +
>> +/*
>> +/memreserve/    00000000 1000000;
>> +*/
> 
> is this needed for something?

No, I delete it.

>>
>> +
>> +/dts-v1/;
>> +
>> +/ {
>> +    model = "KMETER1";

[...]

>> +
>> +    cpus {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        PowerPC,8360@0 {
>> +            device_type = "cpu";
>> +            reg = <0x0>;
>> +            d-cache-line-size = <32>;    // 32 bytes
>> +            i-cache-line-size = <32>;    // 32 bytes
>> +            d-cache-size = <32768>;        // L1, 32K
>> +            i-cache-size = <32768>;        // L1, 32K
>> +            timebase-frequency = <66000000>;
>> +            bus-frequency = <264000000>;
>> +            clock-frequency = <528000000>;
> 
> is the board running at a fixed frequency that isn't possible to change?

No, u-boot updates this. I fix this.

>> +        };
>> +    };
>> +
>> +    memory {
>> +        device_type = "memory";
>> +        reg = <0x00000000 0x10000000>;
>> +    };
> 
> does u-boot not set this?  Also is the amount of memory fixed?

No, u-boot updates this. I fix this too. (and all other places)

>> +
>> +    soc8360@e0000000 {
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        device_type = "soc";
>> +        compatible = "simple-bus";

[...]

>> +        };
>> +    };
>> +
>> +    qe@e0100000 {
> 
> why isn't this under the SOC?

No reason for that, you are right, I fix this too.

>>
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        device_type = "qe";
>> +        compatible = "fsl,qe";
>> +        ranges = <0x0 0xe0100000 0x00100000>;
>> +        reg = <0xe0100000 0x480>;
>> +        brg-frequency = <0>;
>> +        bus-frequency = <396000000>;
>> +

[...]

>> +
>> +        qeic: interrupt-controller@80 {
>> +            interrupt-controller;
>> +            compatible = "fsl,qe-ic";
>> +            #address-cells = <0>;
>> +            #interrupt-cells = <1>;
>> +            reg = <0x80 0x80>;
>> +            big-endian;
> 
> seems unnecessary .. the qe is only big-endian.

OK.

>> +            interrupts = <32 8 33 8>;
>> +            interrupt-parent = <&ipic>;
>> +        };
>> +    };
> 
> 
>> diff --git a/arch/powerpc/platforms/83xx/kmeter1.c
>> b/arch/powerpc/platforms/83xx/kmeter1.c
>> new file mode 100644
>> index 0000000..99cf5c6
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/83xx/kmeter1.c
>> @@ -0,0 +1,170 @@
>> +/*
>> + * Copyright 2008 DENX Software Engineering GmbH
>> + * Author: Heiko Schocher <hs@denx.de>

[...]

>> +
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

Hmm... in the MPC8360ERM.pdf this is a "reserved" register ... This
"register" is mentioned in the MPC8360ECE.pdf for this CPU in
Table 4. RGMII Programmable I/O Delay Work Arounds in the QE_ENET10
section.

So this is a MPC8360E, MPC8358E specific errata, so shouldn;t
we add this fix in the drivers/net/ucc_geth.c driver so all
boards have this fix?

thanks for commenting
bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
