Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BF7606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vk93L+Dt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY8XZ0z1fz2xyj;
	Tue, 24 Nov 2026 02:11:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795446670;
	cv=none; b=HwOkupGKfCDxlVhCCWz2eW5bHp5Xd/YkXHR55hCcgTPjo7iFNmWNr3S3JSqdnoT4iq0dkIvhOZkA/VdaU9p40ReduVEfk2onxLXTb1lBweAIFLx1GP+Mhb8M60XCHyJF6B5Z5RgR8T/lisXKU033/VRXnfUctD6FbC7KFvDbeuuzI7j91JCfULGJm3ApzyfRthoOqCKM9PpS4DdKaGvWXUrgQbmBmYmJS/+5GANs38kO2LL8CoP3IbnrChu8sUCn4XZ/CV6Y7Qty5ycdSADzZrlVxYflWkwi8wKVB+GOgfnTJ7w60EGQT3R/Bby6ivTGp7n7AQa2qvrOmfjVLdJTUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795446670; c=relaxed/relaxed;
	bh=2rXwqdKcXils5ZX0aUJ4kLahSvMQRVDM5PZVEx1DXik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KJXY2XNfB0LnieyLNDUJl42p0qP9L7NhH2aiSbKrXayuhqdwiexDjHK7b9OE9G4l4PAO5JQ+4kaT7PPMSTCNgZoWtbDAaGs5DIm74KGdM4fO3b8mJPqg40gFUZzs5R2JbONqMhE1bHJKILxDcbjqxHyTVnLxMVzvpVm7vmz2/64HEErKCu/i5YtW/FgCcJqp1odMJMrTqRmYejnLjXZNdnqHXGmAjZ5ICTOjIDH2xiinNA5TtoMwOFuVEYk+W/HIXj0mys7VWLMinyHhCa22ZeTvo10zdOO2CKR66aFXbuIypaa4IWvznhWtmwNZx/N6qb1Exfz6M89a68BGbtXtpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vk93L+Dt; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vk93L+Dt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY8XX4cvzz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 02:11:08 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DA69C62252;
	Mon, 23 Nov 2026 15:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5906A1F000D2;
	Mon, 23 Nov 2026 15:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795446665;
	bh=2rXwqdKcXils5ZX0aUJ4kLahSvMQRVDM5PZVEx1DXik=;
	h=From:To:Cc:Subject:Date;
	b=Vk93L+Dt9YLMBXzvXYfSpC+H3lffXA2iZOKJX2mWjUeIaeUHbBaqwNoa5LUcMB6lC
	 JfWNJXpQxz1SBDTRWQGOikzJIMIbAB/RORvCqKOBB5G8dP0T7z/v8TERi9xkaGAtTP
	 i/qTJZHV3ue2mzAkVJz6r0ecPZwLtyJNsWjW0ciNe8zX9EEQBVbnR4zAiGXI35M6Lc
	 XPRdP/r12xXxidCz58UwmLi6cuT0gObPoQw96fM9tMr1jvlk+CL6VV44kNCS4nV8un
	 ZhcPhVMQ5QpqHxKmRiROaRwQswAgRC1oWqN45oCedzrzy2erJ0kxIHoMmWX3AgLV8d
	 mtMQtwbFYf9Mg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Antoine Tenart <atenart@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Bulent Abali <abali@us.ibm.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	Dan Streetman <ddstreet@ieee.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Haren Myneni <haren@us.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Kim Phillips <kim.phillips@freescale.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	Longfang Liu <liulongfang@huawei.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Meng Yu <yumeng18@huawei.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Nicolas Royer <nicolas@eukrea.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Pascal van Leeuwen <pvanleeuwen@insidesecure.com>,
	Paul Louvel <paul.louvel@bootlin.com>,
	Robert Jennings <rcj@linux.vnet.ibm.com>,
	Sahil Malhotra <sahil.malhotra@nxp.com>,
	Samuel Holland <samuel@sholland.org>,
	Seth Jennings <sjenning@linux.vnet.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Srujana Challa <schalla@marvell.com>,
	Stanimir Varbanov <svarbanov@mm-sol.com>,
	Steffen Trumtrar <kernel@pengutronix.de>,
	Thorsten Blum <blum@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Weili Qian <qianweili@huawei.com>,
	Zaibo Xu <xuzaibo@huawei.com>,
	Zhiqi Song <songzhiqi1@huawei.com>
Subject: [PATCH 00/10] crypto: Assorted bug fixes across crypto drivers
Date: Mon, 23 Nov 2026 15:09:51 +0000
Message-ID: <20261123151055.2533735-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These issues were reported by Sashiko.

None of these changes have been tested on physical hardware.

Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Antoine Tenart <atenart@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bharat Bhushan <bbhushan2@marvell.com>
Cc: bui duc phuc <phucduc.bui@gmail.com>
Cc: Bulent Abali <abali@us.ibm.com>
Cc: Chen-Yu Tsai <wens@kernel.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Haren Myneni <haren@us.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Kim Phillips <kim.phillips@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-sunxi@lists.linux.dev
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Longfang Liu <liulongfang@huawei.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Cc: Meng Yu <yumeng18@huawei.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Nicolas Royer <nicolas@eukrea.com>
Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Pascal van Leeuwen <pvanleeuwen@insidesecure.com>
Cc: Paul Louvel <paul.louvel@bootlin.com>
Cc: Robert Jennings <rcj@linux.vnet.ibm.com>
Cc: Sahil Malhotra <sahil.malhotra@nxp.com>
Cc: Samuel Holland <samuel@sholland.org>
Cc: Seth Jennings <sjenning@linux.vnet.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Srujana Challa <schalla@marvell.com>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Steffen Trumtrar <kernel@pengutronix.de>
Cc: Thorsten Blum <blum@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Weili Qian <qianweili@huawei.com>
Cc: Zaibo Xu <xuzaibo@huawei.com>
Cc: Zhiqi Song <songzhiqi1@huawei.com>

Lee Jones (10):
  crypto: caam - Fix descriptor buffer overflow in caam_process_blob()
  crypto: marvell - Fix AEAD key buffer overflow for SHA-384/512 HMAC
  crypto: nx - Fix bounce buffer copy overflow in decompress()
  crypto: sun8i-ss - Fix scatterlist array overflow for HMAC requests
  crypto: hisilicon/hpre - Fix buffer overflow on odd ECDH input size
  crypto: talitos - Remove duplicate IV unmap in AEAD encrypt path
  crypto: safexcel - Check scatterlist errors before max() for in-place
  crypto: qce - Pass mapped scatterlist count to qce_dma_prep_sgs()
  crypto: qce - Terminate RX DMA channel if TX preparation fails
  crypto: atmel-tdes - Update output IV before clearing busy flag

 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c  |  7 +++++--
 drivers/crypto/atmel-tdes.c                        |  7 +++++--
 drivers/crypto/caam/blob_gen.c                     | 12 ++++++++----
 drivers/crypto/hisilicon/hpre/hpre_crypto.c        |  5 +++--
 drivers/crypto/inside-secure/safexcel_cipher.c     |  7 +++----
 drivers/crypto/marvell/octeontx/otx_cptvf_algs.h   |  2 +-
 drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.h |  2 +-
 drivers/crypto/nx/nx-842.c                         |  5 ++++-
 drivers/crypto/qce/dma.c                           |  8 ++++++--
 drivers/crypto/qce/sha.c                           |  9 +++++----
 drivers/crypto/talitos.c                           |  4 ----
 11 files changed, 41 insertions(+), 27 deletions(-)

-- 
2.56.1.750.gf70dc682cf-goog


