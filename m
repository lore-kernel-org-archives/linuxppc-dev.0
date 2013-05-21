Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 929B82C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 04:44:30 +1000 (EST)
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Subject: [PATCH 1/2] drivers/macintosh: Remove obsolete cleanup for clientdata
Date: Tue, 21 May 2013 20:45:40 +0200
Message-Id: <1369161945-26671-1-git-send-email-wsa@the-dreams.de>
Cc: linuxppc-dev@lists.ozlabs.org, Wolfram Sang <wsa@the-dreams.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A few new i2c-drivers came into the kernel which clear the clientdata-pointer
on exit or error. This is obsolete meanwhile, the core will do it.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/macintosh/windfarm_smu_sat.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index d87f5ee..ad6223e 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -343,7 +343,6 @@ static int wf_sat_remove(struct i2c_client *client)
 		wf_unregister_sensor(&sens->sens);
 	}
 	sat->i2c = NULL;
-	i2c_set_clientdata(client, NULL);
 	kref_put(&sat->ref, wf_sat_release);
 
 	return 0;
-- 
1.7.10.4
