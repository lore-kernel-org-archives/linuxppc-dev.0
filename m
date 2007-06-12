Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id 5BBDDDDD0D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jun 2007 09:26:47 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Peter Korsgaard <jacmet@sunsite.dk>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-embedded@ozlabs.org
Subject: [PATCH 3/6] [C67x00] Remove unnecessary references to pt_regs
Date: Tue, 12 Jun 2007 17:02:18 -0600
Message-Id: <11816893493783-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11816893492706-git-send-email-grant.likely@secretlab.ca>
References: <11816893411272-git-send-email-grant.likely@secretlab.ca>
	<11816893494143-git-send-email-grant.likely@secretlab.ca>
	<11816893492706-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/usb/c67x00/c67x00-sched.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
index 0d08af7..3a870cf 100644
--- a/drivers/usb/c67x00/c67x00-sched.c
+++ b/drivers/usb/c67x00/c67x00-sched.c
@@ -956,7 +956,7 @@ static inline void clear_pipe(struct c67x00_hcd *c67x00,
 /* -------------------------------------------------------------------------- */
 
 static void handle_successful_td(struct c67x00_hcd *c67x00,
-				 struct c67x00_td *td, struct pt_regs *regs)
+				 struct c67x00_td *td)
 {
 	struct urb *urb = td->urb;
 
@@ -1025,7 +1025,7 @@ static void handle_isoc(struct c67x00_hcd *c67x00, struct c67x00_td *td)
  * check_td_list - handle tds which have been processed by the c67x00
  * pre: current_td == 0
  */
-static void check_td_list(struct c67x00_hcd *c67x00, struct pt_regs *regs)
+static void check_td_list(struct c67x00_hcd *c67x00)
 {
 	struct c67x00_td *td, *tmp;
 	struct urb *urb;
@@ -1070,7 +1070,7 @@ static void check_td_list(struct c67x00_hcd *c67x00, struct pt_regs *regs)
 		}
 
 		clear_endpoint = 0;
-		handle_successful_td(c67x00, td, regs);
+		handle_successful_td(c67x00, td);
 
 	      cont:
 		if (clear_endpoint)
@@ -1132,7 +1132,7 @@ static void c67x00_do_work(struct c67x00_hcd *c67x00)
 	if (!all_tds_processed(c67x00))
 		goto out;
 
-	check_td_list(c67x00, NULL);
+	check_td_list(c67x00);
 
 	/* no td's are being processed (current == 0)
 	 * and all have been "checked" */
-- 
1.4.4.2
