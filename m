Return-Path: <linuxppc-dev+bounces-22668-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4209CD98E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 22:29:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfPtw0vTTz3btm;
	Tue, 16 Jun 2026 08:29:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781562584;
	cv=none; b=inGGf5a8N/jqCi0MXUEQTsigAQU6OkUEumzSWaB5bbhFFherRtf/MxlKi7NIwqLjptjd8/3Ylka+ij0FT0HpszJ+jLAA5DEorySESDun/fV0tBjLezTC2d5ORKxJQWXs2emHFN1USlCfgG7HTPxqiNN0UBX2TJc2G01PC6+115pgPXSnzaMmhTQwT4Up6STi0ZqvQgj42Zl3MGntjTJe65FR9msgpy2AG1Vy7nsYjYlhfUWWfK7boP3TTyfvgYms9s6EehPFo8f87SYZCED1f2SSRm4I5Nf3rTvwV807AcbS2+cR19p54QEp6ik6ZKU+olwx16rw0rDJ0V4ZgzfQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781562584; c=relaxed/relaxed;
	bh=OC3GfqVbozJPrEg3wXvMzIp5mX4dp118jI+UwZmvJdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9IAwL/Bu0L2ZY5kzK6W7JLOSz30dTCUUIrfkLsRx0ZPIdFyqlu0KSuaKxvyTXEB3a3UZatlbAno8tAZ/1UY1IBSJBQl+wsPg6w+SdSt4472k0YKoypGaaR6dp1S1nwFlN8s4UYzCm4N8KP18hacbk63J7a1QnSWCzYMvsIzP9Vj+5wcph6fvzuUlTr5XibiB5sJxy3Lj7w0luRROiB/awsCVd5T8BLsCaaQMbH7vURze8kCFoy7JrZSx0o6X/NEefPvansTZY3RR8iJISFCtiAH45ro3AAOapa5Q0XxPSHMPW4DQN4sleaGgojuJT4qAp/ztLhcaDh5mqxsBV6vrw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SMTzqsBd; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SMTzqsBd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfPtt5GrQz2ySS
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 08:29:42 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7D552439AC;
	Mon, 15 Jun 2026 22:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AEA1F00A3A;
	Mon, 15 Jun 2026 22:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781562580;
	bh=OC3GfqVbozJPrEg3wXvMzIp5mX4dp118jI+UwZmvJdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SMTzqsBdcPDEyOG1ANlN4WMZ6cdRrA5BSzIJByTtqVQ+kVenE5809vICqdrJFkexk
	 aGyVReTCbL/e/KJ/9hK9QVgWLFG+7hpmhhPs8vQtj4BB38ICTG0lvys1M2scyqbQH5
	 2WW8Yu4BiKN6QKPcH6peko7uXVz++J2/4aaXXiqs6zWUEdsSQBkghikg5cA2/QnDuv
	 Ibz1aclffKpo5iAuzeL5xBoSvczrEAJdpnpgNs/TMiR794Dy2qzukq2D9NrmkuMmxo
	 9j8upnF+tnwDQiSjeTh6dtpoR/6mV80Y54bu3L5r1VHhmRQCD2N6EkGAlomNeosHI8
	 9jVJDDbh8r+YQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	geert@linux-m68k.org,
	chleroy@kernel.org,
	npiggin@gmail.com,
	mpe@ellerman.id.au,
	maddy@linux.ibm.com,
	linux-mips@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] appletalk: stop storing per-interface state in struct net_device
Date: Mon, 15 Jun 2026 15:29:34 -0700
Message-ID: <20260615222935.947233-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615222935.947233-1-kuba@kernel.org>
References: <20260615222935.947233-1-kuba@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AppleTalk keeps its per-interface control block (struct atalk_iface)
directly in struct netdevice (dev->atalk_ptr). This is the only thing
tying the protocol into the core net_device layout and is the sole
blocker to moving AppleTalk out of tree.

Replace dev->atalk_ptr with a small ifindex-keyed hashtable internal
to ddp.c. The existing atalk_interfaces list stays the owner of the iface
objects; the hashtable is purely a fast dev->iface index and reuses
the same atalk_interfaces_lock.

AFAICT this patch does not make this code any more racy than it already
is, I'm sure Sashiko will point out some basically existing bugs.
AFAICT atalk_interfaces_lock is the innermost lock already.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../networking/net_cachelines/net_device.rst  |  1 -
 include/linux/atalk.h                         |  8 +---
 include/linux/netdevice.h                     |  4 --
 net/appletalk/ddp.c                           | 48 +++++++++++++++++--
 4 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index eb2e6851c6f6..512f6d6fa3d8 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -90,7 +90,6 @@ struct inet6_dev*                   ip6_ptr                     read_mostly
 struct vlan_info*                   vlan_info
 struct dsa_port*                    dsa_ptr
 struct tipc_bearer*                 tipc_ptr
-void*                               atalk_ptr
 struct wireless_dev*                ieee80211_ptr
 struct wpan_dev*                    ieee802154_ptr
 struct mpls_dev*                    mpls_ptr
