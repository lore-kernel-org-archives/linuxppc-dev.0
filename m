Return-Path: <scottwood@freescale.com>
Message-ID: <49500029.90809@freescale.com>
Date: Mon, 22 Dec 2008 15:01:29 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: jeff angielski <jeff@theptrgroup.com>
Subject: Re: cpm2-scc-uart on mpc8265 not working
References: <1229977289.19292.16.camel@penguin>
In-Reply-To: <1229977289.19292.16.camel@penguin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

jeff angielski wrote:
> I am trying to get a custom mpc8265 board up and running with the latest
> git DENX 2.6 kernel and latest git u-boot.  However, the kernel is
> hanging somewhere in the call to cpm_uart_console_write().
> 
> Does anybody else have the cpm2 DTS code working on a 826x board?  It
> would appear from one of my earlier posts that nobody has used the DTS
> stuff with the 826x processors yet.

It's been used with 8272, 8248, etc. chips which are very similar.

> Here is the SCC1 snippet from my dts.  I will include the entire thing
> at the bottom just in case.
> 
> 		serial@11a00 {
> 				device_type = "serial";
> 				compatible = "fsl,mrdig-scc-uart",
> 				             "fsl,cpm2-scc-uart";
> 				reg = <0x11a00 0x20 0x8000 0x100>;
> 				interrupts = <40 8>;
> 				interrupt-parent = <&PIC>;
> 				fsl,cpm-brg = <1>;
> 				fsl,cpm-command = <0x0800000>;
> 			};

s/mrdig/mpc8265/, though nothing should be looking at that.  It's 
supposed to be the chip, not the board.  Likewise elsewhere.

> And here is the entire dts that I am trying to get up and running on
> this board.  The one thing I have been trying to work out is how the
> interrupts are supposed to be configured, especially the PCI mappings.
> However, at this point in the boot process, I don't think the interrupts
> are enabled so I don't think that is the problem.

Interrupts are enabled at that point.

> 	model = "MRDIG 1.1";
> 	compatible = "fsl,mrdig";

If this is not a Freescale board, don't put it in the Freescale namespace.

> 	soc@f0000000 {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		device_type = "soc";
> 		compatible = "fsl,mrdig", "fsl,pq2-soc";

You're putting the same compatible on your board as the soc.

> 
> 		// Temporary -- will go away once kernel uses ranges for
> get_immrbase().
> 		reg = <0xf0000000 0x53000>;

This isn't needed anymore.

> 
> 		cpm@119c0 {
> 			#address-cells = <1>;
> 			#size-cells = <1>;
> 			compatible = "fsl,mrdig-cpm", "fsl,cpm2";
> 			reg = <0x119c0 0x30>;
> 			ranges;
> 
> 			muram@0 {
> 				#address-cells = <1>;
> 				#size-cells = <1>;
> 				ranges = <0x0 0x0 0x10000>;
> 
> 				data@0 {
> 					compatible = "fsl,cpm-muram-data";
> 					reg = <0x0 0x2000 0x9800 0x800>;
> 				};
> 			};
> 
> 			brg@119f0 {
> 				compatible = "fsl,mrdig-brg",
> 				             "fsl,cpm2-brg",
> 				             "fsl,cpm-brg";
> 				reg = <0x119f0 0x10 0x115f0 0x10>;
> 			};
> 
> 			/* TODO: I believe the SCCs are setup correctly */
> 			/* SCC1 */
> 			serial@11a00 {
> 				device_type = "serial";
> 				compatible = "fsl,mrdig-scc-uart",
> 				             "fsl,cpm2-scc-uart";
> 				reg = <0x11a00 0x20 0x8000 0x100>;
> 				interrupts = <40 8>;
> 				interrupt-parent = <&PIC>;
> 				fsl,cpm-brg = <1>;
> 				fsl,cpm-command = <0x0800000>;
> 			};
> 
> 			/* SCC2 */
> 			serial@11a20 {
> 				device_type = "serial";
> 				compatible = "fsl,mrdig-scc-uart",
> 				             "fsl,cpm2-scc-uart";
> 				reg = <0x11a20 0x20 0x8000 0x100>;
> 				interrupts = <41 8>;
> 				interrupt-parent = <&PIC>;
> 				fsl,cpm-brg = <2>;
> 				fsl,cpm-command = <0x4a00000>;
> 			};
> 
> 			/* SCC3  - set this up now or later with SDLC? */
> 			serial@11a40 {
> 				device_type = "serial";
> 				compatible = "fsl,mrdig-scc-uart",
> 				             "fsl,cpm2-scc-uart";
> 				reg = <0x11a40 0x20 0x8000 0x100>;
> 				interrupts = <42 8>;
> 				interrupt-parent = <&PIC>;
> 				fsl,cpm-brg = <3>;
> 				fsl,cpm-command = <0x8c00000>;
> 			};

You're assigning the same DPRAM region to all 3 of these serial ports. 
SCC2 is 0x8100, and SCC3 is 0x8200.  This is likely your problem.

> 		/* TODO: What to do for us? */
> 		PIC: interrupt-controller@10c00 {

I don't see why anything would need to change here.

-Scott
