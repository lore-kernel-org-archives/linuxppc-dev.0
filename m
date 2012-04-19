Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E0B38B6F62
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:20:22 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Thu, 19 Apr 2012 08:10:53 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3J8DDgn1888272
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:13:13 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3J8JnPp004485
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:19:50 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/15] powerpc/windfarm: Improve display of fan speeds in sysfs
Date: Thu, 19 Apr 2012 18:16:50 +1000
Message-Id: <1334823416-9138-10-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
Cc: khali@linux-fr.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Controls registered as RPM and PWM fans are now displayed
with the "RPM" or "%" suffix respectively to make it
clearer to the user what the value actually means since
the fan type isn't otherwise obvious.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/macintosh/windfarm_core.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/macintosh/windfarm_core.c b/drivers/macintosh/windfarm_core.c
index ce88979..ebafc25 100644
--- a/drivers/macintosh/windfarm_core.c
+++ b/drivers/macintosh/windfarm_core.c
@@ -164,13 +164,24 @@ static ssize_t wf_show_control(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct wf_control *ctrl = container_of(attr, struct wf_control, attr);
+	const char *typestr;
 	s32 val = 0;
 	int err;
 
 	err = ctrl->ops->get_value(ctrl, &val);
 	if (err < 0)
 		return err;
-	return sprintf(buf, "%d\n", val);
+	switch(ctrl->type) {
+	case WF_CONTROL_RPM_FAN:
+		typestr = " RPM";
+		break;
+	case WF_CONTROL_PWM_FAN:
+		typestr = " %";
+		break;
+	default:
+		typestr = "";
+	}
+	return sprintf(buf, "%d%s\n", val, typestr);
 }
 
 /* This is really only for debugging... */
-- 
1.7.9.5
