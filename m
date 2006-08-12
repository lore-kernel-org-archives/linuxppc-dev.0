Return-Path: <r26191@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 1183F67B73
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Aug 2006 11:02:26 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7C2KnSM011812 for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 20:20:49 -0600 (MDT)
Received: from zhk08exm40.ap.freescale.net (zhk08exm40.ap.freescale.net
	[10.196.51.1])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k7C12MSO006835
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 20:02:23 -0500 (CDT)
Message-ID: <3140C9D90FB6D911ABD7000F206DC9260759B2E0@zhk08exm40.ap.freescale.net>
From: Ho Jeffrey-r26191 <r26191@freescale.com>
To: "'Prashant Yendigeri'" <Prashant.Yendigeri@lntinfotech.com>, Kumar Gala
	<galak@kernel.crashing.org>
Subject: RE: Gianfar eth driver on 8540 ppc - for 2.4 and 2.6 : different
	outputs
Date: Sat, 12 Aug 2006 09:02:14 +0800
MIME-Version: 1.0
Content-Type: text/plain
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

Hi
 
>>>>[   34.041809] 0:00 not found 
SIOCSIFFLAGS: No[   34.044526] eth0: Could not attach to PHY 
 such device 
SIOCSIFFLAGS: No such device 
>>>>>  eth0: PHY is Generic MII (ffffffff)
_______________________________________________________
Can you quickly check if you have the right phy id written in your platform file for your board?

Regards, 
Jeffrey Ho 
Freescale Semiconductor HK Ltd 


 


________________________________

	From: linuxppc-embedded-bounces+r26191=freescale.com@ozlabs.org [mailto:linuxppc-embedded-bounces+r26191=freescale.com@ozlabs.org] On Behalf Of Prashant Yendigeri
	Sent: Friday, August 11, 2006 7:21 PM
	To: Kumar Gala
	Cc: linuxppc-embedded@ozlabs.org
	Subject: Re: Gianfar eth driver on 8540 ppc - for 2.4 and 2.6 : different outputs
	
	

	Hi, 
	
	Downloaded 2.6.16.26 and booted up and got this : 
	
	/ # ifconfig eth0 172.28.8.254 up 
	[   34.034596] 0:00 not found 
	[   34.037330] eth0: Could not attach to PHY 
	[   34.041809] 0:00 not found 
	SIOCSIFFLAGS: No[   34.044526] eth0: Could not attach to PHY 
	 such device 
	SIOCSIFFLAGS: No such device 
	
	I had enabled all the PHY devices in .config and also tried only with Marvell phy enabled. 
	
	Kernel boot messages : 
	[    2.296555] Gianfar MII Bus: probed 
	[    2.301789] eth0: Gianfar Ethernet Controller Version 1.2, 00:01:af:07:9b:8a 
	
	[    2.309039] eth0: Running with NAPI disabled 
	[    2.313307] eth0: 64/64 RX/TX BD ring size 
	[    2.318498] eth1: Gianfar Ethernet Controller Version 1.2, 00:00:00:00:72:6f 
	
	[    2.325738] eth1: Running with NAPI disabled 
	[    2.330006] eth1: 64/64 RX/TX BD ring size 
	[    2.335198] eth2: Gianfar Ethernet Controller Version 1.2, 6f:74:3d:2f:64:65 
	
	[    2.342377] eth2: Running with NAPI disabled 
	[    2.346662] eth2: 64/64 RX/TX BD ring size 
	[    2.351586] Marvell 88E1101: Registered new driver 
	[    2.357010] Davicom DM9161E: Registered new driver 
	[    2.362443] Davicom DM9131: Registered new driver 
	[    2.367775] Cicada Cis8204: Registered new driver 
	[    2.373136] LXT970: Registered new driver 
	[    2.377794] LXT971: Registered new driver 
	[    2.382461] QS6612: Registered new driver 
	
	
	Regards, 
	Prashant 
	
	
	
	
	
	
	Kumar Gala <galak@kernel.crashing.org> 

	08/11/2006 09:40 AM 

		
		To
		Prashant Yendigeri <Prashant.Yendigeri@lntinfotech.com> 
		cc
		linuxppc-embedded@ozlabs.org 
		Subject
		Re: Gianfar eth driver on 8540 ppc - for 2.4 and 2.6 : different outputs

		




	
	On Aug 10, 2006, at 6:18 AM, Prashant Yendigeri wrote:
	
	>
	> Hi,
	>
	> The gianfar driver of 2.6.12 and 2.4.20 give different outputs on  
	> the same PPC 8540 board.
	>
	> What could be the reason ?
	>
	> Output on 2.4.20 :
	> /root # ifconfig eth0 172.28.8.254 up
	> eth0: PHY is Marvell 88E1011S (1410c62)
	> eth0: Auto-negotiation done
	> eth0: Half Duplex
	> eth0: Speed 10BT
	> eth0: Link is up
	>
	> Output on 2.6.12
	> / # ifconfig eth0 172.28.8.254 up
	>  eth0: PHY is Generic MII (ffffffff)
	
	It looks like your 2.6.12 kernel isn't handling the PHY correctly.   
	I'd recommend upgrading to something newer which has the phylib  
	(can't remember which 2.6 that went into).
	
	- kumar
	
	______________________________________________________________________
	
	
	______________________________________________________________________
	
