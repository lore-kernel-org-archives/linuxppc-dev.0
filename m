Return-Path: <ayman@elkhashab.com>
Received: from tanisys-ex2.Tanisys.Local (mail.tanisys.com [207.114.241.63])
	by ozlabs.org (Postfix) with ESMTP id 639D1B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Jul 2011 10:45:54 +1000 (EST)
From: Ayman El-Khashab <ayman@elkhashab.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Tony Breeds <tony@bakeyournoodle.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] powerpc/4xx: enable and fix pcie gen1/gen2 on the 460sx
Date: Wed, 13 Jul 2011 19:33:30 -0500
Message-Id: <1310603611-8960-1-git-send-email-ayman@elkhashab.com>
In-Reply-To: <y>
References: <y>
Cc: Ayman El-Khashab <ayman@elkhashab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Old code didn't check the proper registers for the 460sx and so the link check
would always fail.  This changes the link check to use the config space reg and
adds the definition for the register.  Also changes the vc0 to a pll check.  
Sets up the port for gen2 speeds.

This uses the check_link function to specialize the link detect for the 460sx.
Tested on an eiger and custom board.  Note that is swaps the order of the link
check and dcr initialization since the config space needs the DCRs setup before
it can be mapped and used to check the link.


Ayman El-Khashab (1):
  powerpc/4xx: enable and fix pcie gen1/gen2 on the 460sx

 arch/powerpc/sysdev/ppc4xx_pci.c |   83 +++++++++++++++++++++++++++++--------
 arch/powerpc/sysdev/ppc4xx_pci.h |    3 +
 2 files changed, 68 insertions(+), 18 deletions(-)

-- 
1.7.4.3