diff --git a/include/linux/atalk.h b/include/linux/atalk.h
index a55bfc6567d0..ce7e6bfa9e2a 100644
--- a/include/linux/atalk.h
+++ b/include/linux/atalk.h
@@ -30,6 +30,7 @@ struct atalk_iface {
 #define ATIF_PROBE_FAIL	2		/* Probe collided */
 	struct atalk_netrange	nets;
 	struct atalk_iface	*next;
+	struct hlist_node	hash_node;	/* keyed on dev->ifindex */
 };
 	
 struct atalk_sock {
@@ -113,12 +114,7 @@ extern int aarp_proto_init(void);
 /* Inter module exports */
 
 /* Give a device find its atif control structure */
-#if IS_ENABLED(CONFIG_ATALK)
-static inline struct atalk_iface *atalk_find_dev(struct net_device *dev)
-{
-	return dev->atalk_ptr;
-}
-#endif
+extern struct atalk_iface *atalk_find_dev(struct net_device *dev);
 
 extern struct atalk_addr *atalk_find_dev_addr(struct net_device *dev);
 extern struct net_device *atrtr_get_dev(struct atalk_addr *sa);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7f4f0837c09f..655564621f28 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1947,7 +1947,6 @@ enum netdev_reg_state {
  *	@vlan_info:	VLAN info
  *	@dsa_ptr:	dsa specific data
  *	@tipc_ptr:	TIPC specific data
- *	@atalk_ptr:	AppleTalk link
  *	@ip_ptr:	IPv4 specific data
  *	@ip6_ptr:	IPv6 specific data
  *	@ieee80211_ptr:	IEEE 802.11 specific data, assign before registering
@@ -2349,9 +2348,6 @@ struct net_device {
 #if IS_ENABLED(CONFIG_TIPC)
 	struct tipc_bearer __rcu *tipc_ptr;
 #endif
-#if IS_ENABLED(CONFIG_ATALK)
-	void 			*atalk_ptr;
-#endif
 #if IS_ENABLED(CONFIG_CFG80211)
 	struct wireless_dev	*ieee80211_ptr;
 #endif
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 30a6dc06291c..afb86ce6e644 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -52,6 +52,7 @@
 #include <linux/termios.h>	/* For TIOCOUTQ/INQ */
 #include <linux/compat.h>
 #include <linux/slab.h>
+#include <linux/hashtable.h>
 #include <net/datalink.h>
 #include <net/psnap.h>
 #include <net/sock.h>
@@ -204,6 +205,33 @@ DEFINE_RWLOCK(atalk_routes_lock);
 struct atalk_iface *atalk_interfaces;
 DEFINE_RWLOCK(atalk_interfaces_lock);
 
+/* Fast dev->iface lookup, keyed on ifindex. Shares atalk_interfaces_lock with
+ * the atalk_interfaces list, which remains the owner of the iface objects.
+ */
+#define ATALK_IFACE_HASH_BITS	8
+static DEFINE_HASHTABLE(atalk_iface_hash, ATALK_IFACE_HASH_BITS);
+
+/* Find the iface for @dev. Caller must hold atalk_interfaces_lock. */
+static struct atalk_iface *__atalk_find_dev(struct net_device *dev)
+{
+	struct atalk_iface *iface;
+
+	hash_for_each_possible(atalk_iface_hash, iface, hash_node, dev->ifindex)
+		if (iface->dev == dev)
+			return iface;
+	return NULL;
+}
+
+struct atalk_iface *atalk_find_dev(struct net_device *dev)
+{
+	struct atalk_iface *iface;
+
+	read_lock_bh(&atalk_interfaces_lock);
+	iface = __atalk_find_dev(dev);
+	read_unlock_bh(&atalk_interfaces_lock);
+	return iface;
+}
+
 /* For probing devices or in a routerless network */
 struct atalk_route atrtr_default;
 
@@ -221,9 +249,9 @@ static void atif_drop_device(struct net_device *dev)
 	while ((tmp = *iface) != NULL) {
 		if (tmp->dev == dev) {
 			*iface = tmp->next;
+			hash_del(&tmp->hash_node);
 			dev_put(dev);
 			kfree(tmp);
-			dev->atalk_ptr = NULL;
 		} else
 			iface = &tmp->next;
 	}
@@ -240,13 +268,13 @@ static struct atalk_iface *atif_add_device(struct net_device *dev,
 
 	dev_hold(dev);
 	iface->dev = dev;
-	dev->atalk_ptr = iface;
 	iface->address = *sa;
 	iface->status = 0;
 
 	write_lock_bh(&atalk_interfaces_lock);
 	iface->next = atalk_interfaces;
 	atalk_interfaces = iface;
+	hash_add(atalk_iface_hash, &iface->hash_node, dev->ifindex);
 	write_unlock_bh(&atalk_interfaces_lock);
 out:
 	return iface;
@@ -347,8 +375,15 @@ static int atif_proxy_probe_device(struct atalk_iface *atif,
 
 struct atalk_addr *atalk_find_dev_addr(struct net_device *dev)
 {
-	struct atalk_iface *iface = dev->atalk_ptr;
-	return iface ? &iface->address : NULL;
+	struct atalk_addr *addr = NULL;
+	struct atalk_iface *iface;
+
+	read_lock_bh(&atalk_interfaces_lock);
+	iface = __atalk_find_dev(dev);
+	if (iface)
+		addr = &iface->address;
+	read_unlock_bh(&atalk_interfaces_lock);
+	return addr;
 }
 
 static struct atalk_addr *atalk_find_primary(void)
@@ -388,8 +423,10 @@ static struct atalk_addr *atalk_find_primary(void)
  */
 static struct atalk_iface *atalk_find_anynet(int node, struct net_device *dev)
 {
-	struct atalk_iface *iface = dev->atalk_ptr;
+	struct atalk_iface *iface;
 
+	read_lock_bh(&atalk_interfaces_lock);
+	iface = __atalk_find_dev(dev);
 	if (!iface || iface->status & ATIF_PROBE)
 		goto out_err;
 
@@ -398,6 +435,7 @@ static struct atalk_iface *atalk_find_anynet(int node, struct net_device *dev)
 	    node != ATADDR_ANYNODE)
 		goto out_err;
 out:
+	read_unlock_bh(&atalk_interfaces_lock);
 	return iface;
 out_err:
 	iface = NULL;
-- 
2.54.0


