Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B03606A31C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2026 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=XSyB9HZB
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jc5732csnz2xpt;
	Sat, 28 Nov 2026 20:47:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795859263;
	cv=none; b=KnmRo4aabu+ibzKcOxa7yHsefcraCbKO9cMWGXFt/hBw1A7kTjBa/jiA9YINTDMZuqHGGGQOEGephueP4Z7zLARTAcEb7EzYam8hKHoYsnVwkZCiA2Z1/nchj89urGTnZPhz7hxd9WIcW0uoSbPMz4CzwnZGw6z+xuG0m+V78Wpk0ihZZBj5e9x1dNqaOykIODCqMNA3Gw0NaGemM0GrImtYqbkyOL+OSYzeq5Fxay2TjrkZc7TqswMnswx6Jzp72t/pA7qt0tvRpG2ijC8+eebaFQXNITPF9mhf7B+mzIIx2tqdbmREL8dMMSMB+aOtSHii2tN3ej7kJS1YGKNadw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795859263; c=relaxed/relaxed;
	bh=tvDL+JTCd3LfYoIRrkmZFykqOvWNjnWdVwHIkVn2/M0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/FQfPWMhY+46FlLhBhFcvdzpb4Fs4Q1JGQVYzznu+s0yV7K5DWW09FhFdrK+8WnCoKtV7RE0vKjuTGcQXN5OBKIBtykBes1wFcJxJWkHrjBinuNGpt8oC08sUwXVdU53aauXW2CZTB+XzvyjgN+2HXSryHh/pZWWMAq1rTuIqJy58Q8mXnI182QaHYD0qbpgZIIaEbUPOj84D/BzsUw0qGNg4gLbF38LpTbRgtEK5PRPvZeb/gHGsfV8UWiOXRp3LjM7BwNki6un7IASH54ygsWmfnnDthvfeFM+R3yWftfmAlgGYWLU/67NpEGe4XQUwqJ4He5Kq4UR2rBMRA2rQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=XSyB9HZB; dkim-atps=neutral; spf=pass (client-ip=101.71.155.101; helo=mail-m155101.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=XSyB9HZB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mail.sdu.edu.cn (client-ip=101.71.155.101; helo=mail-m155101.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jc5713L6Qz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 20:47:40 +1100 (AEDT)
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5655b08a2;
	Sat, 28 Nov 2026 17:47:20 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: chleroy@kernel.org,
	tglx@kernel.org,
	bigeasy@linutronix.de
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] soc: fsl: qbman: Disable manual unbind of portal devices
Date: Sat, 28 Nov 2026 17:47:19 +0800
Message-ID: <20261128-f81b700d6c-u20-0@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa2218d563403a1kunmfc8b67a04521ef
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTUxDVklKGkpLGBlKTkgeSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=XSyB9HZBF9Wszkd4nB72AD7wt4WFkjetS6+r8AYSVq3AHkqutc7PkJNK+60hUQzwaJHzHJk3Cc6vvW+ChX5lo8JaKBKnhDdg8DZipSaaZAX8avmPRl3LNKk7PB9r4Prw8QSbI1KltVgtoZZ0UUr9ghMF47zZUcTXsdrQICIBMDI=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=tvDL+JTCd3LfYoIRrkmZFykqOvWNjnWdVwHIkVn2/M0=;
	h=date:mime-version:subject:message-id:from;
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Keep the BMan and QMan portal devices bound while their facilities
remain registered.

Guangshuo Li (2):
  soc: fsl: qbman: Disable manual unbind of BMan portals
  soc: fsl: qbman: Disable manual unbind of QMan portals

base-commit: 9592e3c9af2c97cd7220c22ecab97e0875a0f51a

