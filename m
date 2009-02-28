Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id BF606DDDF6
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Mar 2009 07:46:28 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1039791ywb.39
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Feb 2009 12:46:27 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] Fix Xilinx SystemACE driver to handle empty CF slot
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, John.Linn@xilinx.com,
	sr@denx.de
Date: Sat, 28 Feb 2009 13:46:22 -0700
Message-ID: <20090228204622.29719.55082.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The SystemACE driver does not handle an empty CF slot gracefully.  An
empty CF slot ends up hanging the system.  This patch adds a check for
the CF state and stops trying to process requests if the slot is empty.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/block/xsysace.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)


diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 381d686..ec5b8ca 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -489,6 +489,28 @@ static void ace_fsm_dostate(struct ace_device *ace)
 		ace->fsm_state, ace->id_req_count);
 #endif
 
+	/* Verify that there is actually a CF in the slot.  If not, then
+	 * bail out back to the idle state and wake up all the waiters */
+	status = ace_in32(ace, ACE_STATUS);
+	if ((status & ACE_STATUS_CFDETECT) == 0) {
+		ace->fsm_state = ACE_FSM_STATE_IDLE;
+		ace->media_change = 1;
+		set_capacity(ace->gd, 0);
+		dev_info(ace->dev, "No CF in slot\n");
+ 
+		/* Drop all pending requests */
+		while ((req = elv_next_request(ace->queue)) != NULL)
+			end_request(req, 0);
+
+		/* Drop back to IDLE state and notify waiters */
+		ace->fsm_state = ACE_FSM_STATE_IDLE;
+		ace->id_result = -EIO;
+		while (ace->id_req_count) {
+			complete(&ace->id_completion);
+			ace->id_req_count--;
+		}
+	}
+
 	switch (ace->fsm_state) {
 	case ACE_FSM_STATE_IDLE:
 		/* See if there is anything to do */
