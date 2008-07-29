Return-Path: <BenGardiner@nanometrics.ca>
Received: from nmxmail.nanometrics.ca (mail.nanometrics.ca [206.191.47.130])
	by ozlabs.org (Postfix) with ESMTP id 70E1BDDE22
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jul 2008 01:38:10 +1000 (EST)
Message-ID: <488F385B.9030504@nanometrics.ca>
Date: Tue, 29 Jul 2008 11:33:47 -0400
From: Ben Gardiner <BenGardiner@nanometrics.ca>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: No output from SMC1 console with the 2.6.26 kernel (8xx based board)
References: <8496f91a0807281243y2193dad5hc758444fe0a10258@mail.gmail.com>	<488E2510.7070209@freescale.com>
	<8496f91a0807282310r5e70fe01v85b2ff2da7a80416@mail.gmail.com>
In-Reply-To: <8496f91a0807282310r5e70fe01v85b2ff2da7a80416@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In 'Re: No output from SMC1 console with the 2.6.26 kernel (PQ2FADS 
based    board)' Matvejchikov Ilya wrote:
> No, it's not working for me :(
>
> My pins is configured by u-boot so I disable init_ioports() function
> call. Moreover the udbg0 console forks fine... I have no output at all
> after "udbg_putc = NULL" line in the cpm_uart driver. As I see it the
> cpm_uart driver doesn't run properly after udbg console has turned
> off.....
>   
I think I'm having a similar problem with an 8xx based board.

I am calling cpm_reset() and cpm1_set_pin().
<snip nmx_setup.c>
...
static struct cpm_pin nmx_pins[] = {
    /* SMC1 */
    {CPM_PORTB, 24, CPM_PIN_INPUT}, /* RX */
    {CPM_PORTB, 25, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* TX */
};

static void __init init_ioports(void)
{
    int i;

    for (i = 0; i < ARRAY_SIZE(nmx_pins); i++) {
        struct cpm_pin *pin = &nmx_pins[i];
        cpm1_set_pin(pin->port, pin->pin, pin->flags);
    }

    cpm1_clk_setup(CPM_CLK_SMC1, CPM_BRG1, CPM_CLK_RTX);

}

static void __init nmx_setup_arch(void)
{
    cpm_reset();
    init_ioports();
...
<snip>

I have a cpm dts entry copied from the mpc866ads.dts. I've also added 
the compatible = "simple-bus".
<snip nmx-taurus.dts>
...
        cpm@9c0 {
            #address-cells = <1>;
            #size-cells = <1>;
            compatible = "fsl,mpc866-cpm", "fsl,cpm1", "simple-bus";
            ranges;
            reg = <0x9c0 0x40>;
            brg-frequency = <0>;
            interrupts = <0 2>;    // cpm error interrupt
            interrupt-parent = <&CPM_PIC>;

            muram@2000 {
                #address-cells = <1>;
                #size-cells = <1>;
                ranges = <0x0 0x2000 0x2000>;

                data@0 {
                    compatible = "fsl,cpm-muram-data";
                    reg = <0x0 0x1c00>;
                };
            };

            brg@9f0 {
                compatible = "fsl,mpc866-brg",
                         "fsl,cpm1-brg",
                         "fsl,cpm-brg";
                reg = <0x9f0 0x10>;
                clock-frequency = <0>;
            };

            CPM_PIC: pic@930 {
                interrupt-controller;
                #address-cells = <0>;
                #interrupt-cells = <1>;
                interrupts = <5 2 0 2>;
                interrupt-parent = <&PIC>;
                reg = <0x930 0x20>;
                compatible = "fsl,mpc866-cpm-pic",
                             "fsl,cpm1-pic";
            };


            serial@a80 {
                device_type = "serial";
                compatible = "fsl,mpc866-smc-uart",
                             "fsl,cpm1-smc-uart";
                reg = <0xa80 0x10 0x3e80 0x40>;
                interrupts = <4>;
                interrupt-parent = <&CPM_PIC>;
                fsl,cpm-brg = <1>;
                fsl,cpm-command = <0x90>;
            };

            serial@a90 {
                device_type = "serial";
                compatible = "fsl,mpc866-smc-uart",
                             "fsl,cpm1-smc-uart";
                reg = <0xa90 0x10 0x3f80 0x40>;
                interrupts = <3>;
                interrupt-parent = <&CPM_PIC>;
                fsl,cpm-brg = <2>;
                fsl,cpm-command = <0xd0>;
            };

        };
    };
...
<snip>

I have CPM console SMC1 enabled
<snip .config>
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_CPM=y
CONFIG_SERIAL_CPM_CONSOLE=y
CONFIG_SERIAL_CPM_SMC1=y
 <snip>

And my serial console output is stopping around the same point as 
Matvejchikov. I have baud 9600, so I'm guessing that it's cutoff because 
of this (please excuse me if this is wrong). NB: the console=ttyS0 
bootarg is there to get a working console when I  boot back to 2.4.
<snip console>
Memory <- <0x0 0x8000000> (128MB)
ENET0: local-mac-address <- 00:11:40:02:00:18
CPU clock-frequency <- 0x3f940aa (67MHz)
CPU timebase-frequency <- 0x1fce17 (2MHz)
CPU bus-frequency <- 0x1fce170 (33MHz)

zImage starting: loaded at 0x00400000 (sp: 0x07f77908)
Allocating 0x127c50 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040c000:0x00538390)...done 0x11a680 bytes

Linux/PowerPC load: root=/dev/mtdblock2 rw panic=10 console=ttyCPM0 
console=ttyS0
Finalizing device tree... flat tree at 0x545300
Xid mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
Using NMX Taurus machine description
Linux version 2.6.26-dirty (BenGardiner@penguin.nanometrics.ca) (gcc 
version 4.0.1) #1 Tue Jul 2
9 10:43:11 EDT 2008
console [udbg0] enabled
Entering add_active_range(0, 0, 32768) 0 entries of 256 used
setup_arch: bootmem
arch: exit
Top of RAM: 0x8000000, Total RAM: 0x8000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA             0 ->    32768
  Normal      32768 ->    32768
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    32768
On node 0 totalpages: 32768
  DMA zone: 256 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 32512 pages, LIFO batch:7
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
Kernel command line: root=/dev/mtdblock2 rw panic=10 console=ttyCPM0 
console=ttyS0
PID hash table entries: 512 (order: 9, 2048 bytes)
Decrementer Frequency = 0x3f940a
time_init: decrementer frequency = 4.166666 MHz
time_init: processor frequency   = 66.666666 MHz
clocksource: timebase mult[3c0000a1] shift[22] registered
clockevent: decremente
<snip>

I've had the same behaviour with gcc 4.0.1 and gcc 4.3.0. Also with 
CONFIG_SERIAL_CPM_SCC1=y defined and not. Also with the smc2 dts entry 
removed and not. Also with ',9600' on the console=CPM0 bootarg and not.

Please excuse me for jumping in late. I hope this can help track down 
the problem.

,Ben
