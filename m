Return-Path: <mederle_nicolas@yahoo.fr>
Received: from smtp007.mail.ukl.yahoo.com (smtp007.mail.ukl.yahoo.com
	[217.12.11.96]) by ozlabs.org (Postfix) with SMTP id 08C5BDDF29
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 16:52:11 +1000 (EST)
Message-ID: <46383418.9010804@yahoo.fr>
Date: Wed, 02 May 2007 08:47:52 +0200
From: Nicolas Mederle <mederle_nicolas@yahoo.fr>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org,  linuxppc-dev@ozlabs.org
Subject: Device tree for a custom board with PPC750
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I must port Linux on a proprietary board (whitout Open Firmware).
This board uses the PPC750Fx processor with proprietary components.

1. I have write the followind device tree. Can you say me if it's correct?

2. The epicea bridge is a custom component (ASIC), and I will know if 
the compatible field is correct.
   Must I write a file for each component? Can I use a generic file for 
pic or uart?

3. Must I indicate the clock frequency for each component? Or can I 
indicate only the epicea clock frequency?


Thanks


/*
* Device Tree Souce for SMD88ND Thales board
*
* Choose CONFIG_SMD88ND to build a kernel for SMD88ND, or use
* the default configuration smd88nd_defconfig.
*
* Based on sandpoint.dts
*
* 2007 (c) N. MEDERLE <mederle.nicolas@csie.fr>
*
*
* To build:
*   dtc -I dts -O asm -o smd88ng.S -V 16 smd88ng.dts
*   dtc -I dts -O dtb -o smd88ng.dtb -V 16 smd88ng.dts
*/

/ {
    linux,phandle = <1000>;
    model = "smd88ng";
    compatible = "smd88ng";
    #address-cells = <1>;
    #size-cells = <1>;
    /* ===== Processor ===== */
    cpus {
        linux,phandle = <2000>;
        #cpus = <1>;
        #address-cells = <1>;
        #size-cells = <0>;
        /* ===== CPU used ===== */
        PowerPC,603e@0 {				/* Really PPC750FX */
            linux,phandle = <2100>;
            device_type = "cpu";
            reg = <0>;
            clock-frequency = <23C34600>;	/* 600MHz */
            timebase-frequency = <1312D00>;    	/* 20MHz (bus-freq/4) */
            bus-frequency = <4C4B400>;		/* 80MHz */
            i-cache-line-size = <20>;		/* 32 bytes */
            d-cache-line-size = <20>;		/* 32 bytes */
            i-cache-size = <8000>;		/* L1, 32K */
            d-cache-size = <8000>;		/* L1, 32K */
        };
    };
    /* ===== RAM ===== */
    memory {
        linux,phandle = <3000>;
        device_type = "memory";
        reg = <00000000 10000000>;		/* 256Mb */
    };
    /* ===== Bridge Epicea (custom component) ===== */
    epicea@20000000 {
        linux,phandle = <4000>;
        device_type = "epicea-bridge";		/* ??? */
        #address-cells = <1>;
        #size-cells = <1>;
        #interrupt-cells = <2>;
        ranges = <20000000 20000000 02000000>;
        reg = <20000000 02000000>;
        /* ===== Interrupt Controller ===== */
        pic@20006000 {
            linux,phandle = <6000>;
            device_type = "pic";
            compatible = "epicea-pic";		/* ??? */
            #address-cells = <0>;
            #interrupt-cells = <2>;
            reg = <20006000 2000>;
            clock-frequency = <4C4B400>;		/* 0 or 80MHz ??? */
            interrupt-controller;
            built-in;
            big-endian;
        };
        /* ===== DMA #0 ===== */
        dma@20008000 {
            linux,phandle = <8000>;
            device_type = "dma";
            compatible = "epicea-dma";		/* ??? */
            #address-cells = <1>;
            #size-cells = <1>;
            #interrupt-cells = <1>;
            reg = <20008000 2c>;
            clock-frequency = <4C4B400>;		/* or 0 ??? */
            interrupts = <2a 2 2b 2>;		/* level 2a & 2b, Low */
            interrupt-parent = <6000>;
        };
        /* ===== DMA #1 ===== */
        dma@20009000 {
            linux,phandle = <9000>;
            device_type = "dma";
            compatible = "epicea-dma";		/* ??? */
            #address-cells = <1>;
            #size-cells = <1>;
            #interrupt-cells = <1>;
            reg = <20009000 2c>;
            clock-frequency = <4C4B400>;		/* or 0 ??? */
            interrupts = <34 2 35 2>;		/* level 34 & 35, Low */
            interrupt-parent = <6000>;
        };
        /* ===== USART #0 ===== */
        serial@2001a000 {
            linux,phandle = <1A000>;
            device_type = "serial";
            compatible = "epicea-serial";	/* ??? */
            reg = <2001a000 1000>;
            clock-frequency = <4C4B400>;		/* or 0 ?? */
            current-speed = <2580>;		/* 9600 bauds */
            interrupts = <38 2 39 2 3a 2 3b 2>;	/* level 38 to 3b,Low */
            interrupt-parent = <6000>;
        };
        /* ===== USART #1 ===== */
        serial@2001b000 {
            linux,phandle = <1B000>;
            device_type = "serial";
            compatible = "epicea-serial";	/* ??? */
            reg = <2001b000 1000>;
            clock-frequency = <4C4B400>;		/* or 0 ?? */
            current-speed = <2580>;		/* 9600 bauds */
            interrupts = <18 2 19 2 1a 2 1b 2>;	/* level 18 to 1b,Low */
            interrupt-parent = <6000>;
        };
        /* ===== USART #2 ===== */
        serial@2001c000 {
            linux,phandle = <1C000>;
            device_type = "serial";
            compatible = "epicea-serial";	/* ??? */
            reg = <2001c000 1000>;
            clock-frequency = <4C4B400>;		/* or 0 ?? */
            current-speed = <2580>;		/* 9600 bauds */
            interrupts = <10 2 11 2 12 2 13 2>;	/* Level 10 to 13,Low */
            interrupt-parent = <6000>;
        };
        /* ===== I2C bus ===== */
        i2c@20015000 {
            linux,phandle = <15000>;
            device_type = "i2c";
            compatible = "epicea-i2c";		/* ??? */
            reg = <20015000 1000>;
            interrupts = <16 2>;			/* level 16, Low */
            interrupt-parent = <6000>;
        };
        /* ===== DMA for USART ===== */
        udma@2001D000 {
            linux,phandle = <1D000>;
            device_type = "dma";
            compatible = "epicea-dma";		/* ??? */
            #address-cells = <1>;
            #size-cells = <1>;
            #interrupt-cells = <1>;
            reg = <2001D000 20>;
            clock-frequency = <0>;
            interrupts = <36 2 37 2>;		/* Level 36 & 37,Low */
            interrupt-parent = <6000>;
        };
    };
};

-- 
Cordialement,

Nicolas MEDERLE.
