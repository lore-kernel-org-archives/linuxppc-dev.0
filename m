Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 41C9CB6FC9
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:41:24 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Thu, 19 Apr 2012 08:02:54 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3J8JnfL31588596
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:19:49 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3J8Jmwd008292
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 18:19:49 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/15] powerpc/windfarm: const'ify and add "priv" field to
 controls & sensors
Date: Thu, 19 Apr 2012 18:16:47 +1000
Message-Id: <1334823416-9138-7-git-send-email-benh@kernel.crashing.org>
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

const'ify the sensor ops and name and add a void* for use by
the control and sensor drivers to point back to their private
data, avoiding the need to create a wrapper data structure
per sensor or control instance.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/macintosh/windfarm.h |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/macintosh/windfarm.h b/drivers/macintosh/windfarm.h
index 7a2482c..3ef192a 100644
--- a/drivers/macintosh/windfarm.h
+++ b/drivers/macintosh/windfarm.h
@@ -35,12 +35,12 @@ struct wf_control_ops {
 };
 
 struct wf_control {
-	struct list_head	link;
-	struct wf_control_ops	*ops;
-	char			*name;
-	int			type;
-	struct kref		ref;
-	struct device_attribute	attr;
+	struct list_head		link;
+	const struct wf_control_ops	*ops;
+	const char			*name;
+	int				type;
+	struct kref			ref;
+	struct device_attribute		attr;
 };
 
 #define WF_CONTROL_TYPE_GENERIC		0
@@ -85,11 +85,12 @@ struct wf_sensor_ops {
 };
 
 struct wf_sensor {
-	struct list_head	link;
-	struct wf_sensor_ops	*ops;
-	char			*name;
-	struct kref		ref;
-	struct device_attribute	attr;
+	struct list_head		link;
+	const struct wf_sensor_ops	*ops;
+	const char			*name;
+	struct kref			ref;
+	struct device_attribute		attr;
+	void				*priv;
 };
 
 /* Same lifetime rules as controls */
-- 
1.7.9.5
