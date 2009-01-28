Return-Path: <daniel.ng1234@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id B069CDE0D2
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 16:04:13 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so2556567yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 21:04:11 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 28 Jan 2009 16:04:11 +1100
Message-ID: <547eba1b0901272104r69f80c88yf99bb009ff886688@mail.gmail.com>
Subject: How to bring up fs_enet on 2.6.27?
From: Daniel Ng <daniel.ng1234@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm trying to bring the primary Ethernet interface up on my 8272-based
board running 2.6.27.

Previously, I had this same hardware working with 2.6.14 using the
following driver:

linux-2.6.14/arch/ppc/8260_io/fcc_enet.c

This doesn't exist anymore in 2.6.27. From reading the code comments,
I think the new driver I should be using is:

linux-2.6.27/drivers/net/fs_enet/fs_enet-main.c

The PHY is an Intel LXT972. I have selected the closest-matching
Kernel config option 'LXT970'.

The primary ethernet uses FCC2.

Here are the relevant boot messages:

OF: ** translation for device /soc@f0000000 **
OF: bus is default (na=3D1, ns=3D1) on /
OF: translating address: f0000000
OF: reached root node
OF: ** translation for device /soc@f0000000/cpm@119c0/muram@0/data@0 **
OF: bus is default (na=3D1, ns=3D1) on /soc@f0000000/cpm@119c0/muram@0
OF: translating address: 00000000
OF: parent bus is default (na=3D1, ns=3D1) on /soc@f0000000/cpm@119c0
OF: walking ranges...
OF: default map, cp=3D0, s=3D10000, da=3D0
OF: parent translation for: 00000000
OF: with offset: 0
OF: one level translation: 00000000
OF: parent bus is default (na=3D1, ns=3D1) on /soc@f0000000
OF: no ranges, 1:1 translation
OF: parent translation for: 00000000
OF: with offset: 0
OF: one level translation: 00000000
OF: parent bus is default (na=3D1, ns=3D1) on /
OF: walking ranges...
OF: default map, cp=3D0, s=3D53000, da=3D0
OF: parent translation for: f0000000
OF: with offset: 0
OF: one level translation: f0000000
OF: reached root node
OF: ** translation for device /soc@f0000000/cpm@119c0/muram@0/data@0 **
OF: bus is default (na=3D1, ns=3D1) on /soc@f0000000/cpm@119c0/muram@0
OF: translating address: 00000000
OF: parent bus is default (na=3D1, ns=3D1) on /soc@f0000000/cpm@119c0
OF: walking ranges...
OF: default map, cp=3D0, s=3D10000, da=3D0
OF: parent translation for: 00000000
OF: with offset: 0
OF: one level translation: 00000000
OF: parent bus is default (na=3D1, ns=3D1) on /soc@f0000000
OF: no ranges, 1:1 translation
OF: parent translation for: 00000000
OF: with offset: 0
OF: one level translation: 00000000
OF: parent bus is default (na=3D1, ns=3D1) on /
OF: walking ranges...
OF: default map, cp=3D0, s=3D53000, da=3D0
OF: parent translation for: f0000000
OF: with offset: 0
OF: one level translation: f0000000
OF: reached root node
OF: ** translation for device /soc@f0000000/cpm@119c0/muram@0/data@0 **
OF: bus is default (na=3D1, ns=3D1) on /soc@f0000000/cpm@119c0/muram@0
OF: translating address: 00009800
OF: parent bus is default (na=3D1, ns=3D1) on /soc@f0000000/cpm@119c0
OF: walking ranges...
OF: default map, cp=3D0, s=3D10000, da=3D9800
OF: parent translation for: 00000000
OF: with offset: 9800
OF: one level translation: 00009800
OF: parent bus is default (na=3D1, ns=3D1) on /soc@f0000000
OF: no ranges, 1:1 translation
OF: parent translation for: 00000000
OF: with offset: 9800
OF: one level translation: 00009800
OF: parent bus is default (na=3D1, ns=3D1) on /
OF: walking ranges...
OF: default map, cp=3D0, s=3D53000, da=3D9800
OF: parent translation for: f0000000
OF: with offset: 9800
OF: one level translation: f0009800
OF: reached root node
hpxred_setup_arch(), finished
arch: exit
....
Kernel command line: root=3D/dev/nfs rw
nfsroot=3D192.168.1.8:/tftpboot/192.168.1.75/ro
otfs ip=3D192.168.1.75:192.168.1.8::255.255.255.0:hpx800:eth2:off
mtdparts=3Dflash:256K
(uboot),128K(env1),128K(env2),1536K(linux1),6144K(root1),4096K(app1),1536K(=
linux2),
6144K(root2),4096K(app2),1536K(usr),-(usb) panic=3D1 console=3DttyCPM0
mem=3D32M usbid=3D1
hpxred_pic_init()
irq: Allocated host of type 2 @0xc03163a0
hpxred_pic_init(), finished
PID hash table entries: 128 (order: 7, 512 bytes)
time_init: decrementer frequency =3D 16.500000 MHz
time_init: processor frequency   =3D 330.000000 MHz
clocksource: timebase mult[f26c9b2] shift[22] registered
clockevent: decrementer mult[439] shift[16] cpu[0]
Console: colour dummy device 80x25
cpm_uart_init_port()
OF: ** translation for device /soc@f0000000/cpm@119c0/serial@11a00 **
OF: bus is default (na=3D1, ns=3D1) on /soc@f0000000/cpm@119c0
OF: translating address: 00011a00
OF: parent bus is default (na=3D1, ns=3D1) on /soc@f0000000
OF: no ranges, 1:1 translation
OF: parent translation for: 00000000
OF: with offset: 11a00
OF: one level translation: 00011a00
OF: parent bus is default (na=3D1, ns=3D1) on /
OF: walking ranges...
OF: default map, cp=3D0, s=3D53000, da=3D11a00
OF: parent translation for: f0000000
OF: with offset: 11a00
OF: one level translation: f0011a00
OF: reached root node
OF: ** translation for device /soc@f0000000/cpm@119c0/serial@11a00 **
OF: bus is default (na=3D1, ns=3D1) on /soc@f0000000/cpm@119c0
OF: translating address: 00008000
OF: parent bus is default (na=3D1, ns=3D1) on /soc@f0000000
OF: no ranges, 1:1 translation
OF: parent translation for: 00000000
OF: with offset: 8000
OF: one level translation: 00008000
OF: parent bus is default (na=3D1, ns=3D1) on /
OF: walking ranges...
OF: default map, cp=3D0, s=3D53000, da=3D8000
OF: parent translation for: f0000000
OF: with offset: 8000
OF: one level translation: f0008000
OF: reached root node
of_irq_map_one: dev=3D/soc@f0000000/cpm@119c0/serial@11a00, index=3D0
 intsize=3D2 intlen=3D2
