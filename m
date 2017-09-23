Return-Path: <clg@kaod.org>
Received: from 2.mo179.mail-out.ovh.net (2.mo179.mail-out.ovh.net
 [178.33.250.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xzkVQ0H3ZzDqR8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Sep 2017 18:46:53 +1000 (AEST)
Received: from player794.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 6138764212
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Sep 2017 10:27:36 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 0/2] powerpc/xive: fix CPU hot unplug
Date: Sat, 23 Sep 2017 10:26:54 +0200
Message-Id: <20170923082656.27219-1-clg@kaod.org>
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

Here are a couple of small fixes to support CPU hot unplug. There are
still some issues to be investigated as, in some occasions, after a
couple of plug and unplug, the cpu which was removed receives a 'lost'
interrupt. This showed to be the decrementer under QEMU.

Nevertheless, these patches are required and provide a significant
improvement to support CPU removal.

Tested under a phyp and a XIVE QEMU model for pseries.

Thanks,

C.

Cédric Le Goater (2):
  powerpc/xive: fix IPI reset
  powerpc/xive: fix cpu removal

 arch/powerpc/sysdev/xive/common.c | 8 ++++++++
 arch/powerpc/sysdev/xive/spapr.c  | 4 ++++
 2 files changed, 12 insertions(+)

-- 
2.13.5
