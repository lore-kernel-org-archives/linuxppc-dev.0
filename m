Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FB251A0015
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 12:14:45 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 23 Jun 2014 12:14:44 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9E8CE3578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 12:14:42 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5N1qRTD2294178
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 11:52:27 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5N2EfFe003449
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jun 2014 12:14:42 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 0/3] Support PCI Error Injection
Date: Mon, 23 Jun 2014 12:14:39 +1000
Message-Id: <1403489682-14841-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, qiudayu@linux.vnet.ibm.com, agraf@suse.de,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The series of patches supports PCI error injection as defined in PAPR spec.
There are 3 RTAS calls related to it:

"ibm,open-errinjct": Apply for token to do error injection
"ibm,close-errinjct": Free the token assigned previously
"ibm,errinjct": Do error injection

For PCI errors, we need manupulate 3 hardware registers by predetermined
OPAL API. In order to export the capability to userland, one OPAL firmware
related sysfs entries are created: /sys/firmware/opal/errinjct. It accepts
strings to call OPAL API to inject specific errors. So it corresponds to
"ibm,errinjct". So "ibm,open-errinjct" and "ibm,close-errinjct" won't be
handled by host kernel and applications have full freedom to implement logic
of themselves for them.

Gavin Shan (3):
  powerpc/powernv: Sync header with firmware
  powerpc/powernv: Support PCI error injection
  powerpc/powernv: Clear PAPR error injection registers

 arch/powerpc/include/asm/opal.h                |  66 +++++++++
 arch/powerpc/platforms/powernv/Makefile        |   2 +-
 arch/powerpc/platforms/powernv/eeh-ioda.c      |  24 ++++
 arch/powerpc/platforms/powernv/opal-errinjct.c | 184 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 arch/powerpc/platforms/powernv/opal.c          |   2 +
 6 files changed, 278 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/powernv/opal-errinjct.c

-- 
1.8.3.2
