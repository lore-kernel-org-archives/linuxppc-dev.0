Return-Path: <Rick.Moleres@xilinx.com>
Received: from outbound4-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 16277DDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Apr 2007 10:01:31 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Subject: RE: Linux w/ML403 PLB TEMAC
Date: Wed, 4 Apr 2007 18:00:24 -0600
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C013E20B0@ehost011-3.exch011.intermedia.net>
From: "Rick Moleres" <Rick.Moleres@xilinx.com>
To: "Leonid" <Leonid@a-k-a.net>,
	<linuxppc-embedded@ozlabs.org>
Message-Id: <20070405000126.880201A48059@mail69-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Leonid,

If it's not the ML403 board and the FX part is CES4 or later (read this =
at the bottom of the FX chip), then you will need hard_temac_v3_00_b to =
get the MDIO access working properly.

If this is pre-CES4 silicon, then hard_temac_v3_00_a is the right =
version and there may be an issue with the MDIO signal connectivity in =
your design (? just guessing).  You can also try to hardcode the PHY =
address (gmii_addr) and see if the speed detection works at that point - =
but my guess is it won't.

-Rick

-----Original Message-----
From: Leonid [mailto:Leonid@a-k-a.net]=20
Sent: Wednesday, April 04, 2007 5:50 PM
To: Rick Moleres; linuxppc-embedded@ozlabs.org
Subject: RE: Linux w/ML403 PLB TEMAC

Hi, Rick:

We have both in our design and both are 3.00a. I'm not sure why - I'll =
ask our HW folks.=20

I have actually managed (just 30 minutes ago) to bring up network =
interface but I have commented out all accesses to PHY in your adapter.c =
and I set speed to 1000 always (see my adapter.c attached). Without =
these changes packets are not transmitted out of board.

This is probably some issue in my EDK project.

I'm not using ML403 actually but another proprietary board, based on =
Virtex
4 (69FX) FPGA.

Thanks,

Leonid.

-----Original Message-----
From: Rick Moleres [mailto:Rick.Moleres@xilinx.com]=20
Sent: Wednesday, April 04, 2007 4:41 PM
To: Leonid; Glenn.G.Hart@us.westinghouse.com; =
linuxppc-embedded@ozlabs.org
Subject: RE: Linux w/ML403 PLB TEMAC

Leonid,

You mentioned that the TEMAC version if v3.00a.  Is this the plb_temac =
version or the hard_temac version, or both?

-Rick

-----Original Message-----
From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On =
Behalf Of Leonid
Sent: Wednesday, April 04, 2007 4:14 PM
To: Glenn.G.Hart@us.westinghouse.com; linuxppc-embedded@ozlabs.org
Subject: RE: Linux w/ML403 PLB TEMAC

I have investigated little bit more. Receive is working actually, but =
transmit doesn't. What can it be?

-----Original Message-----
From: linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org =
[mailto:linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org] On =
Behalf Of Leonid
Sent: Wednesday, April 04, 2007 12:06 PM
To: Glenn.G.Hart@us.westinghouse.com; linuxppc-embedded@ozlabs.org
Subject: RE: Linux w/ML403 PLB TEMAC

I have precisely the same problem you have described:

[    0.430515] XTemac: using FIFO direct interrupt driven mode.
[    0.437461] eth%d: XTemac: No PHY detected.  Assuming a PHY at =
address 0
[    0.445295] eth0: Xilinx TEMAC #0 at 0x02000000 mapped to 0xC3000000, =
irq=3D0
[    0.452256] eth0: XTemac id 1.0f, block id 5, type 8
[    0.458665] tun: Universal TUN/TAP device driver, 1.6
[    0.463712] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    0.471106] mice: PS/2 mouse device common for all mice
[    0.476339] TCP cubic registered
[    0.479615] NET: Registered protocol family 1
[    0.484032] NET: Registered protocol family 17
[    0.992599] eth0: XTemac: Options: 0xb8f2
[   12.955691] eth0: XTemac: Not able to set the speed to 1000 (status: =
0x0)
[   22.928615] eth0: XTemac: Not able to set the speed to 100 (status: =
0x0)
[   32.901449] eth0: XTemac: Not able to set the speed to 10 (status: =
0x0)
[   32.907976] eth0: XTemac: could not negotiate speed
[   33.921626] IP-Config: Complete:
[   33.924635]       device=3Deth0, addr=3D192.168.0.223, =
mask=3D255.255.255.0, gw=3D192.168.0.1,
[   33.932418]      host=3DLM200, domain=3D, nis-domain=3D(none),
[   33.937715]      bootserver=3D192.168.0.141, =
rootserver=3D192.168.0.141, rootpath=3D
[   33.946230] Looking up port of RPC 100003/2 on 192.168.0.141
[   34.916694] eth0: XTemac: PHY Link carrier lost.

