Return-Path: <DaveLiu@freescale.com>
Received: from az33egw01.freescale.net (unknown [192.88.158.102])
	by ozlabs.org (Postfix) with ESMTP id 730A6679E0
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Jun 2006 07:47:43 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k55AsRov011539
	for <linuxppc-embedded@ozlabs.org>; Mon, 5 Jun 2006 03:54:27 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k55AXmbg016830
	for <linuxppc-embedded@ozlabs.org>; Mon, 5 Jun 2006 05:33:50 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673026FD93F@zch01exm40.ap.freescale.net>
From: Liu Dave-r63238 <DaveLiu@freescale.com>
To: "'Martin, Tim'" <tim.martin@viasat.com>, linuxppc-embedded@ozlabs.org
Subject: RE: MPC85xx PCI transfer disconnect
Date: Mon, 5 Jun 2006 18:33:45 +0800 
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 
> After scaning more logic analyzer captures, I noticed that 
> occasionally the MPC85xx inserts additional wait states (by 
> deasserting TRDY#) after only 32 bytes have been transferred. 
>  So it definitely appears that (the way I have things 
> configured now) there's a 20-80ns delay after 1 cache line is 
> read, and the MPC85xx disconnects transfers that are larger 
> than 2 cache lines.
> 

There is one description about MRM cmd in the MPC85xx user manual.
[Memory read multiple] 
Similar to the memory-read command, but also causes a
prefetch of the next cache line (32 bytes).

How many masters in your PCI system? 
Maybe, you can tune the master latency timer of Tsi148 to get more bandwidth.
The latecy timer is locate at configuration space of your master.

Dave
