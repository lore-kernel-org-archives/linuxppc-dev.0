Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C12D0DE11F
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 20:06:52 +1100 (EST)
Message-ID: <497D7D2A.8090006@grandegger.com>
Date: Mon, 26 Jan 2009 10:06:50 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Pieter <phenning@vastech.co.za>
Subject: Re: Need help creating Device tree source for custom MPC8548 board
References: <497D7B37.9060909@vastech.co.za>
In-Reply-To: <497D7B37.9060909@vastech.co.za>
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

Pieter wrote:
> Hi all
> 
> I have inherited  a cusom MPC 8548 board and am currently in the
> processes of porting to U-Boot 2008 and Linux 2.6.27. The board worked
> using U-boot 1.2 and linux 2.6.24 not using FDT.
> 
> I have completed the U-boot source and am able to boot up to the point
> where control is handed to Linux kernel , where the board hangs. This
> lead me to believe that my device tree source is not accurate.
> 
>     ## Transferring control to Linux (at address 00000000) ...
>        Booting using OF flat tree...
> 
> I assembled a minimal "equus.dts"  by using the tqm8458.dts and
> sbc8548.dts as examples and the "Booting the Linux/ppc kernel without
> Open Firmware" document supplied with Lnux 2.6.27. I am uncertain about
> assigning interrupts to the variouse nodes.
> 
> I compiled the blob using dtc Version: 1.1.0:
> dtc -b 0 -V 17 -p 0x2000 -I dts -R 8 -O dtb -f
> arch/powerpc/boot/dts/equus.dts > SDH0/tftp/equus.dtb
> 
> can anyone please help? My device tree source is as follows:
> 
>     /dts-v1/;
>     / {
>         model = "EQUUS";
>         compatible = "Equus 2009";
>         #address-cells = <1>;
>         #size-cells = <1>;
>         aliases {
>             ethernet0 = &enet0;
>             ethernet1 = &enet1;
>             ethernet2 = &enet2;
>             serial0 = &serial1;
>             serial1 = &serial0;
>         };
> 
>         cpus {
>             #address-cells = <1>;
>             #size-cells = <0>;
>             PowerPC,8548@0 {
>                 device_type = "cpu";
>                 reg = <0>;
>                 d-cache-line-size = <0x20>;    // 32 bytes
>                 i-cache-line-size = <0x20>;    // 32 bytes
>                 d-cache-size = <0x8000>;    // L1, 32K
>                 i-cache-size = <0x8000>;    // L1, 32K
>                 timebase-frequency = <0>;    // From uboot
>                 bus-frequency = <0>;        // From uboot
>                 clock-frequency = <0>;        // From uboot
>                 next-level-cache = <&L2>;   
>             };
>         };
> 
>         memory {
>             device_type = "memory";
>             reg = <0x00000000 0x20000000>;    //512M at 0x0
>         };
> 
>         soc8548@e0000000 {
>             #address-cells = <1>;
>             #size-cells = <1>;
>             device_type = "soc";
>             ranges = <0x00000000 0xe0000000 0x00100000>;
>             reg = <0xe0000000 0x00001000>;    // CCSRBAR

Does this address match the one set by U-Boot? Also check all other
addresses for PCI, etc.

Wolfgang.
