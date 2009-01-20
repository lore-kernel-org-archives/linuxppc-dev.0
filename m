Return-Path: <daniel.ng1234@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id C9099DDF04
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 18:23:10 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1260789ywh.39
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 23:23:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <547eba1b0901181758q27d09f1fx7d07d7385f028312@mail.gmail.com>
References: <547eba1b0901151722p4a6afce4nc769fcb8cff82ea6@mail.gmail.com>
	<547eba1b0901151940x588ead2bk52342ea1cecc6db0@mail.gmail.com>
	<20090116181405.GB722@ld0162-tx32.am.freescale.net>
	<547eba1b0901181758q27d09f1fx7d07d7385f028312@mail.gmail.com>
Date: Tue, 20 Jan 2009 18:23:08 +1100
Message-ID: <547eba1b0901192323i2a505dcg841d42092dc5dd5d@mail.gmail.com>
Subject: Re: Device Tree setup for 8272-based board
From: Daniel Ng <daniel.ng1234@gmail.com>
To: Scott Wood <scottwood@freescale.com>
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

Hi Scott,

By #defining DEBUG in setup-32.c and setting the following in my kernel con=
fig-
CONFIG_PPC_EARLY_DEBUG=3Dy
CONFIG_PPC_EARLY_DEBUG_CPM=3Dy
CONFIG_PPC_EARLY_DEBUG_CPM_ADDR=3D0xf0001ff8

-I have been able to get the following boot messages:

## Booting kernel from Legacy Image at 00200000 ...
   Image Name:   Linux-2.6.27-xxx
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1337583 Bytes =3D  1.3 MB
   Load Address: 00400000
   Entry Point:  004006f0
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
Memory <- <0x0 0x2000000> (32MB)
CPU clock-frequency <- 0x13ab6680 (330MHz)
CPU timebase-frequency <- 0xfbc520 (17MHz)
CPU bus-frequency <- 0x3ef1480 (66MHz)

zImage starting: loaded at 0x00400000 (sp: 0x01f789c8)
Allocating 0x2cb6d0 bytes for kernel ...
gunzipping (0x00000000 <- 0x0040c000:0x006c8e60)...done 0x2aa19c bytes

Linux/PowerPC load: root=3D/dev/mtdblock4 rw rootfstype=3Dcramfs
mtdparts=3Dflash:256K(ub
oot),128K(env1),128K(env2),1536K(linux1),6144K(root1),4096K(app1),1536K(lin=
ux2),614
4K(root2),4096K(app2),1536K(usr),-(usb) panic=3D1 console=3DttyCPM0 mem=3D3=
2M usbid=3D1
Finalizing device tree... flat tree at 0x40acb0
Probing machine type ...
  HPXRED ... match !
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:setio
MMU:exit
Using HPXRED machine description
Linux version 2.6.27-xxx (dng@hellsforge) (gcc version 4.2.4) #19 PREEM
PT Tue Jan 20 17:46:59 EST 2009
console [udbg0] enabled
setup_arch: bootmem
hpxred_setup_arch()
No hpxred-bcsr in device tree
arch: exit
Top of RAM: 0x2000000, Total RAM: 0x2000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x00002000
  Normal   0x00002000 -> 0x00002000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00002000
On node 0 totalpages: 8192
free_area_init_node: node 0, pgdat c02a1f7c, node_mem_map c02cc000
  DMA zone: 8128 pages, LIFO batch:0
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
Kernel command line: root=3D/dev/mtdblock4 rw rootfstype=3Dcramfs
mtdparts=3Dflash:256K(u
boot),128K(env1),128K(env2),1536K(linux1),6144K(root1),4096K(app1),1536K(li=
nux2),61
44K(root2),4096K(app2),1536K(usr),-(usb) panic=3D1 console=3DttyCPM0 mem=3D=
32M usbid=3D1
PID hash table entries: 128 (order: 7, 512 bytes)
time_init: decrementer frequency =3D 16.500000 MHz
time_init: processor frequency   =3D 330.000000 MHz
clocksource: timebase mult[f26c9b2] shift[22] registered
clockevent: decrementer mult[439] shift[16] cpu[0]
Console: colour dummy =FC

-at this point the board just reboots.

Is there anything in the above logs that might signify why the reboot happe=
ned?


I thought it might have been to do with:

'No hpxred-bcsr in device tree'

If I add in a 'BCSR' node to my Device Tree I get the following:

