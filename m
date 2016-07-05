Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBdN4z6jzDqpc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:04:40 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBdJ2r5Rz9s9G
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:04:35 +1000 (AEST)
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id u6554JNW006480
 for <linuxppc-dev@ozlabs.org>; Tue, 5 Jul 2016 00:04:23 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 00/41] Reorganize setup code and merge 32 and 64-bit
 setup_arch()
Date: Tue,  5 Jul 2016 15:03:36 +1000
Message-Id: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
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

Note: The first 2 patches could go separately. The first one is a pre
requisite for the ppc32 move of probe_machine(). The second one a general
bug fix for recent kernels which I included here so my test kernels
could build but the rest of the series doesn't depend on it.

Finally I added a few more random build fixes at the end.
