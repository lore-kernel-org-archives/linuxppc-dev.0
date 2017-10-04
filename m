Return-Path: <clg@kaod.org>
Received: from 6.mo4.mail-out.ovh.net (6.mo4.mail-out.ovh.net [188.165.36.253])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6Vms0SRPzDqny
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 20:22:52 +1100 (AEDT)
Received: from player746.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 0672BC4640
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 11:15:16 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 0/2] powerpc/xive: fix CPU hot unplug
Date: Wed,  4 Oct 2017 11:15:03 +0200
Message-Id: <20171004091505.16776-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Recent commit eac1e731b59e ("powerpc/xive: guest exploitation of the
XIVE interrupt controller") introduced support for the XIVE
exploitation mode of the P9 interrupt controller on the pseries
platform.

At the time the patchset was sent, support for CPU removal was not
complete on PowerVM and only CPU hotplug was tested. To also support
CPU hot unplug, some cleanups of the XIVE internal structures are
needed. These two patches include the missing bits without which the
kernel crashes in a rtas call when a CPU is released.

There are still some corner cases to address when stressing the lpar
with plug/unplug loops. These are not necessarily Linux issues. Under
QEMU, it showed to be the decrementer waking the dying CPU. Under
phyp, it is much more rare and investigation is under progress.

Tested under a phyp and a XIVE QEMU model for pseries.

These changes should only impact the pseries platform. 

Thanks,

C.

Changes since v2 :

 - clarified commit log. 

Cédric Le Goater (2):
  powerpc/xive: fix IPI reset
  powerpc/xive: fix cpu removal

 arch/powerpc/sysdev/xive/common.c | 8 ++++++++
 arch/powerpc/sysdev/xive/spapr.c  | 4 ++++
 2 files changed, 12 insertions(+)

-- 
2.13.5
