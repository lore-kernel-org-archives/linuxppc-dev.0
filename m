Return-Path: <linuxppc-dev+bounces-24789-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E19FC531FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 15:24:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6Bbv2zBwz2yFg;
	Sat, 25 Jul 2026 01:24:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:3000::53df:4ee9:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784906651;
	cv=none; b=e+kvs6iSkEpJR9qo2n7zgWXU/E/KhSzJDRIlSW7rQlNuxF7jtQwPF0PxAxr47ZcEqgeQT9oLZepXDBkSObssgjB2t60SJQRUzzmSZcssO9iUXNB3e2p9xS6cw5k2cFRu30jNWcq/x8OduUuk6A4MhBBHL+5V4OT0LviyU9nAoich8kenfsuGQls+fDQjvgXGJwSNLX01WAo3bb+NEE2PM1OsXDW/d2S5ZRMV+ng/CcllMix3rLMRyCg+34nnQ1oW1TRM/KIgs7neaiuMJLSgRfbUUDsr/F8wa7gHTIDvcABnzmhFBA3Ubgq48O4gJdKVP0is/NWz+qyPWp176iL0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784906651; c=relaxed/relaxed;
	bh=wTvrj71IznxePl7YXQDoJn49NNwwXQ2B9RJmlCf8MaI=;
	h=Message-ID:From:Date:Subject:To:Cc; b=QSgudVLeiYm1qtSDYWnT7gYyMNKg0Rdm9d6xUKjU6OOO0xg1lPi/cibTNs6GRmnoFmVbldSuK8559xyZ544j+Hv8Ez+MrjlU7ggBvTKmPaOY2jch5yop2FNNXZrtJaY5BurajrHy8EfXjy8GJtGYfkHDpcBLLQ/HnehOXDcUlbc6Yy3QvWR7+c+t6hx995fp7ZwNcJ2SJfA9P2ACd4QAoTqONoLrYBUoXcbmZFGql0PNnytENeYFNYw84P0hD66pbvOzRaq+1XXdzoYIHusQPeoy9Pev4N7EmEqzLeqGvBn1DHkkvTWaRyOJzqZcNlBjc7x9cO121iSGqZ3Q+ZJJ2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6Bbs4w5Jz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 01:24:06 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 1424010624;
	Fri, 24 Jul 2026 17:24:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id F3F0560CF04D; Fri, 24 Jul 2026 17:24:00 +0200 (CEST)
Message-ID: <cover.1784905909.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 24 Jul 2026 17:24:00 +0200
Subject: [PATCH 0/6] PCI/AER: Support Advisory Non-Fatal Errors
To: Bjorn Helgaas <helgaas@kernel.org>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>, Qingshun Wang <qingshun.wang@linux.intel.com>, Yicong Yang <yang.yicong@picoheart.com>, dio.sun@enflame-tech.com, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Terry Bowman <terry.bowman@amd.com>. Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, Arjun Govindjee <agovindjee@purestorage.com>, Ashish Karkare <ashishk@purestorage.com>, Jasjeet Rangi <jrangi@purestorage.com>, Meeta Saggi <msaggi@purestorage.com>, rhan@purestorage.com, sconnor@purestorage.com, an.luo@enflame-tech.com, fernando.hu@enflame-tech.com, bill.wu@enflame-tech.com, xin.wang@enflame-tech.com
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

PCIe r7.0 sec 6.2.4.3 specifies that certain Non-Fatal Errors may be
signaled with ERR_COR instead of ERR_NONFATAL.  These so-called Advisory
Non-Fatal Errors are masked by default and hence not reported by Linux.

This series seeks to change that.  The meat of it is in patch [6/6].
There have been several previous attempts to support Advisory Non-Fatal
Errors which are all linked in the patch.

The preceding patches contain prep work.  In particular, they ensure that
the detecting agent and layer is reported correctly for each error (patch
[1/6] and [2/6]), simplify logging of the error source (patch [3/6]),
fix reporting of the TLP Prefix/Header Log (patch [4/6]) and move code
around (patch [5/6]).

The patches have been tested internally, but further testing would be
appreciated to raise the confidence.  Thanks!

Lukas Wunner (6):
  PCI/AER: Fix mapping of errors to agent & layer
  PCI/AER: Log agent & layer for each individual error
  PCI/AER: Deduplicate logging of Error Source Identification
  PCI/AER: Emit TLP Log only for unmasked errors
  PCI/AER: Move retrieval of FEP and TLP Log into helper
  PCI/AER: Support Advisory Non-Fatal Errors

 drivers/pci/pci.h      |   4 +
 drivers/pci/pcie/aer.c | 250 ++++++++++++++++++++++++++++++++---------
 2 files changed, 200 insertions(+), 54 deletions(-)

-- 
2.53.0