of_irq_map_raw:
par=3D/soc@f0000000/interrupt-controller@10c00,intspec=3D[0x00000028 0x
00000008...],ointsize=3D2
of_irq_map_raw: ipar=3D/soc@f0000000/interrupt-controller@10c00, size=3D2
 -> addrsize=3D1
 -> got it !
irq: irq_create_mapping(0xc03163a0, 0x28)
irq: -> using host @c03163a0
irq: -> obtained virq 40
cpm2_pic_host_map(40, 0x28)
of_get_gpio exited with status -2
of_get_gpio exited with status -2
of_get_gpio exited with status -2
of_get_gpio exited with status -2
of_get_gpio exited with status -2
of_get_gpio exited with status -2
cpm_uart_request_port()
CPM uart[=FEDentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 29564k/32768k available (2636k kernel code, 3204k reserved,
104k data, 129k
 bss, 120k init)
...
kobject: 'fs_enet' (c1810900): kobject_add_internal: parent: 'module',
set: 'module'
....
bus: 'mdio_bus': add driver LXT970
kobject: 'LXT970' (c1817900): kobject_add_internal: parent: 'drivers',
set: 'driver
s'
LXT970: Registered new driver
bus: 'mdio_bus': add driver LXT971
kobject: 'LXT971' (c1817960): kobject_add_internal: parent: 'drivers',
set: 'driver
s'
LXT971: Registered new driver
Registering platform device 'Fixed MDIO bus.0'. Parent at platform
device: 'Fixed MDIO bus.0': device_add
kobject: 'Fixed MDIO bus.0' (c1946470): kobject_add_internal: parent:
'platform', s
et: 'devices'
bus: 'platform': add device Fixed MDIO bus.0
Fixed MDIO Bus: probed
bus: 'of_platform': add driver mdio-gpio
kobject: 'mdio-gpio' (c18179c0): kobject_add_internal: parent:
'drivers', set: 'dri
vers'
....
bus: 'of_platform': add driver fs_enet
kobject: 'fs_enet' (c1817a80): kobject_add_internal: parent:
'drivers', set: 'drive
rs'
bus: 'of_platform': add driver fsl-bb-mdio
kobject: 'fsl-bb-mdio' (c1817ae0): kobject_add_internal: parent:
'drivers', set: 'd
rivers'
....
IP-Config: Device `eth2' not found.
driver_probe_done: probe_count =3D 0


The fs_enet probe() function doesn't seem to get called (I had put a
panic() in it). Should it?

I also tried searching for 'eth0' and 'eth1' but got the same result.
'eth2' was what I used with 2.6.14.


Here's the relevant parts of the Device Tree:

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
                     "fsl,cpm2-brg";
        reg =3D <0x119f0 0x10 0x115f0 0x10>;
        clock-frequency =3D <0>;
      };

      serial@11a00 {
        device_type =3D "serial";
        compatible =3D "fsl,mpc8272-scc-uart",
                     "fsl,cpm2-scc-uart";
        reg =3D <0x11a00 0x20 0x8000 0x100>;
        interrupts =3D <40 8>;
        interrupt-parent =3D <&PIC>;
        fsl,cpm-brg =3D <0>;
        fsl,cpm-command =3D <0x800000>;
      };

      ethernet@11320 {
        device_type =3D "network";
        compatible =3D "fsl,mpc8272-fcc-enet",
                     "fsl,cpm2-fcc-enet";
        // FCC2-
        reg =3D <0x11320 0x20 0x8500 0x100 0x113b0 0x1>;
        local-mac-address =3D [ 00 00 00 00 00 00 ];
        interrupts =3D <33 8>;
        interrupt-parent =3D <&PIC>;
        phy-handle =3D <&PHY0>;
        linux,network-index =3D <0>;
        fsl,cpm-command =3D <0x12000300>;
      };

      mdio@10d40 {
        device_type =3D "mdio";
        compatible =3D "fsl,mpc8272ads-mdio-bitbang",
                     "fsl,mpc8272-mdio-bitbang",
                     "fsl,cpm2-mdio-bitbang";
        reg =3D <0x10d40 0x14>;
        #address-cells =3D <1>;
        #size-cells =3D <0>;
        fsl,mdio-pin =3D <5>;
        fsl,mdc-pin =3D <19>;

        PHY0: ethernet-phy@0 {
          interrupt-parenn =3D <&PIC>;
          interrupts =3D <23 8>;
          reg =3D <0x0>;
          device_type =3D "ethernet-phy";
        };

     };

  };

    PIC: interrupt-controller@10c00 {
      #interrupt-cells =3D <2>;
      interrupt-controller;
      reg =3D <0x10c00 0x80>;
      compatible =3D "fsl,mpc8272-pic", "fsl,cpm2-pic";
    };

  };


Cheers,
Daniel
