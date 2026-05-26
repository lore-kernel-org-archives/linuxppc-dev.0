Return-Path: <linuxppc-dev+bounces-21523-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A89CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 18:48:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQ1wk44Y5z2yD6;
	Wed, 27 May 2026 04:48:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:c0c:a5b1::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779821302;
	cv=none; b=j/uEfIRwQvki0xlv04uaKTTpsS/WUVnCUZrtVi+rELI/e87WBm44jNxGlkX9zWG+Q6YR/1U4R9wro/6k8eeZ7vhjJYrH196MWJi5jt8XpKCv3MHrkj+JmAAZXCKh1eeWpqlDibFvwO4sVDtc8Up27qWsIVw6VTwp3f28O70qzfSzJ5N4ZMvOxpfI9vbeYG4ZOusIs+jBVU/p6RKI3ktT7oeBdTCZ/kXoovKujxd6portjzn0RIu9MS7j6N7VtjlUiWaa9GgqadVPI+S/dQ7F5lcaORLvZwRFUX0nfsgrqHLyFufGQJWwENVjusbxOLEcE6o2M9XKo14WQidGrwoeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779821302; c=relaxed/relaxed;
	bh=Yj59XIQE18o2FT3DKRpTTrhdOVfN3MXkuh7iKK7w97Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cp4390vEpqFtzZHoNvV7bkYffOShtfXBmbvt5N7ZY8HewRcuoZsK/ChikUVSPVo7Zo+Ves9lhTkv4o5y3KwICT8Cu8xEtql58wUnezjok14YgKvnBHNmdb/BhuzNKkwn2fl1aXgOgmeQ7DPosx2C56s4NXYazN2d/ZEeZWmr5Wl2UiBzVieQK3jdYYCrjdUtvs3+IDVYNx3wFgvLJFdbyslSHmw6A2Bj9gv8WTgDHnigA6YSsIhtWwVGflgJFcJEnr8skb182h6CPBVFJoq/ln0+hSXmPnE0yANdCVph56d85LFASDBwPd+FwdVEHo9fNmEDnK8N7BC2mo7XNNNPDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de; dkim=pass (2048-bit key; secure) header.d=al2klimov.de header.i=@al2klimov.de header.a=rsa-sha256 header.s=default header.b=KgcXZvh7; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:c0c:a5b1::1; helo=mta.al2klimov.de; envelope-from=grandmaster@al2klimov.de; receiver=lists.ozlabs.org) smtp.mailfrom=al2klimov.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=al2klimov.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=al2klimov.de header.i=@al2klimov.de header.a=rsa-sha256 header.s=default header.b=KgcXZvh7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=al2klimov.de (client-ip=2a01:4f8:c0c:a5b1::1; helo=mta.al2klimov.de; envelope-from=grandmaster@al2klimov.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 396 seconds by postgrey-1.37 at boromir; Wed, 27 May 2026 04:48:18 AEST
Received: from mta.al2klimov.de (mta.al2klimov.de [IPv6:2a01:4f8:c0c:a5b1::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQ1wf4jFKz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 04:48:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=Yxu6cLp2nC8s
	IKWrf8BHCgxZkIkwHCYaYzNUnh2jBvA=; h=references:in-reply-to:date:
	subject:cc:to:from; d=al2klimov.de; b=KgcXZvh75ghDzewMNDjJvGdGkzAqan48
	aMXSqceQrChAJOeehngZDsB+LZDSdEpCVt4lOi6sfZSuAEyHYFip6AJEGaDn3UpRUV9gjk
	t+uGViIA8euFxUpxq2003kXWJjKXtuER8C6cCjbBPEcjbAbvcP0cXiafSTUgeL0SHF8Dvb
	ddxuc7oektBV6A/91Kb3xaVyLvxanCi4BC29WS5tjY3bYuSHrM3aQ/NRgOA5gitwwZ1v8w
	ZTv33AB8jTDWqX+mu9q7vt9PY6d0efUR1jw7CuT1E1I8NtKHND1EIBbfKe4sOhvkQURfm3
	rtKZqcC2m/SWN02857nIcWah9VKfKw==
Received: from cachy-ak (88.215.123.80.dyn.pyur.net [88.215.123.80])
	by mta.al2klimov.de (OpenSMTPD) with ESMTPSA id cfc4909e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 26 May 2026 18:41:33 +0000 (UTC)
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
To: Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
	Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>,
	netdev@vger.kernel.org (open list:IBM Power SRIOV Virtual NIC Device Driver),
	linuxppc-dev@lists.ozlabs.org (open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list)
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] ibmvnic: fix krealloc() memory leak
Date: Tue, 26 May 2026 20:41:01 +0200
Message-ID: <20260526184105.18962-6-grandmaster@al2klimov.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526184105.18962-1-grandmaster@al2klimov.de>
References: <20260526184105.18962-1-grandmaster@al2klimov.de>
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

Don't just overwrite the original pointer passed to krealloc()
with its return value without checking latter:

    MEM = krealloc(MEM, SZ, GFP);

If krealloc() returns NULL, that erases the pointer
to the still allocated memory, hence leaks this memory.
Instead, use a temporary variable, check it's not NULL
and only then assign it to the original pointer:

    TMP = krealloc(MEM, SZ, GFP);
    if (!TMP) return;
    MEM = TMP;

Fixes: 4e6759be28e4 ("ibmvnic: Feature implementation of Vital Product Data (VPD) for the ibmvnic driver")
Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5a510eed335e..25d1d844ad19 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1761,8 +1761,9 @@ static int ibmvnic_get_vpd(struct ibmvnic_adapter *adapter)
 	union ibmvnic_crq crq;
 	int len = 0;
 	int rc;
+	unsigned char *buff = adapter->vpd->buff;
 
-	if (adapter->vpd->buff)
+	if (buff)
 		len = adapter->vpd->len;
 
 	mutex_lock(&adapter->fw_lock);
@@ -1788,17 +1789,17 @@ static int ibmvnic_get_vpd(struct ibmvnic_adapter *adapter)
 	if (!adapter->vpd->len)
 		return -ENODATA;
 
-	if (!adapter->vpd->buff)
-		adapter->vpd->buff = kzalloc(adapter->vpd->len, GFP_KERNEL);
+	if (!buff)
+		buff = kzalloc(adapter->vpd->len, GFP_KERNEL);
 	else if (adapter->vpd->len != len)
-		adapter->vpd->buff =
-			krealloc(adapter->vpd->buff,
-				 adapter->vpd->len, GFP_KERNEL);
+		buff = krealloc(buff,
+				adapter->vpd->len, GFP_KERNEL);
 
-	if (!adapter->vpd->buff) {
+	if (!buff) {
 		dev_err(dev, "Could allocate VPD buffer\n");
 		return -ENOMEM;
 	}
+	adapter->vpd->buff = buff;
 
 	adapter->vpd->dma_addr =
 		dma_map_single(dev, adapter->vpd->buff, adapter->vpd->len,
-- 
2.54.0