My TEMAC core version is 3.00.a and low level code I'm using is working =
in u-boot without problems. I use Rick's adapter and also tried Ming's =
trick to set hardcoded speed value but with no success.

I suspect something is configured wrong - phys is not detected:

[    0.437461] eth%d: XTemac: No PHY detected.  Assuming a PHY at =
address 0

Leonid.

-----Original Message-----
From: linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org =
[mailto:linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org] On =
Behalf Of Glenn.G.Hart@us.westinghouse.com
Sent: Wednesday, February 14, 2007 6:48 AM
To: linuxppc-embedded@ozlabs.org
Subject: RE: Linux w/ML403 PLB TEMAC

Ming/Rick,

I tried setting the speed to 1000 as below, but it did not change the
result.  I also tried Rick's new adapter.c with the same results.  =
Changing
the hard_temac_v3_b to hard_temac_v3_a was the change I needed.
Unfortunately, the speed of the network is much slower now.  I switched =
to
DMA and then changed the Linux drivers for the DMA & TEMAC v2 to v3.

I have my own program to test performance.  It seems everything is so =
slow
it does not every complete to give me the statistics.  My ping are also
slower.  I used to be able to ping my computer and get 0.6-0.7 ms times.
With the DMA and TEMAC v3 I am now getting 1.8 ms times.

I am now not sure if it is my build or my PPC design.  For the PPC =
design I
have a minimum PPC with OPB-RS232, PLB-DDR, and PLB-TEMAC.  I use all =
the
defaults from BSB except I check use interrupt on the RS232 and TEMAC.

Any suggestions?

Thanks,
Glenn



                                                                         =
                           =20
 (Embedded     "Ming Liu" <eemingliu@hotmail.com>@ozlabs.org             =
                           =20
 image moved   02/12/2007 11:48 AM                                       =
                           =20
 to file:                                                                =
                           =20
 pic04169.pcx)                                                           =
                           =20
                                                                         =
                           =20
                                                                         =
                           =20


Sent by:
       =
linuxppc-embedded-bounces+glenn.g.hart=3Dus.westinghouse.com@ozlabs.org


To:    Glenn.G.Hart@us.westinghouse.com
cc:    linuxppc-embedded@ozlabs.org
Subject:    RE: Linux w/ML403 PLB TEMAC

Security Level:?              Internal


Dear Glenn,

>3.  The speed of the network was very poor.  I wanted to implement DMA =
for
>the TEMAC.  I created a new PPC with BSB using DMA on the TEMAC.  =
Kernel
>recompilied without a problem, but upon starting the kernel I got:

In fact, the old cores of TEMAC(plb_temac 2.00 & hard_temac 1.00) also
support DMA. But of course the 3.00 cores are prefered because of other
improved features.

>6.  I am using busybox 1.2.1 which worked fine previously configuring =
the
>network.  Now when I execute ifconfig I get the following problem:
>[   12.228721] eth0: XTemac: Options: 0xb8f2
>[   24.197749] eth0: XTemac: Not able to set the speed to 1000 (status:
>0x148)
>[   34.215593] eth0: XTemac: Not able to set the speed to 100 (status:
>0x148)
>[   44.232349] eth0: XTemac: Not able to set the speed to 10 (status:
>0x148)
>[   44.313727] eth0: XTemac: could not negotiate speed
>[   44.372226] eth0: XTemac: Send Threshold =3D 16, Receive Threshold =
=3D 2
>[   44.448421] eth0: XTemac: Send Wait bound =3D 1, Receive Wait bound =
=3D 1
># [   57.180152] eth0: XTemac: PHY Link carrier lost.

I also had such a problem before. To solve such a problem most quickly, =
you
can just specify a fixed speed (like 1000Mbps) in adapter.c file. In =
this
file, after the line of "/* Get current link speed */ (around L378) and
"phylinkspeed =3D (RegValue & MARVELL_88E1111_LINKSPEED_MARK)>>
MARVELL_88E1111_LINKSPEED_SHIFT;", I just add and specify the speed as
"phylinkspeed =3D MARVELL_88E1111_LINKSPEED_1000M;" Of course with this
method, the speed cannot be auto-negotiated any more.

Another hints: I remember that there is another post from Rick on the
updated "adapter.c" a few days ago. Maybe that could solve your problem. =
I
didn't try that before. So if you will try, pls let us know the result. =
:)

BR
Ming

_________________________________________________________________
=CF=ED=D3=C3=CA=C0=BD=E7=C9=CF=D7=EE=B4=F3=B5=C4=B5=E7=D7=D3=D3=CA=BC=FE=CF=
=B5=CD=B3=A1=AA MSN Hotmail=A1=A3  http://www.hotmail.com

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded










_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
