Return-Path: <Heinz.Wrobel@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id E63A52BF27
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Jan 2005 07:38:04 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01 [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	j04HC4fN021647
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Jan 2005 10:12:04 -0700 (MST)
Received: from zwg18exm01.ea.freescale.net (zwg18exm01.ea.freescale.net
	[10.170.73.30])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id j04HC36A018365
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Jan 2005 11:12:04 -0600 (CST)
Message-ID: <DF02D66C37C26B4C8018BF84F0E37FEC3AB842@zwg18exm01.ea.freescale.net>
From: Wrobel Heinz-r39252 <Heinz.Wrobel@freescale.com>
To: "'Wolfgang Denk'" <wd@denx.de>, Joakim.Tjernlund@lumentis.se
Date: Tue, 4 Jan 2005 18:07:20 +0100 
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: CPU15 errata workaround for 8xx by WD 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang, Joakim,
 
> I have to admit that I didn't believe our customer when  he  
> reported that  he has problems that were caused by the CPU15 
> bug - I never saw this on any other 8xx processor before, and 
> as you say  it  has  been mentioned  in  all errata sheets I 
> can remember. As far as I can tell it is only the MPC870/885 
> duet family of processors where this  CPU15 bug actually 
> hits. I have no idea why.

CPU15 is highly timing dependent. Even a single clock difference in the bus interface can make it (dis)appear.
It can happen on Duet's as on any other 8xx ... or not.

The simple workaround of invalidating the prev/next page is exactly that. Simple. It works, but for code with page locality it can hurt performance because you would get excessive reloads. A smarter workaround affecting only pages that need the workaround is preferrable, if it fits into the MMU table framework.

Heinz
