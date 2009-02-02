Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 0EB1ADDE06
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 01:59:57 +1100 (EST)
Message-ID: <49870A66.8030302@harris.com>
Date: Mon, 02 Feb 2009 09:59:50 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Lixin Yao <Lixin.Yao@HSTX.com>
Subject: Re: Can not get PATA to work for Compact Flash with 2.6.28 kernel
References: <03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B2@exchtxus2.HSTX.global.vpn>
In-Reply-To: <03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B2@exchtxus2.HSTX.global.vpn>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Lixin Yao wrote:
> 
> 
> I use a San Disk compact flash (CF) card on a board with MPC8248
> processor. The CF is connected to data and address bus of the processor
> and operates in TRUE IDE mode. The registers are memory mapped. I can
> read the file system on the CF in u-boot (1.3.4). U-boot can identify
> the CF and mount file system correctly.
> 
> The hardware is known good hardware.
> 
> I use 2.6.28 kernel and configured support for PATA for the CF.

The second register set does not start at register 0.  It starts
at register 6.  We are using 1 chip select from the processor,
and generate two chip selects to the CF that are 0x80 apart (on
a sequoia board).

So here is what I am using on the modified sequoia board.  Note
the 0x00000098 - you might think it should be 0x00000080 as per
the discussion above, but because the second register set starts
at 6, you have to build that into the address.  

pata@1,0 {
compatible = "harris,hydra_temp-pata", "ata-generic";
bank-width = <2>;
reg = <0x00000001 0x00000000 0x00000020 0x00000001 0x00000098 0x00000004>;
reg-shift = <2>;
pio-mode = <6>;
interrupt-parent = <&UIC0>;
interrupts = <0x1b 0x4>;
};

	Steve
