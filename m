Return-Path: <cyril.bur@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E0CA1A0ACA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:41:44 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyril.bur@au1.ibm.com>;
 Thu, 25 Sep 2014 16:41:43 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E7C952CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:41:41 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8P6hGDf27984094
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:43:16 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8P6fafD005637
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:41:36 +1000
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 s8P6faeP005631
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:41:36 +1000
Received: from cyril.ozlabs.ibm.com (haven.au.ibm.com [9.190.164.82])
 (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 8E332A01FB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:41:30 +1000 (EST)
From: Cyril Bur <cyril.bur@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/3] drivers/of: add of_changeset_apply_locked
Date: Thu, 25 Sep 2014 16:41:28 +1000
Message-Id: <1411627290-20302-2-git-send-email-cyril.bur@au1.ibm.com>
In-Reply-To: <1411627290-20302-1-git-send-email-cyril.bur@au1.ibm.com>
References: <1411627290-20302-1-git-send-email-cyril.bur@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Due to the requirement of of_changesets that of_changeset_apply be called
holding the of_mutex and that the of_mutex cannot be accessed nicely outside
the of code, added a wrapper which grabs the lock and called
of_changeset_apply.

Signed-off-by: Cyril Bur <cyril.bur@au1.ibm.com>
---
 drivers/of/dynamic.c | 11 +++++++++++
 include/linux/of.h   |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 54fecc4..cbff2a2 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -542,6 +542,17 @@ void of_changeset_destroy(struct of_changeset *ocs)
 		__of_changeset_entry_destroy(ce);
 }
 
+int of_changeset_apply_locked(struct of_changeset *ocs)
+{
+	int ret;
+
+	mutex_lock(&of_mutex);
+	ret = of_changeset_apply(ocs);
+	mutex_unlock(&of_mutex);
+
+	return ret;
+}
+
 /**
  * of_changeset_apply - Applies a changeset
  *
diff --git a/include/linux/of.h b/include/linux/of.h
index 6c4363b..f5c48fa 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -827,6 +827,7 @@ struct of_changeset {
 extern void of_changeset_init(struct of_changeset *ocs);
 extern void of_changeset_destroy(struct of_changeset *ocs);
 extern int of_changeset_apply(struct of_changeset *ocs);
+extern int of_changeset_apply_locked(struct of_changeset *ocs);
 extern int of_changeset_revert(struct of_changeset *ocs);
 extern int of_changeset_action(struct of_changeset *ocs,
 		unsigned long action, struct device_node *np,
-- 
1.9.1
