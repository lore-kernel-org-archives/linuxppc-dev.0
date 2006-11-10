Return-Path: <rdcorle@yahoo.com>
Received: from web56310.mail.re3.yahoo.com (web56310.mail.re3.yahoo.com
	[216.252.110.234]) by ozlabs.org (Postfix) with SMTP id 96B5867D78
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Nov 2006 06:53:36 +1100 (EST)
Message-ID: <20061110195334.6093.qmail@web56310.mail.re3.yahoo.com>
Date: Fri, 10 Nov 2006 11:53:34 -0800 (PST)
From: robert corley <rdcorle@yahoo.com>
Subject: RE: minor progress with plb_temac v3.00a, EDK 8.2, & 2.6.18.1
To: linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Rimas;=0A=0AGood call on the PHY address.  I thought that I was on to somet=
hing when=0AI saw that a week or so ago; however, after I checked the datas=
heet on the=0AMARVELL 88E1111 PHY chip and its connection on the ML403 boar=
d, I=0Afound that it is addressed to 0b00000.=0A=0AIt does appear that acce=
ss to the mgmt registers is working, albeit not completely=0Aas expected (s=
ee boot dump, below) with regards to the PHY ID.=0A=0AThe initialization pr=
ocess is pretty simple:=0A=0A1.   Query the PHY [using  XTemac_PhyRead(...)=
] and see what speed it's set to:=0A=0A    [    5.358347] XTemac(set_mac_sp=
eed): PHY Speed from XTemac_PhyRead() =3D 0M, where 2=3D1000M, 1=3D100M, an=
d 0=3D10M=0A=0A=0A2.    Set the MAC to the same speed (in a switch statemen=
t):=0A            XTemac_SetOperatingSpeed(&lp->Emac, 10);=0A=0AI suspect t=
hat the problem is with the first step as it is reporting a different speed=
 than what the LED's on the board show.=0A=0AAny thoughts?=0A =0ARobert Cor=
ley (rdcorle@yahoo.com)=0A=0A=0A=0A=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=0Apartial boot dump fol=
lows...=0A=0A=0A[    2.706547] XTemac (xtenet_probe): Device initialized to=
:=0A[    2.712064]     Device ID    0=0A[    2.714595]     Base Addr    0x6=
0000000=0A[    2.717918]     Rx FIFO    131072=0A[    2.720723]     Tx FIFO=
    131072=0A[    2.723508]     MAC FIFO    64=0A[    2.726052]     DMA mod=
e    3=0A[    2.728514]     TX Dre    2=0A[    2.730782]     Rx Dre    2=0A=
[    2.733067]     Tx CSUM    0=0A[    2.735421]     Rx CSUM    0=0A[    2.=
737792]     Phy Type    1=0A[    2.740268] XTemac (xtenet_probe): MAC initi=
alized to: 00:0A:35:00:22:00=0A[    2.746964] XTemac: using sgDMA mode.=0A[=
    2.750637] XTemac: using TxDRE mode=0A[    2.754221] XTemac: using RxDRE=
 mode=0A[    2.757815] XTemac: buffer descriptor size: 32768 (0x8000)=0A[  =
  2.763779] XTemac: (buffer_descriptor_init) phy: 0x978000, virt: 0xff10000=
0, size: 0x8000=0A[    2.777432] eth0: Dropping NETIF_F_SG since no checksu=
m feature.=0A[    2.784323] eth0: Xilinx TEMAC #0 at 0x60000000 mapped to 0=
xC5050000, irq=3D0=0A[    2.791327] eth0: XTemac id 1.0f, block id 5, type =
8=0A[    2.796886] mice: PS/2 mouse device common for all mice=0A[    2.802=
782] TCP bic registered=0A[    3.308299] eth0: XTemac: Options: 0xb8f2=0A[ =
   5.306282] XTemac(marvell_reset): Marvell 88E1111 reset.=0A[    5.311715]=
 XTemac: (set_mac_speed) Marvell 88E1111 basic-mode status register(#1) =3D=
 0x0148=0A[    5.320083] XTemac: (set_mac_speed) Marvell 88E1111 PHY ID 1 =
=3D 0x0000=0A[    5.326547] XTemac: (set_mac_speed) Marvell 88E1111 PHY ID =
2 =3D 0x0400=0A[    5.333009] XTemac: (set_mac_speed) Marvell 88E1111 1000B=
ASE-T status register(#10) =3D 0x0000=0A[    5.341466] XTemac: (set_mac_spe=
ed) Marvell 88E1111 extended status register(#15) =3D 0x0000=0A[    5.34975=
2] XTemac: (set_mac_speed) Marvell 88E1111 PHY specific status register(#17=
) =3D 0x0000=0A[    5.358347] XTemac(set_mac_speed): PHY Speed from XTemac_=
PhyRead() =3D 0M, where 2=3D1000M, 1=3D100M, and 0=3D10M=0A[    5.367887] e=
th0: XTemac: EMAC speed set to 10Mb/s=0A[    5.372666] XTemac (set_mac_spee=
d): verifying speed settings.  Expect 10M=0A[    5.379480] XTemac: (set_mac=
_speed) Marvell 88E1111 PHY specific status register(#17) =3D 0x0900=0A[   =
 5.388074] eth0: XTemac: PHY Speed from XTemac_PhyRead() =3D 0M, where 2=3D=
1000M, 1=3D100M, and 0=3D10M=0A[    5.396839] eth0: XTemac: EMAC Speed from=
 XTemac_GetOperatingSpeed() =3D 10M=0A[    5.405544] eth0: XTemac: Send Thr=
eshold =3D 16, Receive Threshold =3D 2=0A[    5.411917] eth0: XTemac: Send =
Wait bound =3D 1, Receive Wait bound =3D 1=0A[    6.420309] IP-Config: Comp=
lete:=0A[    6.423375]       device=3Deth0, addr=3D192.168.1.100, mask=3D25=
5.255.255.0, gw=3D192.168.1.1,=0A[    6.431272]      host=3Dnab, domain=3D,=
 nis-domain=3D(none),=0A[    6.436422]      bootserver=3D192.168.1.144, roo=
tserver=3D192.168.1.144, rootpath=3D=0A=0A=0A=0A=0A=0A
