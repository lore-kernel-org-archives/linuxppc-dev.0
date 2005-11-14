Return-Path: <hubert.loewenguth@thales-bm.com>
Received: from thsmsgxrt11p.thalesgroup.com (thsmsgxrt11p.thalesgroup.com
	[192.54.144.134]) by ozlabs.org (Postfix) with ESMTP id 6F7B168726
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 04:41:31 +1100 (EST)
Received: from thsmsgirt22p.corp.thales (unknown [10.33.231.6])
	by thsmsgxrt11p.thalesgroup.com (Postfix) with ESMTP id 043AE3FD0B
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Nov 2005 18:34:24 +0100 (CET)
Received: from thsmsgirt11p-out.corp.thales (10.33.231.1) by
	thsmsgirt22p.corp.thales (7.2.055.4)
	id 4378970900008308 for linuxppc-embedded@ozlabs.org;
	Mon, 14 Nov 2005 18:34:20 +0100
Received: from thsmsgiav11p.corp.thales (unknown [10.33.231.31])
	by thsmsgirt11p-out.corp.thales (Postfix) with SMTP id E85007400A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Nov 2005 18:34:23 +0100 (CET)
Received: from cnfplex.tbm.fr.thales (unknown [10.33.13.187])
	by thsmsgirt11p.corp.thales (Postfix) with ESMTP id D1EAD3C004
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Nov 2005 18:34:23 +0100 (CET)
Received: from [178.1.60.149] (178.1.60.149) by cnfplex.tbm.fr.thales (NPlex
	6.5.026) id 4372EBBD00002FB9 for linuxppc-embedded@ozlabs.org;
	Mon, 14 Nov 2005 18:34:23 +0100
Message-ID: <4378CAA8.5080808@thales-bm.com>
Date: Mon, 14 Nov 2005 18:34:32 +0100
From: hubert loewenguth <hubert.loewenguth@thales-bm.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: MPC8260 fcc_enet transmit timed out
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello to the community

After having searched more than a week to correct my problem, I have 
finally decided to try to find some help :

- I have a board with a MPC8260 (HIP 3 C.2), with three PHY chipset : 
LXT971A from intel
- The MII  lines MDC and MDIO are present, but I have no PHY interrupt line
=> so I have to configure my PHY and the fcc_enet.c drivers to be in 
half-duplex mode
- I use the 2.4.20 linux kernel

Every thing works very fine, everything is ok and the TCP/IP ethernet 
communication works fine (telnet, ftp, udp ....)
BUT if I plug / unplug the ethernet link numerous times during TCP 
traffic,the  fcc_enet.c driver enter in an "infernal loop" and prints 
continuously :

/NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out.
 Ring data dump: cur_tx c02b60b8 (full) cur_rx c02b7098.
 Tx @base c02b60a0 :
1c00 05ea 014f786a
1c00 05ea 013ce06a
1c00 05ea 013ce86a
........
/
And never exit from this infernal loop.

I have found some personns in this mailling list who has encounter a 
problem wich seems similar:

http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016539.html
http://ozlabs.org/pipermail/linuxppc-embedded/2001-December/005714.html

I really don't find what can be the origin of my problem:
- I don't succeed to reproduce it in full duplex mode (using a full 
duplex link and configuring the drivers and the PHY in full duplex)
- I have verified the pin configuration numerous times, the routing of 
clock signals also....
- I have not  applied  a MPC8260  microcode patch, I will try it but I 
don't think there is a patch wich correct it

Is there any personn who has already encounter this matter ?
Thanks to the community for any help

     
