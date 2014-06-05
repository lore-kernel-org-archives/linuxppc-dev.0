Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BE271A09B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 01:24:50 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Fri, 6 Jun 2014 01:24:48 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A2C952BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 01:24:45 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s55FOTjA4784494
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 01:24:29 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s55FOik4021679
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jun 2014 01:24:45 +1000
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/2] powerpc/powernv : Disable subcore for UP configs
Date: Thu,  5 Jun 2014 20:54:28 +0530
Message-Id: <1401981868-4108-1-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1401981695-3682-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1401981695-3682-1-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Build throws following errors when CONFIG_SMP=n
arch/powerpc/platforms/powernv/subcore.c: In function ‘cpu_update_split_mode’:
arch/powerpc/platforms/powernv/subcore.c:274:15: error: ‘setup_max_cpus’ undeclared (first use in this function)
arch/powerpc/platforms/powernv/subcore.c:285:5: error: lvalue required as left operand of assignment

'setup_max_cpus' variable is relevant only on SMP, so there is no point
working around it for UP. Furthermore, subcore.c itself is relevant only
on SMP and hence the better solution is to exclude subcore.c for UP builds.

Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
This patch applies on top of ben/powerpc.git/next branch

 arch/powerpc/platforms/powernv/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 4ad0d34..636d206 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -1,9 +1,9 @@
 obj-y			+= setup.o opal-takeover.o opal-wrappers.o opal.o opal-async.o
 obj-y			+= opal-rtc.o opal-nvram.o opal-lpc.o opal-flash.o
 obj-y			+= rng.o opal-elog.o opal-dump.o opal-sysparam.o opal-sensor.o
-obj-y			+= opal-msglog.o subcore.o subcore-asm.o
+obj-y			+= opal-msglog.o subcore-asm.o
 
-obj-$(CONFIG_SMP)	+= smp.o
+obj-$(CONFIG_SMP)	+= smp.o subcore.o
 obj-$(CONFIG_PCI)	+= pci.o pci-p5ioc2.o pci-ioda.o
 obj-$(CONFIG_EEH)	+= eeh-ioda.o eeh-powernv.o
 obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
-- 
1.9.0