console [udbg0] enabled
setup_arch: bootmem
hpxred_setup_arch()
Machine check in kernel mode.
Caused by (from SRR1=3D41030): Transfer error ack signal
Oops: Machine check, sig: 7 [#1]
PREEMPT HPXRED
NIP: c0273804 LR: c02737f4 CTR: 00000000
REGS: c02a5ee0 TRAP: 0200   Not tainted  (2.6.27-800-OS-03050107)
MSR: 00041030 <ME,IR,DR>  CR: 22044028  XER: 20000000
TASK =3D c028c578[0] 'swapper' THREAD: c02a4000
GPR00: c02737f4 c02a5f90 c028c578 00000000 c000d260 00000000 c02ccffc 00000=
2c0
GPR08: c02ccffc 7c3203a6 00000000 f45005a9 22044042 ffdfffff 01ff8000 00000=
000
GPR16: 01fed694 01ff56f0 00000000 00000000 00000000 00000000 00000000 01ff2=
cd0
GPR24: 00000000 00000000 40000000 00000000 006d4ff0 fdfff000 c02ac4cc c1fff=
970
NIP [c0273804] hpxred_setup_arch+0xf0/0x1dc
LR [c02737f4] hpxred_setup_arch+0xe0/0x1dc
Call Trace:
[c02a5f90] [c02737f4] hpxred_setup_arch+0xe0/0x1dc (unreliable)
[c02a5fb0] [c026f63c] setup_arch+0x130/0x168
[c02a5fc0] [c026c67c] start_kernel+0xa0/0x2c0
[c02a5ff0] [00003438] 0x3438
Instruction dump:
4bf03c3d 7c7f1b79 418200d4 38800000 4bd97425 7c7d1b78 7fe3fb78 4bd99491
2f9d0000 419e00d8 7c0004ac 813d0004 <0c090000> 4c00012c 3c00f4ff 6000ffff
---[ end trace 31fd0ba7d8756001 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
Rebooting in 180 seconds..

Which leads me to think BCSR is irrelevant for my board. What is BCSR?

Here's the current Device Tree:

/dts-v1/;

/ {
  model =3D "HPXRED";
  compatible =3D "hpxred";
  #address-cells =3D <1>;
  #size-cells =3D <1>;

  cpus {
    #address-cells =3D <1>;
    #size-cells =3D <0>;

    PowerPC,8272@0 {
      device_type =3D "cpu";
      reg =3D <0x0>;
      d-cache-line-size =3D <32>;
      i-cache-line-size =3D <32>;
      d-cache-size =3D <16384>;
      i-cache-size =3D <16384>;
      timebase-frequency =3D <0>;
      bus-frequency =3D <0>;
      clock-frequency =3D <0>;
    };
  };

  memory {
    device_type =3D "memory";
    reg =3D <0x0 0x0>;
  };

  soc@f0000000 {
    #address-cells =3D <1>;
    #size-cells =3D <1>;
    device_type =3D "soc";
    compatible =3D "fsl,mpc8272", "fsl,pq2-soc";
    ranges =3D <0x0 0xf0000000 0x53000>;

    // Temporary -- will go away once kernel uses ranges for get_immrbase()=
.
    reg =3D <0xf0000000 0x53000>;

    cpm@119c0 {
      #address-cells =3D <1>;
      #size-cells =3D <1>;
      #interrupt-cells =3D <2>;
      compatible =3D "fsl,mpc8272-cpm", "fsl,cpm2";
      reg =3D <0x119c0 0x30>;
      ranges;

      muram@0 {
        #address-cells =3D <1>;
        #size-cells =3D <1>;
        ranges =3D <0x0 0x0 0x10000>;

        data@0 {
          compatible =3D "fsl,cpm-muram-data";
          reg =3D <0x0 0x2000 0x9800 0x800>;
        };
      };

      brg@119f0 {
        compatible =3D "fsl,mpc8272-brg",
                     "fsl,cpm2-brg",
                     "fsl,cpm-brg";
        reg =3D <0x119f0 0x10 0x115f0 0x10>;
      };

      serial@11a00 {
        device_type =3D "serial";
        compatible =3D "fsl,mpc8272-scc-uart",
                     "fsl,cpm2-scc-uart";
        reg =3D <0x11a00 0x20 0x8000 0x100>;
        interrupts =3D <40 8>;
        interrupt-parent =3D <&PIC>;
        fsl,cpm-brg =3D <1>;
        fsl,cpm-command =3D <0x800000>;
      };

  };

    PIC: interrupt-controller@10c00 {
      #interrupt-cells =3D <2>;
      interrupt-controller;
      reg =3D <0x10c00 0x80>;
      compatible =3D "fsl,mpc8272-pic", "fsl,cpm2-pic";
    };

  };

  chosen {
    linux,stdout-path =3D "/soc/cpm/serial@11a00";
  };
};



For BCSR, I tried adding the following immediately below the 'memory'
node, just as in mpc8272ads.dts:

  localbus@f0010100 {
    compatible =3D "fsl,mpc8272-localbus",
                 "fsl,pq2-localbus";
    #address-cells =3D <2>;
    #size-cells =3D <1>;
    reg =3D <0xf0010100 0x40>;

    ranges =3D <0x0 0x0 0xfe000000 0x2000000
              0x1 0x0 0xf4500000 0x8000
              0x3 0x0 0xf8200000 0x8000>;

    board-control@1,0 {
      reg =3D <0x1 0x0 0x20>;
      compatible =3D "fsl,mpc8272ads-bcsr";
    };
  };


Another possibility might be that I have set the following in the kernel-

CONFIG_HZ=3D250

-this is in contrast to the above reported 330Mhz. When I had 2.6.14
working with an old version of u-boot, this was not a problem. Could
it be causing me troubles now?

In the "2.6.14+old u-boot" setup, I had also configured u-boot such
that the memory was set to 64MB, but I told the kernel it was either
32MB or 64MB depending on what was physically available. This was so I
could use the same u-boot for boards with either 32MB or 64MB. Is it
still possible to do this for the new u-boot and kernel 2.6.27?
