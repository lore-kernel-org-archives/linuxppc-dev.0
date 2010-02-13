Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pz0-f191.google.com (mail-pz0-f191.google.com
	[209.85.222.191]) by ozlabs.org (Postfix) with ESMTP id 23861B7D8F
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Feb 2010 03:02:44 +1100 (EST)
Received: by mail-pz0-f191.google.com with SMTP id 29so4673738pzk.17
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Feb 2010 08:02:44 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 3/9] of: protect linux/of.h with CONFIG_OF
To: monstr@monstr.eu, sfr@canb.auug.org.au, benh@kernel.crashing.org,
	jeremy.kerr@canonical.com, davem@davemloft.net,
	microblaze-uclinux@itee.uq.edu.au, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Date: Sat, 13 Feb 2010 09:02:42 -0700
Message-ID: <20100213160242.4767.57641.stgit@angua>
In-Reply-To: <20100213154838.4767.83881.stgit@angua>
References: <20100213154838.4767.83881.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jeremy Kerr <jeremy.kerr@canonical.com>

For platforms that have CONFIG_OF optional, we need to make the contents
of linux/of.h conditional on CONFIG_OF.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 include/linux/of.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 5c7b6a6..48b0ee6 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -22,6 +22,8 @@
 
 #include <asm/byteorder.h>
 
+#ifdef CONFIG_OF
+
 typedef u32 phandle;
 typedef u32 ihandle;
 
@@ -194,4 +196,5 @@ extern void of_attach_node(struct device_node *);
 extern void of_detach_node(struct device_node *);
 #endif
 
+#endif /* CONFIG_OF */
 #endif /* _LINUX_OF_H */
