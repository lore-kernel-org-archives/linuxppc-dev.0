Return-Path: <ALEBAS@televes.com>
Received: from mailext.televes.com (unknown [212.163.42.136])
	by ozlabs.org (Postfix) with ESMTP id 8F77867A01
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 May 2005 16:26:28 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mailext.televes.com (Postfix) with ESMTP id 48E36327FA8
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 May 2005 08:40:57 +0200 (CEST)
Received: from mailext.televes.com ([127.0.0.1])
	by localhost (mailext [127.0.0.1]) (amavisd-new, port 10024) with SMTP
	id 15660-09 for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 May 2005 08:40:57 +0200 (CEST)
Received: from televes.com (unknown [212.163.42.137])
	by mailext.televes.com (Postfix) with SMTP id 0BA75327F6B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 May 2005 08:40:57 +0200 (CEST)
Message-ID: <51DB8827D393D411BB69003048003F4601B1C1EF@tvesntr>
From: Bastos Fernandez Alexandre <ALEBAS@televes.com>
To: 'Ole Andreas Torvmark' <ole.torvmark@radionor.no>
Date: Tue, 3 May 2005 08:24:13 +0200 
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Ethernet bridging on MPC8248
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Ole,

Maybe those mails from archives would answer your questions. As long as
I know this is still present in kernel:

http://ozlabs.org/pipermail/linuxppc-embedded/2004-October/015617.html
http://ozlabs.org/pipermail/linuxppc-embedded/2004-October/015620.html

So, you have to change set_multicast_list to support the promiscous mode
needed by your bridge.

Best regards,

Alex.

> -----Original Message-----
> From:	Ole Andreas Torvmark [SMTP:ole.torvmark@radionor.no]
> Sent:	Monday, May 02, 2005 11:28 AM
> To:	linuxppc-embedded@ozlabs.org
> Subject:	Ethernet bridging on MPC8248
> 
> Hi !
> 
> I've a custom board with a MPC8248 with two LXT972 10/100MBit ethernet
> phys.
> 
> The board is running 2.6.9-rc1, and I'm using the FCC ENET Version 0.3 
> driver with some modifications.
> 
> My question is :
> 
> I've tried to get ethernet briding between the two ethernet ports to work.
> 
> I've set up the following :
> 
> ifconfig eth0 0.0.0.0
> ifconfig eth1 0.0.0.0
> brctl addbr br0
> brctl addif br0 eth0
> brctl addif br0 eth1
> ifconfig br0 192.168.0.222 netmask 255.255.255.0
> 
> If I connect a machine to port 0 (eth0) then I can ping the bridge from 
> that machine,
> If I connect a machine to port 1 (eth1) I cannot ping the bridge.
> If I connect machines to both ports, I cannot ping one machine from the 
> other, the only thing i can successfully ping is from port 0 to bridge 
> and from bridge to port 0
> 
> Is this a known problem with the FCC ENET driver or does it support 
> bridging fully ?
> 
> best regards
> 
> Ole Andreas Torvmark
> R & D Engineer
> Radionor Communications AS
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
