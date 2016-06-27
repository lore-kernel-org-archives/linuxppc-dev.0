Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdRYS6XFvzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:29:48 +1000 (AEST)
Received: from pasglop.au.ibm.com (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id u5RBTgqa021158
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 06:29:43 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 00/38] Reorganize setup code and merge 32 and 64-bit
 setup_arch()
Date: Mon, 27 Jun 2016 21:28:58 +1000
Message-Id: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series reorganizes the setup code, moving probe_machine() later than
when it's currently done, and sync'ing 32-bit and 64-bit enough to merge
their implementations of setup_arch(). We get rid of ppc64 setup_system()
which is subsumed by the new setup_arch().

Note: The first 2 patches should go separately. The first one is a pre
requisite for the ppc32 move of probe_machine(). The second one a general
bug fix for recent kernels which I included here so my test kernels
could build.

I test built all ppc64 platforms and the STD_MMU ppc32 ones. I test
booted pseries and powermac in qemu.
