Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFF9F63@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Wolfgang Denk'" <wd@denx.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MPC8xx, FEC and DP83847 !? 
Date: Thu, 21 Mar 2002 13:55:44 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> In most cases you can just switch off the whole MDIO stuff  and  rely
> on  autonegotiation; the only thing you lose is a kernel message when
> the link status changes. Of course this requires sane hardware, which
> is not always the case :-(

On full duplex connections, we have experienced problems with
the kernel-level BOOTP/DHCP. The offer returned by the server was not
caught. After investigating, it appeared that even though the PHY
auto-negociated correctly, the FEC was not aware of the full duplex
condition. I had to fix it by correctly reading the duplex mode
from the PHY, since this information should be given to the FEC.

It may also cause a 'working but deficient' communication,
especially under heavy traffic, since the collision detection should
be disabled in full duplex.

--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
