Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D28672C00C9
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 16:38:10 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 00:38:08 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id B4BD16E8040
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:37:59 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1P5c48S60686578
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 05:38:04 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1P5c4RR018308
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:38:04 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 0/9] EEH improvement
Date: Tue, 25 Feb 2014 13:37:41 +0800
Message-Id: <1393306670-17435-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series of patches intends to improve reliability of EEH on PowerNV
platform. First all, we have had multiple duplicate states (flags) for
PHB and PE, so we remove those duplicate states to simplify the code.
Besides, we had corrupted PHB diag-data for case of frozen PE. In order
to solve the problem, we introduce eeh_ops->event() and notifications
are sent from EEH core to (PowerNV) platform on creating or destroying
PE instance so that we can allocate or free PHB diag-data backend. Then
we cache the PHB diag-data on the first call to eeh_ops->get_state()
and dump it afterwards, which helps to get correct PHB diag-data.

With the patchset applied, we never dump PHB diag-data for INF errors.
Instead, we just maintain statistics in /proc/powerpc/eeh_inf_err. Also,
we changed the PHB diag-data dump format for a bit to have multiple
fields per line and omits the line with all zero'd fields as Ben suggested.


v1 -> v2:
	* Amending commit logs
	* Support eeh_ops->event() and maintain PHB diag-data on basis
	  of PE instance
	* When dumping PHB diag-data, to replace "-" with "00000000" and
	  omit the line if the fields of it are all zeros.

---

arch/powerpc/include/asm/eeh.h               |    7 ++-
arch/powerpc/kernel/eeh.c                    |   10 +---
arch/powerpc/kernel/eeh_driver.c             |   10 ++--
arch/powerpc/kernel/eeh_pe.c                 |   39 ++++++++++++-
arch/powerpc/platforms/powernv/eeh-ioda.c    |  193 ++++++++++++++++++++++++++++++++++++-------------------------
arch/powerpc/platforms/powernv/eeh-powernv.c |   74 +++++++++++++++++++-----
arch/powerpc/platforms/powernv/pci.c         |  228 +++++++++++++++++++++++++++++++++++++++++-------------------------
arch/powerpc/platforms/powernv/pci.h         |   11 ++--
arch/powerpc/platforms/pseries/eeh_pseries.c |    3 +-
9 files changed, 358 insertions(+), 217 deletions(-)

Thanks,
Gavin
