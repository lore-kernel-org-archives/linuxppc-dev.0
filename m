Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s39.bay0.hotmail.com (bay0-omc3-s39.bay0.hotmail.com
	[65.54.246.239]) by ozlabs.org (Postfix) with ESMTP id 40FE4DDEF3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Feb 2007 03:48:41 +1100 (EST)
Message-ID: <BAY110-F272ED0813A4E5525FCFB1B2910@phx.gbl>
In-Reply-To: <OFA8757C72.4AE0CD07-ON05257280.0056E088-85257280.0059154B@ct.wec.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: Glenn.G.Hart@us.westinghouse.com
Subject: RE: Linux w/ML403 PLB TEMAC
Date: Mon, 12 Feb 2007 16:48:35 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Glenn,

>3.  The speed of the network was very poor.  I wanted to implement DMA for
>the TEMAC.  I created a new PPC with BSB using DMA on the TEMAC.  Kernel
>recompilied without a problem, but upon starting the kernel I got:

In fact, the old cores of TEMAC(plb_temac 2.00 & hard_temac 1.00) also 
support DMA. But of course the 3.00 cores are prefered because of other 
improved features. 

>6.  I am using busybox 1.2.1 which worked fine previously configuring the
>network.  Now when I execute ifconfig I get the following problem:
>[   12.228721] eth0: XTemac: Options: 0xb8f2
>[   24.197749] eth0: XTemac: Not able to set the speed to 1000 (status:
>0x148)
>[   34.215593] eth0: XTemac: Not able to set the speed to 100 (status:
>0x148)
>[   44.232349] eth0: XTemac: Not able to set the speed to 10 (status:
>0x148)
>[   44.313727] eth0: XTemac: could not negotiate speed
>[   44.372226] eth0: XTemac: Send Threshold = 16, Receive Threshold = 2
>[   44.448421] eth0: XTemac: Send Wait bound = 1, Receive Wait bound = 1
># [   57.180152] eth0: XTemac: PHY Link carrier lost.

I also had such a problem before. To solve such a problem most quickly, you 
can just specify a fixed speed (like 1000Mbps) in adapter.c file. In this 
file, after the line of "/* Get current link speed */ (around L378) and 
"phylinkspeed = (RegValue & MARVELL_88E1111_LINKSPEED_MARK)>> 
MARVELL_88E1111_LINKSPEED_SHIFT;", I just add and specify the speed as 
"phylinkspeed = MARVELL_88E1111_LINKSPEED_1000M;" Of course with this 
method, the speed cannot be auto-negotiated any more.

Another hints: I remember that there is another post from Rick on the 
updated "adapter.c" a few days ago. Maybe that could solve your problem. I 
didn't try that before. So if you will try, pls let us know the result. :)

BR
Ming

_________________________________________________________________
享用世界上最大的电子邮件系统— MSN Hotmail。  http://www.hotmail.com  
