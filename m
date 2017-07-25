Return-Path: <robherring2@gmail.com>
Received: from mail-yw0-f193.google.com (mail-yw0-f193.google.com
 [209.85.161.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHBbR2JBRzDqmC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 07:44:35 +1000 (AEST)
Received: by mail-yw0-f193.google.com with SMTP id u207so3655566ywc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 14:44:35 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 0/4] Removing full paths from DT full_name
Date: Tue, 25 Jul 2017 16:44:23 -0500
Message-Id: <20170725214427.25768-1-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series is the last steps to remove storing the full path for every 
DT node. Instead, we can create full path strings dynamically as needed 
with printf %pOF specifiers (commit ce4fecf1fe15). There are a number of 
remaining direct users of full_name after this series. I don't believe 
there should be any functional impact for those users with the change to 
only the node name (+unit-address). The majority are for struct 
resource.name. This should only affect /proc/iomem display.

Patches 1 and 2 can be applied now for 4.14. For patches 3 and 4, my 
target is 4.15 after all the dependencies have been merged.

PPC folks, Please test! The PPC parts are untested. A git branch with 
all the dependencies is here[1].

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dt-printf

Rob Herring (4):
  powerpc: pseries: vio: match parent nodes with of_find_node_by_path
  powerpc: pseries: remove dlpar_attach_node dependency on full path
  powerpc: pseries: only store the device node basename in full_name
  of/fdt: only store the device node basename in full_name

 arch/powerpc/platforms/pseries/dlpar.c       | 26 +++--------
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  2 +-
 arch/powerpc/platforms/pseries/mobility.c    |  2 +-
 arch/powerpc/platforms/pseries/pseries.h     |  2 +-
 arch/powerpc/platforms/pseries/reconfig.c    |  2 +-
 arch/powerpc/platforms/pseries/vio.c         |  4 +-
 drivers/of/fdt.c                             | 69 +++++-----------------------
 7 files changed, 23 insertions(+), 84 deletions(-)

-- 
2.11.0
