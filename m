Return-Path: <bgat@billgatliff.com>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181]) by ozlabs.org (Postfix) with ESMTP id 2CCADB6F06
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Dec 2009 07:38:43 +1100 (EST)
Received: by ywh11 with SMTP id 11so8080979ywh.9
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Dec 2009 12:38:41 -0800 (PST)
Message-ID: <4B327FEC.9030801@billgatliff.com>
Date: Wed, 23 Dec 2009 14:39:08 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Does gpio_to_irq() work for MPC52xx gpios?
References: <4B312EDA.7030606@billgatliff.com>
	<87fx72wwpd.fsf@macbook.be.48ers.dk>
	<4B3249AA.50405@billgatliff.com>
In-Reply-To: <4B3249AA.50405@billgatliff.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bill Gatliff wrote:
> Peter Korsgaard wrote:
>   
>> No (not yet). In Ben's latest pull request there's a patch from me to
>> add basic infrastructure for gpio_to_irq(). I've recently added irq
>> support to the mpc8xxx driver, but so far nothing has been written for
>> 52xx.
>>
>> http://patchwork.ozlabs.org/patch/41550/
>>   
>>     
>
> Ok.  I'm taking a look at that code now, planning to adapt it for the
> MPC52xx unless someone raises any objections.
>   

Ok, working on this now.  I'm pretty far along, but I'm stopped at what
I think is a device tree source file problem.

I have an external device that generates two interrupt outputs.  One of
them is connected to IRQ2, the other to GPIO_WKUP_7.  I'm describing the
device like this:

    ...
    soc5200@f0000000 {
        #address-cells = <1>;
        #size-cells = <1>;
        compatible = "fsl,mpc5200b-immr","simple-bus";
        ranges = <0 0xf0000000 0x0000c000>;
        reg = <0xf0000000 0x00000100>;
        bus-frequency = <0>;        // from bootloader
        system-frequency = <0>;        // from bootloader
    ...
        mpc5200_pic: interrupt-controller@500 {
            // 5200 interrupts are encoded into two levels;
            interrupt-controller;
            gpio-controller;
            #interrupt-cells = <3>;
            #address-cells = <0>;
            #size-cells = <0>;
            compatible = "fsl,mpc5200b-pic","fsl,mpc5200-pic";
            reg = <0x500 0x80>;
            interrupts = < 0 0 3  1 1 3  2 2 2  3 3 2 >;
        };
        gpio_wkup: gpio@c00 {
            compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
            #gpio-cells = <2>;
            #interrupt-cells = <2>;
            #address-cells = <0>;
            #size-cells = <0>;
            reg = <0xc00 0x40>;
            interrupts = <1 8 0  0 3 0>;
            interrupt-parent = <&mpc5200_pic>;
            gpio-controller;
            interrupt-controller;
        };
    ...
    };
    ...
    system {
        compatible = "simple-bus";

        rotary-encoder {
            compatible = "linux,rotary-encoder","rotary-encoder";
            interrupts = <&mpc5200_pic 2 3  &gpio_wkup 0 0>;
            //interrupts = <&mpc5200_pic 2 3>;
            //gpios = <&gpio_wkup 0 0>;
            type = <1>;
            val-ccw = <0x4a>;
            val-cw = <78>;
        };
    };

When I use the "gpios" property instead of the above, I get a useful
gpio number and I can see the signal using sys/class/gpio.  And I also
know the hardware is working because an ancient, pre-device-tree kernel
is working fine.  :)

The problem is that I'm not getting a valid number out for the second
interrupt specification, presumably because the dts compiler doesn't
have any idea how to generate the data--- and I have no idea how to fix
that.

I captured some dmesg information which shows the problem.  The first
line is for IRQ2, which is correct.  The second is for GPIO_WKUP_7,
which the kernel chokes on:

...
irq: irq_create_mapping(0xcf814000,
0x42)                                         
irq: -> using host
@cf814000                                                      
  alloc irq_desc for 66 on node
0                                                 
  alloc kstat_irqs on node
0                                                      
mpc52xx_irqhost_map: External IRQ2 virq=42, hw=42.
type=8                         
irq: irq 66 on host /soc5200@f0000000/interrupt-controller@500 mapped to
virtual irq
66                                                                              

mpc52xx_extirq_set_type: irq=42. l2=2
flow_type=8                                 
linux,rotary-encoder rotary-encoder.3: irq[0] 66 gpio[0] -2  <- my
driver's output, the "magic number" was 66
return 0, l1=4,
l2=0                                                              
irq: irq_create_mapping(0xcf814000,
0x0)                                          
irq: -> using host
@cf814000                                                      
  alloc irq_desc for 16 on node
0                                                 
  alloc kstat_irqs on node
0                                                      
mpc52xx_irqhost_map: External IRQ0 virq=10, hw=0.
type=8                          
irq: irq 0 on host /soc5200@f0000000/interrupt-controller@500 mapped to
virtual irq
16                                                                               

mpc52xx_extirq_set_type: irq=0. l2=0
flow_type=8                                  
linux,rotary-encoder rotary-encoder.3: irq[1] 16 gpio[1] -2         <-
my driver's "magic number" was 16
...


The device tree has the magic number "66" for IRQ2, which
mpc52xx_irqhost_map gets right.  But it doesn't know what to do with the
magic number "16" that's fed to it from the other interrupt
specification.  And I don't yet, either...  :)

Any ideas?  Basically, what I think this boils down to is somewhere I
need to translate that 16 to yet another virtual number for the
demultiplexed interrupt descriptor.  But I'm getting a little lost in
the virtual-ness of everything!


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
