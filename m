Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id B8AC0DDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jun 2007 09:26:45 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Peter Korsgaard <jacmet@sunsite.dk>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-embedded@ozlabs.org
Subject: [PATCH 1/6] [C67x00] Add test of active flag when checking TDs
Date: Tue, 12 Jun 2007 17:02:16 -0600
Message-Id: <11816893494143-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11816893411272-git-send-email-grant.likely@secretlab.ca>
References: <11816893411272-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The active flag in a TD needs to be checked to determine whether or not
the TD was processed in the frame.  Without this check, the HCD assumes
the TD completed successfully, when in reality it was not processed at all.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/usb/c67x00/c67x00-sched.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
index 84b40a4..952bdab 100644
--- a/drivers/usb/c67x00/c67x00-sched.c
+++ b/drivers/usb/c67x00/c67x00-sched.c
@@ -1020,8 +1020,8 @@ static void check_td_list(struct c67x00_hcd *c67x00, struct pt_regs *regs)
 			goto cont;
 		}
 
-		if ((td->status & TD_STATUSMASK_NAK) || !td_sequence_ok(td) ||
-		    !td_acked(td))
+		if ((td->status & TD_STATUSMASK_NAK) ||
+		    !td_sequence_ok(td) || !td_acked(td) || td_active(td))
 			goto cont;
 
 		/* Sequence ok and acked, don't need to fix toggle */
-- 
1.4.4.2
