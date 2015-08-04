Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11B8A1A0748
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 21:19:19 +1000 (AEST)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6A529140295
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Aug 2015 21:19:18 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 4 Aug 2015 16:49:16 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6BBE2E0060
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Aug 2015 16:53:27 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t74BIwLg53346352
 for <linuxppc-dev@ozlabs.org>; Tue, 4 Aug 2015 16:48:59 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t74BIvun028128
 for <linuxppc-dev@ozlabs.org>; Tue, 4 Aug 2015 16:48:57 +0530
Subject: [PATCH] powernv: Invoke opal_cec_reboot2() on unrecoverable HMI.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>
Date: Tue, 04 Aug 2015 16:48:56 +0530
Message-ID: <20150804111855.9750.86630.stgit@mars>
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

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Invoke new opal_cec_reboot2() call with reboot type
OPAL_REBOOT_PLATFORM_ERROR (for unrecoverable HMI interrupts) to inform
BMC/OCC about this error, so that BMC can collect relevant data for error
analysis and decide what component to de-configure before rebooting.

This patch depends on:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-May/128341.html
https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-May/128342.html
https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-August/132045.html

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-hmi.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
index acefdf9..d000f4e 100644
--- a/arch/powerpc/platforms/powernv/opal-hmi.c
+++ b/arch/powerpc/platforms/powernv/opal-hmi.c
@@ -264,6 +264,8 @@ static void hmi_event_handler(struct work_struct *work)
 	spin_unlock_irqrestore(&opal_hmi_evt_lock, flags);
 
 	if (unrecoverable) {
+		int ret;
+
 		/* Pull all HMI events from OPAL before we panic. */
 		while (opal_get_msg(__pa(&msg), sizeof(msg)) == OPAL_SUCCESS) {
 			u32 type;
@@ -278,6 +280,23 @@ static void hmi_event_handler(struct work_struct *work)
 			hmi_evt = (struct OpalHMIEvent *)&msg.params[0];
 			print_hmi_event_info(hmi_evt);
 		}
+
+		/*
+		 * Unrecoverable HMI exception. We need to inform BMC/OCC
+		 * about this error so that it can collect relevant data
+		 * for error analysis before rebooting.
+		 */
+		ret = opal_cec_reboot2(OPAL_REBOOT_PLATFORM_ERROR,
+			"Unrecoverable HMI exception");
+		if (ret == OPAL_UNSUPPORTED) {
+			pr_emerg("Reboot type %d not supported\n",
+						OPAL_REBOOT_PLATFORM_ERROR);
+		}
+
+		/*
+		 * Fall through and panic if opal_cec_reboot2() returns
+		 * OPAL_UNSUPPORTED.
+		 */
 		panic("Unrecoverable HMI exception");
 	}
 }
