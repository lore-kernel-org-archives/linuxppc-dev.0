Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id DAE41474C8
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 12:30:08 +1100 (EST)
Date: Thu, 8 Jan 2009 04:30:06 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v5 0/2] MPC83xx PCI-E support
Message-ID: <20090108013006.GA31653@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Huang Changming <Chang-Ming.Huang@freescale.com>,
	Liu Dave <DaveLiu@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Here comes another revision...

Changes since v4:
- Corrected PCI-E ranges for MPC837x boards;
- On MPC837XE-MDS boards PCIE2 can be disabled in favour of PCIE1 x2 mode,
  in that case U-Boot disables PCIE2 via status property.
  So, of_device_is_available() check is placed into mpc83xx_add_bridge();
- Rebased on top of galak/powerpc.git next.

Changes since v3:
- TAL register programming changed per new reference manual for 83xx
  processors;
- dts files no longer specify config window in regs = <>. Instead, PCI-E
  code reads cfg window BAR to determine config space area;
- dts files no longer disable pcie nodes, now Linux detects unconfigured
  PCI-E controllers at run-time.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
