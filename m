Return-Path: <linuxppc-dev+bounces-25774-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806E9C5B572
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Aug 2026 14:20:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hKrHg5Zlsz2yv8;
	Thu, 13 Aug 2026 00:20:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786544431;
	cv=none; b=VZHIjVdtoCeN43n7ST/grqis34skjaSMqSyL3ywiAsd1lkXljz4Bk4G1W9PNdNyJtkziKK9Hs4yDB5dUocVaxN+tPj/RtMKQ+fqaAUyTPqBRXrJyr6DGpjh7eCh3RR/NXUNpQ9VBfhbO36Peoxd18LMxtepY2wKY+yQ8EI13F6cUSEZ7ySVi78VFpOeldyerPn6HooN6z+Q8htpUC9sM59Bkfr0EtMsD8QnjbgUhRolx1J6EOhBP1pIH/lq4qKm72vyREeHN5O5jN8v0tFSV7BX9vbdT/HG+pmz9xQretsv+dD+VjzjmwclY8h45tkwhjtKiN04AHacVA6ettiSLVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786544431; c=relaxed/relaxed;
	bh=ri73WBFylGP1oW970dISficnBX9LqQNH5o/i2IohbAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lviUDGJsIoO7q3bFYs6r+0d4N2jRERNSzF1b+sHEB/0iCK7AwTorC0zow6OQlgq+zg50nssEDW46rnNeq1tzz7rjiL4V99/wFFXX1t8kDP6VcyyunosicMEaspu3aXs/DqA9J3g3Td+OMr40U/YND7QIYfqW8Zag9F6pGzqekyrcD+luGQZWlgYkIHrvouJY97WzvPFPBD0S0kl9EtLEm68JNBUvD8ci0nVhEQ/oB91oX9v+Q/4ynDxJldfrXSXPIIWvM4CpiEn0VAhAhW5xTvecPYFCu/8gorsma3aHS3RH+Tywn0DJ3IPqEbDte74D+bbUc7CvxQRWCG7Nl6dBWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVoxI0sG; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVoxI0sG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hKrHg0YYqz2ytv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 00:20:30 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D98A3405EC;
	Wed, 12 Aug 2026 14:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95201F000E9;
	Wed, 12 Aug 2026 14:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786544428;
	bh=ri73WBFylGP1oW970dISficnBX9LqQNH5o/i2IohbAE=;
	h=From:To:Cc:Subject:Date;
	b=OVoxI0sGTNbXFuN68nuk9koRLXj3J8aY1G5gijY57ner6PspL8nIr/yP4UEGOJJlJ
	 WKVXLKFkOMENXBkwD9rMgBtIsPSrJy2Ptpa5pUeVxVLiLfFPsqQl81z5gQM3tEPu2t
	 HO6+uCCNgHdIFMOS3c4IQ1GOjTpMWflexVTBHSMEd6jIMSMd9CpSXEN8mC28NeMs5Y
	 sHwoK/5KY+TTr79vwJW4j0UFfM/0hcCs1+YU4OlJ/xWrfKiTVJBt4Lz54jwWia71tE
	 CxnPhcZATQul1UU303txI0zOXHiHO/VVQtyWqlqilT5FWdqb+F7VUBHsCiFVyySUp3
	 dVngucef+P/+g==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wu9og-00000000ELf-20Hn;
	Wed, 12 Aug 2026 16:20:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Geoff Levand <geoff@infradead.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v2 RESEND 0/3] powerpc: switch to dynamic root devices
Date: Wed, 12 Aug 2026 16:20:13 +0200
Message-ID: <20260812142016.55136-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
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

[ It's been over three months (and one reminder) since this series was
  posted so resending.  ]

This series replaces static root devices with dynamically allocated
ones. Included is also a related printk cleanup.

Johan


Changes in v2:
 - only set ibmebus root pointer on successful registration
 - add sanity check when registering ibmebus devices to avoid
   use-after-free if ibmebus_register_driver() is called after the bus
   failed to register (Sashiko flagged this path which I had missed)


Johan Hovold (3):
  powerpc/ps3: switch to dynamic system bus root device
  powerpc/pseries: switch to dynamic ibmebus root device
  powerpc/pseries: clean up ibmebus printks

 arch/powerpc/platforms/ps3/system-bus.c  | 10 ++---
 arch/powerpc/platforms/pseries/ibmebus.c | 57 ++++++++++++------------
 2 files changed, 33 insertions(+), 34 deletions(-)

-- 
2.54.0


