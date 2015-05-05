Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 025131A114B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 18:06:46 +1000 (AEST)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C4686140788
 for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2015 18:06:45 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 5 May 2015 18:06:44 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DCDD8357804F
 for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2015 18:06:41 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4586X3v42991856
 for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2015 18:06:41 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t45869CE004900
 for <linuxppc-dev@ozlabs.org>; Tue, 5 May 2015 18:06:09 +1000
Subject: [PATCH v2 2/2] powerpc/powernv: Pull all HMI events before panic.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 05 May 2015 13:35:43 +0530
Message-ID: <20150505080529.513.66351.stgit@mars.in.ibm.com>
In-Reply-To: <20150505080431.513.69688.stgit@mars.in.ibm.com>
References: <20150505080431.513.69688.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

In the event of unrecovered HMI the existing code panics as soon as
it receives the first unrecovered HMI event. This makes host to report
partial information about HMIs before panic. There may be more errors
which would have caused the HMI and hence more HMI event would have been
generated waiting to be pulled by host. This patch implements a logic to
pull and display all the HMI event before going down panic path.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/opal-hmi.c |   26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
index 2668225..26e0f3f 100644
--- a/arch/powerpc/platforms/powernv/opal-hmi.c
+++ b/arch/powerpc/platforms/powernv/opal-hmi.c
@@ -235,6 +235,8 @@ static void hmi_event_handler(struct work_struct *work)
 	struct OpalHMIEvent *hmi_evt;
 	struct OpalHmiEvtNode *msg_node;
 	uint8_t disposition;
+	struct opal_msg msg;
+	int unrecoverable = 0;
 
 	spin_lock_irqsave(&opal_hmi_evt_lock, flags);
 	while (!list_empty(&opal_hmi_evt_list)) {
@@ -250,14 +252,34 @@ static void hmi_event_handler(struct work_struct *work)
 
 		/*
 		 * Check if HMI event has been recovered or not. If not
-		 * then we can't continue, invoke panic.
+		 * then kernel can't continue, we need to panic.
+		 * But before we do that, display all the HMI event
+		 * available on the list and set unrecoverable flag to 1.
 		 */
 		if (disposition != OpalHMI_DISPOSITION_RECOVERED)
-			panic("Unrecoverable HMI exception");
+			unrecoverable = 1;
 
 		spin_lock_irqsave(&opal_hmi_evt_lock, flags);
 	}
 	spin_unlock_irqrestore(&opal_hmi_evt_lock, flags);
+
+	if (unrecoverable) {
+		/* Pull all HMI events from OPAL before we panic. */
+		while (opal_get_msg(__pa(&msg), sizeof(msg)) == OPAL_SUCCESS) {
+			u32 type;
+
+			type = be32_to_cpu(msg.msg_type);
+
+			/* skip if not HMI event */
+			if (type != OPAL_MSG_HMI_EVT)
+				continue;
+
+			/* HMI event info starts from param[0] */
+			hmi_evt = (struct OpalHMIEvent *)&msg.params[0];
+			print_hmi_event_info(hmi_evt);
+		}
+		panic("Unrecoverable HMI exception");
+	}
 }
 
 static DECLARE_WORK(hmi_event_work, hmi_event_handler);
