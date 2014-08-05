Return-Path: <vmansur@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8FB101A0148
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 00:35:53 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vmansur@linux.vnet.ibm.com>;
 Tue, 5 Aug 2014 20:05:51 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 774F11258018
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 20:05:52 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s75EZjSx39714830
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Aug 2014 20:05:45 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s75EZlJj008628
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Aug 2014 20:05:48 +0530
Message-ID: <53E0EBBD.5080506@linux.vnet.ibm.com>
Date: Tue, 05 Aug 2014 20:05:41 +0530
From: Vishal Mansur <vmansur@linux.vnet.ibm.com>
MIME-Version: 1.0
To: shangw@linux.vnet.ibm.com, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: non-GPL export for eeh_dev_check_failure
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

EEH kernel services are inconsistently exported by the 
kernel. eeh_check_failure is exported for any use, but 
eeh_dev_check_failure is exported only for GPL use. 
While eeh_check_failure is implemented for a specific 
purpose to be used by services such as readl, it is 
not suited for a purpose where caller needs eeh status. 
This functionality is provided by eeh_dev_check_failure.

This patch relaxes the export for eeh_dev_check_failure
to make it consistent with eeh_check_failure() and 
usable by non-GPL modules.

Signed-off-by: Vishal Mansur <vmansur@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 86e2570..8689c30 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -496,8 +496,7 @@ dn_unlock:
        eeh_serialize_unlock(flags);
        return rc;
 }
-
-EXPORT_SYMBOL_GPL(eeh_dev_check_failure);
+EXPORT_SYMBOL(eeh_dev_check_failure);

 /**
  * eeh_check_failure - Check if all 1's data is due to EEH slot freeze
--
2.0.1
