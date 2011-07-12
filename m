Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 571ABB6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jul 2011 06:42:25 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p6CKZvNP002830
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2011 14:35:57 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p6CKfcMZ099736
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2011 14:41:38 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p6CEfbfT014300
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jul 2011 08:41:37 -0600
Date: Tue, 12 Jul 2011 16:41:56 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20110712204156.GD4203@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

A few fixes from Tony/Dave, a DTS update from Stefan, and a MAINTAINERS
update.

josh

The following changes since commit af9719c3062dfe216a0c3de3fa52be6d22b4456c:

  powerpc: Use -mtraceback=no (2011-07-01 13:49:27 +1000)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Dave Kleikamp (3):
      powerpc/44x: don't use tlbivax on AMP systems
      powerpc/44x: boot wrapper: allow kernel to load into non-zero address
      powerpc/47x: allow kernel to be loaded in higher physical memory

Josh Boyer (2):
      MAINTAINERS: Update PowerPC 4xx entry
      powerpc/4xx: Move PCIE printk to proper function

Stefan Roese (1):
      powerpc/44x: Use correct phy-address dt nodes on taishan.dts

Tony Breeds (1):
      powerpc/4xx: Add check_link to struct ppc4xx_pciex_hwops

 MAINTAINERS                                   |    2 +-
 arch/powerpc/Kconfig                          |    2 +-
 arch/powerpc/boot/dts/taishan.dts             |    4 +-
 arch/powerpc/boot/treeboot-iss4xx.c           |   23 ++++-
 arch/powerpc/configs/44x/iss476-smp_defconfig |    6 +-
 arch/powerpc/include/asm/mmu.h                |    7 +-
 arch/powerpc/kernel/head_44x.S                |   42 ++++++--
 arch/powerpc/kernel/setup_32.c                |    2 +
 arch/powerpc/mm/44x_mmu.c                     |   13 ++-
 arch/powerpc/mm/tlb_hash32.c                  |    4 +
 arch/powerpc/mm/tlb_nohash.c                  |   19 +++
 arch/powerpc/sysdev/ppc4xx_pci.c              |  147 ++++++++++++++-----------
 12 files changed, 186 insertions(+), 85 deletions(-)
