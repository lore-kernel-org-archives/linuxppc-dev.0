Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.230])
	by ozlabs.org (Postfix) with ESMTP id 93F3BDDFD6
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 16:02:53 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2532371rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Aug 2008 23:02:51 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
	galak@kernel.crashing.org, jwboyer@linux.vnet.ibm.com
Date: Wed, 06 Aug 2008 00:02:44 -0600
Message-ID: <20080806060239.30717.79273.stgit@trillian.secretlab.ca>
In-Reply-To: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
Cc: miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

of_lookup_stdout() is useful for figuring out what device to use as output
for early boot progress messages.  It returns the node pointed to by the
linux,stdout-path property in the chosen node.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/of/base.c  |   24 ++++++++++++++++++++++++
 include/linux/of.h |    1 +
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index ad8ac1a..10c6a46 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -473,3 +473,27 @@ int of_modalias_node(struct device_node *node, char *modalias, int len)
 }
 EXPORT_SYMBOL_GPL(of_modalias_node);
 
+/**
+ * of_lookup_stdout - find node pointed to by chosen linux,stdout-path property
+ *
+ * This routine returns a pointer to the stdout node or NULL on failure
+ */
+struct device_node __init *of_lookup_stdout(void)
+{
+	struct device_node *chosen, *stdout_node;
+	const char *stdout_path;
+
+	chosen = of_find_node_by_path("/chosen");
+	if (!chosen)
+		return NULL;
+
+	stdout_path = of_get_property(chosen, "linux,stdout-path", NULL);
+	if (!stdout_path) {
+		of_node_put(chosen);
+		return NULL;
+	}
+
+	stdout_node = of_find_node_by_path(stdout_path);
+	of_node_put(chosen);
+	return stdout_node;
+}
diff --git a/include/linux/of.h b/include/linux/of.h
index 79886ad..e8b215b 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -71,5 +71,6 @@ extern int of_n_size_cells(struct device_node *np);
 extern const struct of_device_id *of_match_node(
 	const struct of_device_id *matches, const struct device_node *node);
 extern int of_modalias_node(struct device_node *node, char *modalias, int len);
+struct device_node __init *of_lookup_stdout(void);
 
 #endif /* _LINUX_OF_H */
