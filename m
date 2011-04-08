Return-Path: <ayman@elkhashab.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [207.114.241.63])
	by ozlabs.org (Postfix) with ESMTP id D6D63B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Apr 2011 04:34:56 +1000 (EST)
From: Ayman El-Khashab <ayman@elkhashab.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/1] ppc4xx: Fix PCIe scanning for the 460SX
Date: Fri,  8 Apr 2011 13:22:09 -0500
Message-Id: <1302286930-9988-1-git-send-email-ayman@elkhashab.com>
Cc: Ayman El-Khashab <ayman@elkhashab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ayman El-Khashab <ayman@elkhashab.com>

This patch is to fix the PCIe on the 460SX CPU.  As far as I can tell,
the 460SX must be using a different core than the previous 4xx SOCs.
The registers aren't the same and it appears DCRs that existed on 
previous parts don't exist on this one.  Perhaps somebody from AMCC 
can chime in.  In any case, the main problem was that the TX and RX
weren't enabled so nothing downstream from the RP was ever found.
And the check to set "port->link" would never work (as far as I could
tell).  I could not find any DCRs in this part to indicate when the
link was up and there isn't an obvious loopback, so the following
call would fail and result in no devices found.

ppc4xx_pciex_wait_on_sdr(port, PESDRn_LOOP, 1 << 28, 1 << 28, 100)

It would be better to detect the link status, but I don't see an
obvious way to do that from the data sheet.  U-boot just skips the
link check as well for this part.


Ayman El-Khashab (1):
  ppc4xx: Fix PCIe scanning for the 460SX

 arch/powerpc/sysdev/ppc4xx_pci.c |   35 +++++++++++++++++++++++++++++++----
 1 files changed, 31 insertions(+), 4 deletions(-)

-- 
1.7.4.3
