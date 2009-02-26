Return-Path: <mike@it-loops.com>
Received: from lvps87-230-0-242.dedicated.hosteurope.de
	(lvps87-230-0-242.dedicated.hosteurope.de [87.230.0.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "plesk", Issuer "plesk" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2A1D9DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 06:22:38 +1100 (EST)
Message-Id: <D5EBE54F-FD6D-4973-8835-33541ADCBABD@it-loops.com>
From: Michael Guntsche <mike@it-loops.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: PHY not found after migration of gianfar driver to an
	of_platform_driver
Date: Thu, 26 Feb 2009 20:15:51 +0100
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello everyone,

I recently obtained a Mikrotik RB600 and applied the patch from http://cynigram.com/~nfontes/rb600/ 
  to get it up and running with 2.6.28.3
With this patch applied everything was detected on the board and  
worked. For testing purposes I tried a recent git snapshot and noticed  
that the gianfar driver had problems.
While the the Gianfar was detected

[    0.549115] Gianfar MII Bus: probed
[    0.553316] eth0 (fsl-gianfar): not using net_device_ops yet
[    0.560861] eth0: Gianfar Ethernet Controller Version 1.2, 00:0c: 
42:28:de:4e
[    0.568024] eth0: Running with NAPI enabled
[    0.572234] eth0: 256/256 RX/TX BD ring size
[    0.576802] eth1 (fsl-gianfar): not using net_device_ops yet
[    0.584200] eth1: Gianfar Ethernet Controller Version 1.2, 00:0c: 
42:28:de:4f
[    0.591345] eth1: Running with NAPI enabled
[    0.595575] eth1: 256/256 RX/TX BD ring size

trying to up either of the devices gave me

[    8.724818] mdio@24520:01 not found
[    8.728330] eth1: Could not attach to PHY
[    8.732945] mdio@24520:01 not found
[    8.737720] eth1: Could not attach to PHY

I tracked this back to commit  
"b31a1d8b41513b96e9c7ec2f68c5734cef0b26a4 gianfar: Convert gianfar to  
an of_platform_driver". Reverting this one and applying for fsc_soc.c  
made the two nics work again.
I tried to figure out what was causing the problem in the first place,  
but failed miserably. I am pretty sure it is just a minor probing  
issue somewhere in the code but I am not able to spot that.
Maybe someone more knowledgeable than me can take a look at it and  
help me out a little bit.

According to lspci the board is a

00:00.0 Power PC: Freescale Semiconductor Inc MPC8343 (rev 30)

Please CC me in any replies since I am not subscribed to the ML .. yet.

Thanks in advance,
Michael
