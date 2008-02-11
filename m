Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 4D267DDF13
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 08:28:11 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: WARN_ON() hit in fsl bitbanged phy driver
Date: Mon, 11 Feb 2008 15:28:08 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B03F931E6@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>,
	<netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I hit the following WARN_ON when using mii-tools agains a ethernet
interface using a bit-banged mii interface
It is only diplayed once, and does not seem to impact usage at all

Does somebody know what is wrong, and how to fix it?
The PHY is an Intel LXT973

Badness at kernel/softirq.c:139
NIP: c001f8bc LR: c0121170 CTR: c01269d8
REGS: dfaa5ce0 TRAP: 0700   Tainted: P         (2.6.24-cpu2)
MSR: 00021032 <ME,IR,DR>  CR: 20002222  XER: 20000000
TASK =3D de0c2b40[825] 'mii-tool' THREAD: dfaa4000
GPR00: 00000001 dfaa5d90 de0c2b40 0000782d 00000000 00000005 00000001
0ff6a37c
GPR08: 00000000 c0250000 df86bb60 08000000 80000242 1001aa20 00000000
100aa258
GPR16: 10090000 00000000 10090000 00000000 10070000 100aa170 10010000
bff3bd94
GPR24: 00000003 00000000 00000001 c0123234 0000782d dfaa4000 00000000
df003a00
NIP [c001f8bc] local_bh_enable+0x28/0x9c
LR [c0121170] phy_read+0x5c/0x74
Call Trace:
[dfaa5d90] [dfaa4000] 0xdfaa4000 (unreliable)
[dfaa5da0] [c0121170] phy_read+0x5c/0x74
drivers/net/phy/phy.c:80
[dfaa5dc0] [c012140c] phy_mii_ioctl+0x64/0x170
drivers/net/phy/phy.c:368
[dfaa5de0] [c0125394] fs_ioctl+0x4c/0x8c
[dfaa5e00] [c0143744] dev_ifsioc+0x2e8/0x314
[dfaa5e20] [c0144eb8] dev_ioctl+0x6f4/0x8a8
[dfaa5ea0] [c0136aa8] sock_ioctl+0x1fc/0x21c
[dfaa5ec0] [c00742e0] do_ioctl+0x44/0xa8
[dfaa5ee0] [c00746e8] vfs_ioctl+0x3a4/0x3e8
[dfaa5f10] [c007476c] sys_ioctl+0x40/0x70
[dfaa5f40] [c000edc8] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff6a37c
    LR =3D 0xffecd58
Instruction dump:
7c0803a6 4e800020 9421fff0 7c0802a6 90010014 7c0000a6 70098000 40a2002c
3d20c025 8009d2a8 7c000034 5400d97e <0f000000> 2f800000 41be0010
38000001

(gdb) list *0xc0121170
0xc0121170 is in phy_read (drivers/net/phy/phy.c:80).
75              spin_lock_bh(&bus->mdio_lock);
76              retval =3D bus->read(bus, phydev->addr, regnum);
77              spin_unlock_bh(&bus->mdio_lock);
78
79              return retval;
80      }
81      EXPORT_SYMBOL(phy_read);
82
83      /**
84       * phy_write - Convenience function for writing a given PHY
register
(gdb) list *0xc012140c
0xc012140c is in phy_mii_ioctl (drivers/net/phy/phy.c:368).
363             switch (cmd) {
364             case SIOCGMIIPHY:
365                     mii_data->phy_id =3D phydev->addr;
366                     break;
367             case SIOCGMIIREG:
368                     mii_data->val_out =3D phy_read(phydev,
mii_data->reg_num);
369                     break;
370
371             case SIOCSMIIREG:
372                     if (!capable(CAP_NET_ADMIN))
(gdb) list *0xc001f8bc
0xc001f8bc is in local_bh_enable (kernel/softirq.c:139).
134     #ifdef CONFIG_TRACE_IRQFLAGS
135             unsigned long flags;
136
137             WARN_ON_ONCE(in_irq());
138     #endif
139             WARN_ON_ONCE(irqs_disabled());
140
141     #ifdef CONFIG_TRACE_IRQFLAGS
142             local_irq_save(flags);
143     #endif

the relevant part of my device tree is:
ethernet@11340 {
	device_type =3D "network";
	compatible =3D "fsl,mpc8280-fcc-enet",
		     "fsl,cpm2-fcc-enet";
	reg =3D <11340 20 8600 100 113d0 1>;
	interrupts =3D <22 8>;
	interrupt-parent =3D <&PIC>;
	phy-handle =3D <&PHY1>;
	linux,network-index =3D <1>;
	fsl,cpm-command =3D <1a400300>;
	local-mac-address =3D [00 00 00 00 00 00];
};

mdio@10d40 {
	device_type =3D "mdio";
	compatible =3D "fsl,pq2fads-mdio-bitbang",
		     "fsl,mpc8280-mdio-bitbang",
		     "fsl,cpm2-mdio-bitbang";
	#address-cells =3D <1>;
	#size-cells =3D <0>;
	reg =3D <10d40 14>;
	fsl,mdio-pin =3D <5>;
	fsl,mdc-pin =3D <4>;

	PHY1: ethernet-phy@1 {
		//interrupt-parent =3D <&PIC>;
		//interrupts =3D <19 2>;
		reg =3D <1>;
		device_type =3D "ethernet-phy";
	};
};
