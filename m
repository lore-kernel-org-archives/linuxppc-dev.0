Return-Path: <nst@gersys.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id EE115B70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Nov 2010 03:38:03 +1100 (EST)
Message-ID: <4CD431B4.7060405@gersys.de>
Date: Fri, 05 Nov 2010 17:32:52 +0100
From: Stefan Strobl <nst@gersys.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Problem Ethernet Initialization MPC5200 +  LXT971A
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

I'm having a Problem with the Initialization of my Ethernet PHY 
(FEC_MPC5200 + LXT971A Phy). I'm using latest U-Boot and Linux 2.6.37 
from Denx.

Once in Linux I can ping my own IP-Address but not any other device in 
my network. The Link LED is on when connected to the network but when 
pinging some other device nothing is being transmitted (Traffic LED is off).

If - before booting - I'm using any network command under U-Boot (which 
is calling eth_init()), the interface works fine after that under Linux 
also!
In that case the kernel prints the line:
      PHY: f003000:00 - Link is Up - 100/Full

So I'm not sure whether the Linux driver does not initialize the PHY 
correctly or whether I should be running a command under Linux that 
makes the interface work. I've played around with ifconfig but that 
didn't get me any further.

Under sysfs I can see that the MAC address is assigned correctly but:
carrier = 0	(should be 1)
duplex = half	(should be full)
operstate = down
speed = 10	(should be 100)

To workaround I could make u-boot run eth_init() always but that doesn't 
seem the right approach to this.

Any ideas?

Many Thanks,
Stefan.
