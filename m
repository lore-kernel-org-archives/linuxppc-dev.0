Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 69F151A0128
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 19:11:37 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 21 Oct 2014 18:11:36 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 35D6B2CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 19:11:33 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9L8DXFg31391782
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 19:13:34 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9L8BWc5013658
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 19:11:32 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc,
 pseries: All events of EPOW_SYSTEM_SHUTDOWN must initiate shutdown
Date: Tue, 21 Oct 2014 13:41:29 +0530
Message-Id: <1413879089-1485-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current handling of EPOW_SHUTDOWN_ON_UPS event does not shutdown the
system after logging the message. All the events of EPOW_SYSTEM_SHUTDOWN
action code (EPOW_SHUTDOWN_ON_UPS is a part of it) must initiate system
shutdown as per the SPAPR spec. If the LPAR does not shutdown after
receiving this rtas based event, it will expose itself to a forced abrupt
shutdown initiated by the platform firmware. This patch fixes the situation.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/ras.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 5a4d0fc..b46cab8 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -89,6 +89,8 @@ static void handle_system_shutdown(char event_modifier)
 	case EPOW_SHUTDOWN_ON_UPS:
 		pr_emerg("Loss of power reported by firmware, system is "
 			"running on UPS/battery");
+		pr_emerg("Check RTAS error log for details");
+		orderly_poweroff(true);
 		break;
 
 	case EPOW_SHUTDOWN_LOSS_OF_CRITICAL_FUNCTIONS:
-- 
1.9.3
