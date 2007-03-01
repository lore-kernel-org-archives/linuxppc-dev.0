Return-Path: <jan-hinnerk.dumjahn@arcor.de>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6D881DDE28
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 22:17:08 +1100 (EST)
Received: from mail-in-01-z2.arcor-online.net (mail-in-06-z2.arcor-online.net
	[151.189.8.18])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id F250331E73E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 12:17:01 +0100 (CET)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id E588D5C169
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 12:17:01 +0100 (CET)
Received: from [192.168.1.51] (pD95FF380.dip.t-dialin.net [217.95.243.128])
	(Authenticated sender: jan-hinnerk.dumjahn@arcor.de)
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id BE550292B62
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 12:17:01 +0100 (CET)
From: Jan-Hinnerk Dumjahn <jan-hinnerk.dumjahn@arcor.de>
To: linuxppc-embedded@ozlabs.org
Subject: Problems with PHY on STK5200
Date: Thu, 1 Mar 2007 12:16:57 +0100
MIME-Version: 1.0
Message-Id: <200703011216.57611.jan-hinnerk.dumjahn@arcor.de>
Content-Type: text/plain;
  charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm trying to compile a recent kernel from DENX "linuxppc_2_4_devel" for my 
STK5200 using ELDK 3.1.1.

It seems that the current kernel there is not configuring the PHY. It looks 
like the link is configured for full-duplex (although it should be configured 
half-duplex).
There is no informative output about the PHY after the line

eth0: Phy @ 0x0, type LXT971 (0x001378e2)

-------

I have traced this change of behaviour back to a commit on 2005-09-04 
22:41:06. This is a major restructuring/rework of the file 
"arch/ppc/5xxx_io/fec.c".

BTW: What is the normal way to reference a commit in a git-repository? I 
haven't seen any revision numbers.

The versions also show different program flow (with MPC5xxx_FEC_DEBUG set to 
2).
The old version goes:
- mpc5xxx_fec_init()
- mpc5xxx_fec_restart()
  - PHY gets identified here
- mpc5xxx_fec_open()
  - autonegotiation here
- mpc5xxx_fec_restart()

The new one goes
- mpc5xxx_fec_init()
- mpc5xxx_fec_open()
- mpc5xxx_fec_restart()
  - PHY gets identified here


The new version has some bad (or at least dead) code in the funtion 
mpc5xxx_fec_setup(). However, I don't understand enough of the drivers design 
to see how to fix this.

Can anybody explain what the driver should to? Or even better has some patch 
to make it work?

Thanks in advance
/Jan-Hinnerk Dumjahn
