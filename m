Return-Path: <linuxppc-dev+bounces-22472-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C45CD98C7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:25:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbch00Yhrz2xmV;
	Thu, 11 Jun 2026 19:25:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781169935;
	cv=none; b=Zqpp5PzRff93v2/8IteDPJ5tTd57PnXq0z2dDGjZkI5dGeaAz07WLZ202GnYYTyr/JltcmqfpMcmAgn+DnuNWgqKfIsfZZTaATDEVzmS+drAzRw7vCCsO8Nk5UD1DQio08LgNyyBfJuqyO94Mm9nnc/sBtKI2YXFVtjOUGt/xq6mICJ3XEw5gzb6lajmOP817ljZjsUxpL+31lWjK/2lCUfe3tMXqEX1IJ8b/WawJW0zwM70VxHH/jYl8ct/ylm1qzO6F1UkNy3goRqfmAYauSvdid3vfjkEt8EEfiBWQc8ZPPZFJVmVp9IInL5ZoOLw5vCBoxP7JXIbW54eHmcmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781169935; c=relaxed/relaxed;
	bh=YJ1iQIfPNsmLxuj29yx1wxVMuDrWhOf5jZ53qGeL5mE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=f5sbYbNskVGXSvKq2aZTv4sHr6WnTj4AwHP/tdnGVcAX2D91BnK2MuLC8bafCYCLbYzGMDeYJyNZQcZjxL294FDXTrazV53Jpfj0acC5VIpSAXaN4gQAUq6aCpK9JzY2S26yK+CRdBz22G1EJDH/QS5Mnf3PMM6jmgqda9XWKD+hqRAYnq+8q0KkJSf/mB9qDg2mW7r0k3g4i2Nbbqvk9qUYSHeptzgu7foIZuV6QO1y0hKR5xzp3TmH5qGztngddMKa4IpMtFHHgLB+gYHJfXq9SUWtzraI5Nn48EPsNbaUYsjYLk9kckcczn+ewN4xDnKT+2BxdSUcN8dbI7IaDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=V07cRD5E; dkim-atps=neutral; spf=pass (client-ip=212.227.15.4; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org) smtp.mailfrom=web.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.a=rsa-sha256 header.s=s29768273 header.b=V07cRD5E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=web.de (client-ip=212.227.15.4; helo=mout.web.de; envelope-from=markus.elfring@web.de; receiver=lists.ozlabs.org)
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbcgw4DTGz2xM7
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2026 19:25:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781169919; x=1781774719; i=markus.elfring@web.de;
	bh=YJ1iQIfPNsmLxuj29yx1wxVMuDrWhOf5jZ53qGeL5mE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=V07cRD5EllX7Lb0+NPkXX12r8k0Rhnh90+Y4FmlY8HlUQ8mtOAASfiFojZtgGMII
	 GzJ9mu8JPS5HEzlpok9/11KmA+HAIb1oobpSKzKEclAGZ/KsflAXVCL2/m7aRaKVo
	 Qv7EL2l4MxOlJQgUd8IOEqEB2fbi9l/nsz/oHar93OrR7VJhHeuHJ3QmtuT8ZUAxV
	 JuShfDwtduV+PTiOBAbTLSpBi466pjH3C69BmZjwK6RN7l1Y7QbIi9g4mYeRqk4Y8
	 EHP3cX0HgyiEMYOuzsduimu7Di47ph5X24yztCn4xcV0w6Zs/lLG8OLadNV+c/gIA
	 5G+X2a0cx8IT42PB2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCXZf-1wOUqD3mUt-001aUS; Thu, 11
 Jun 2026 11:25:18 +0200
Message-ID: <5cd04727-44c5-4ace-af86-d3c227234d4b@web.de>
Date: Thu, 11 Jun 2026 11:25:12 +0200
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
User-Agent: Mozilla Thunderbird
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Bjorn Helgaas <bhelgaas@google.com>, Christophe Leroy <chleroy@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] PCI: pnv_php: Use common error handling code in
 pnv_php_alloc_slot()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LZch8ZynaARseotry4MbARvDbS62nRrmV177vgb+FPalq9amC3A
 vpzbRiQQG6pQEKiirGYkuXmrbK6DNME4odM49TObQgUOwwB89g1NC7hYp6msTxCDMvjbKTj
 2n5DaLEI2jeShHgsJShPedq1AyaOE0Cw8a2C3uy4wXVQp4WpZxZ3ale89bnlNNrc/dJiE0M
 1cmO74UWbcy2Sbl3H2Rfw==
UI-OutboundReport: notjunk:1;M01:P0:LePBFy1mcNM=;qr4BNwEcFutG8Sas0KPyqZf/ZmC
 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
 yLfK938m5a2sCwTDBY=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 11 Jun 2026 11:16:49 +0200

Use an additional label so that a bit of exception handling can be better
reused at the end of an if branch.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/pci/hotplug/pnv_php.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index ff92a5c301b8..e448f1802002 100644
=2D-- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -791,16 +791,15 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struc=
t device_node *dn)
 		return NULL;
=20
 	php_slot->name =3D kstrdup(label, GFP_KERNEL);
-	if (!php_slot->name) {
-		kfree(php_slot);
-		return NULL;
-	}
+	if (!php_slot->name)
+		goto free_php_slot;
=20
 	/* Allocate workqueue for this slot's interrupt handling */
 	php_slot->wq =3D alloc_workqueue("pciehp-%s", WQ_PERCPU, 0, php_slot->na=
me);
 	if (!php_slot->wq) {
 		SLOT_WARN(php_slot, "Cannot alloc workqueue\n");
 		kfree(php_slot->name);
+free_php_slot:
 		kfree(php_slot);
 		return NULL;
 	}
=2D-=20
2.54.0


