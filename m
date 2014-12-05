Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F19DC1A0BCA
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Dec 2014 02:13:44 +1100 (AEDT)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Fri, 5 Dec 2014 15:13:40 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id E3F951B08067
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 15:13:56 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB5FDcOn46989380
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Dec 2014 15:13:38 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB5AATI2021852
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Dec 2014 05:10:30 -0500
Subject: [PATCH 2 0/4] powerpc: don't mess with SMT at boot time
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 05 Dec 2014 16:13:36 +0100
Message-ID: <20141205150405.11028.27445.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As requested by mpe, this series now covers both the smt-enabled
kernel parameter and the ibm,smt-enabled property. The cleanup was
split into 3 separate patches to ease review, but I guess they
could be folded into a single patch as well.

---

Greg Kurz (4):
      powerpc: drop the ability to tweak SMT mode at boot time
      powerpc: drop smt_enabled_at_boot
      powerpc: drop smp_generic_cpu_bootable()
      powerpc: drop the cpu_bootable hook


 arch/powerpc/include/asm/smp.h       |    3 --
 arch/powerpc/kernel/setup_64.c       |   61 +---------------------------------
 arch/powerpc/kernel/smp.c            |   16 +--------
 arch/powerpc/platforms/85xx/smp.c    |    1 -
 arch/powerpc/platforms/cell/smp.c    |    1 -
 arch/powerpc/platforms/powernv/smp.c |    1 -
 arch/powerpc/platforms/pseries/smp.c |    1 -
 7 files changed, 2 insertions(+), 82 deletions(-)

--
Greg
