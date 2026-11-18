Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7D8606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=Nu9xI0eI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV4S41dqVz2xdX;
	Thu, 19 Nov 2026 01:56:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795011376;
	cv=none; b=HZgI7J+twr3QCOZfVrkIdn+5LjAbID5Un/UfwHU+aqr3KPCte7IGU5qfg4f5XsAJyxPLYhTMziGNuVL6DCsMIN7p4ILo3IIojQkWA1U+mwOngg0hdpPTRfjB7fLrGW6o1ToDUPzTWQupMRud0y6bRDOlwq1gbXEzlEagrYwxZMpW29hgO8YK2t3Mk9aOCjKU+N6m2Ta3mB/pfsq48pXSV5K/tO+PmWBSLGsGJrQm1wMbUBr2NKlbLzXPjPbgZHwjlkTlK25crWQCbqwZeHcCcarRzD7xtM6gTbJ+mgnahJ+O0I0b8B6jOHuwyFMmzz6k1YJvg7b4aazD+cz7L4Cvzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795011376; c=relaxed/relaxed;
	bh=1gDHZMUCCewryu/nDd6CsJfzmb7PXvi882IklzMUwSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jSPQ1CFiCYk0Vt49eugDVQFrcMg0Z2cWXuijI8rZn6aI3dFgvqeGQHkfe0jVHD5aLsF3ui/zADIhM6aZ159XA4yUAVOhh3/x2rI8By+IedFzJWmt7bmh7rdywWoQfXxNUeCnhew7l33k2cnOTp3XryGHZyU/+jN+0K5iJuEZ7202kaX3iJKZs0n4cbgAqU6OzGfvhPdlzFc0XijEveFeunI/epLK0OXEePQNxtePs1EFc2VxiVTm0LMzGz6bYqOz+gHkVXDSdCnDccjX0/l4nVIc45VtdFaaDp5Lpk7dJhePc1s5UheKHtSiJ8/W5l04xvyVYxzYJsOwot7DnJ5Nhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=Nu9xI0eI; dkim-atps=neutral; spf=pass (client-ip=101.71.155.101; helo=mail-m155101.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=Nu9xI0eI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mail.sdu.edu.cn (client-ip=101.71.155.101; helo=mail-m155101.qiye.163.com; envelope-from=liguangshuo@mail.sdu.edu.cn; receiver=lists.ozlabs.org)
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV3YL3N89z2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 01:16:05 +1100 (AEDT)
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5526d77c8;
	Wed, 18 Nov 2026 22:08:59 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] usb: gadget: Correct cleanup ordering on failure and removal
Date: Wed, 18 Nov 2026 22:08:59 +0800
Message-ID: <20261118-324f82bd41-usb-gadget-0@mail.sdu.edu.cn>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1eefd4bc503a1kunm567c06bc1a093d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGU1PVk8eHx0aHRkeSx5NQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=Nu9xI0eIMxZMfpmfnThgph1YQz1bvoH9LRP3ku4c0o6nm1Y2a+c/f0vmK2eAKT9zvZ4V1I64FQpIRR4Pms5iKBDIK0yMODnoU+R7yFFmJrOWFPjlxwya+VruwsNZbIT3Sy+0fmmlDXUZ5DdvFew29sRlyoWbRYBdC8/rly7DPK0=; c=relaxed/relaxed; s=default; d=mail.sdu.edu.cn; v=1;
	bh=1gDHZMUCCewryu/nDd6CsJfzmb7PXvi882IklzMUwSE=;
	h=date:mime-version:subject:message-id:from;
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Keep the FSL controller alive through removal and detach the Nokia
functions from their configuration before dropping their references.

Guangshuo Li (2):
  usb: gadget: fsl_udc: Fix potential use-after-free during removal
  usb: gadget: nokia: Fix potential use-after-free on bind failure

 drivers/usb/gadget/legacy/nokia.c     | 4 ++++
 drivers/usb/gadget/udc/fsl_udc_core.c | 2 ++
 2 files changed, 6 insertions(+)

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0


