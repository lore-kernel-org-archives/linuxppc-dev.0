Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B4FDA2C0142
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 18:28:55 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 00:28:53 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id C32B319D8041
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:28:48 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1P7SOep3015148
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 08:28:24 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1P7SnIC017928
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Feb 2014 00:28:50 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 0/5] EEH improvement
Date: Tue, 25 Feb 2014 15:28:33 +0800
Message-Id: <1393313318-6341-1-git-send-email-shangw@linux.vnet.ibm.com>
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

v2 -> v3:
	* We don't cache the PHB diag-data, instead we just grab and
	  dump PHB diag-data on the first catch-up to avoid broken
	  PHB diag-data.
v1 -> v2:
	* Amending commit logs
	* Support eeh_ops->event() and maintain PHB diag-data on basis
	  of PE instance
	* When dumping PHB diag-data, to replace "-" with "00000000" and
	  omit the line if the fields of it are all zeros.

---

arch/powerpc/include/asm/eeh.h            |    1 -
arch/powerpc/kernel/eeh.c                 |   10 +---
arch/powerpc/kernel/eeh_driver.c          |   10 ++--
arch/powerpc/platforms/powernv/eeh-ioda.c |  137 ++++++++++++++++++++--------------------------
arch/powerpc/platforms/powernv/pci.c      |  228 ++++++++++++++++++++++++++++++++++++++++++---------------------------
arch/powerpc/platforms/powernv/pci.h      |    8 +--
6 files changed, 195 insertions(+), 199 deletions(-)

Thanks,
Gavin
