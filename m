Return-Path: <lonsn2004@126.com>
Received: from m15-111.126.com (m15-111.126.com [220.181.15.111])
	by ozlabs.org (Postfix) with SMTP id 5833ADDD04
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Feb 2007 14:02:30 +1100 (EST)
Message-ID: <45D123A9.50805@126.com>
Date: Tue, 13 Feb 2007 10:34:17 +0800
From: Lonsn <lonsn2004@126.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: How to force the 1000M network interface work in 100M mode?(AMCC
	440GX, board based on ocotea)
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, all:
We have design a new board based on AMCC ocotea board. The linux kernel 
version we use is 2.6.18 from kernel.org. The network interface is the 
same as ocotea(eth0 and eth1 work in SMII mode, eth2 and eth3 work in 
RGMII mode).The 1000Mbit ehernet physical transceiver chip is also 
CIS8201(VSC8201). These pins(ANEG_DIS,FRC_DPLX,MODE10,MODE100,MODE1000) 
of CIS8201 are set as 01111.
Maybe because of the signal integrity problem of the gigabit 
clock&data,eth3 doesn't work in 1000M mode(eth2 is ok). If we connect 
eth3 with a host which has 100M ethernet, then eth3 works in 100M mode 
well. If we connect eth3 with a host which has 1000M ethernet interface, 
  then eth3 can recognize the link is 1000Mbit, but ping is not ok.
So we want to force the eth3 work in 100M mode even eth3 is connected 
with a 1000M host.(we think the hardware is ok when eth3 works in 100M 
mode).
We have used ethtool in the board and in the host to force the eth3 work 
in 100M mode, but failed. Maybe we can't change this setting in 
userspace? or we should changed the IBM_EMAC driver?
Any suggestions?

Thanks.

Lonsn
HDIC
