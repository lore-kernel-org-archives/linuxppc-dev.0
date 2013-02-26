Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C0FDD2C0292
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 14:43:45 +1100 (EST)
Message-ID: <512C2F5D.1080207@asianux.com>
Date: Tue, 26 Feb 2013 11:43:25 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Jiri Slaby <jslaby@suse.cz>, wfp5p@virginia.edu, tklauser@distanz.ch
Subject: [PATCH] drivers/tty/hvc: using strlcpy instead of strncpy
Content-Type: text/plain; charset=GB2312
Cc: Greg KH <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 alan@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


  when strlen pi->location_code is larger than HVCS_CLC_LENGTH + 1,
    original implementation can not let hvcsd->p_location_code NUL terminated.
  so need fix it (also can simplify the code)

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 drivers/tty/hvc/hvcs.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index 1956593..81e939e 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -881,17 +881,12 @@ static struct vio_driver hvcs_vio_driver = {
 /* Only called from hvcs_get_pi please */
 static void hvcs_set_pi(struct hvcs_partner_info *pi, struct hvcs_struct *hvcsd)
 {
-	int clclength;
-
 	hvcsd->p_unit_address = pi->unit_address;
 	hvcsd->p_partition_ID  = pi->partition_ID;
-	clclength = strlen(&pi->location_code[0]);
-	if (clclength > HVCS_CLC_LENGTH)
-		clclength = HVCS_CLC_LENGTH;
 
 	/* copy the null-term char too */
-	strncpy(&hvcsd->p_location_code[0],
-			&pi->location_code[0], clclength + 1);
+	strlcpy(&hvcsd->p_location_code[0],
+			&pi->location_code[0], sizeof(hvcsd->p_location_code));
 }
 
 /*
-- 
1.7.7.6
