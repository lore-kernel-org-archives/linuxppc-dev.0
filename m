Return-Path: <linuxppc-dev+bounces-23406-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B7DC43327
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 14:16:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grf7g5t0lz2yqx;
	Fri, 03 Jul 2026 00:16:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783001775;
	cv=none; b=e7Qa/OA7xWDlcdJ77x1Qlh+aXyr+7q9FrJBujYxDDp+tWTNNeA1lkK2R8G2Gd2V5yaDvXYGYX65/ky13NUJRX1w7fktWd1x+q3I9tOnq+xLotbDmmq01y26dntshVSh1N7IMI6OnUs9gBH+1MiJyzUyg1ZKRcTrtPz6a0yPpsz9CsmcTyNXlIothk0aR8msGzPl2vJ14DTfj2pLdzdCvmYjRInjJMQJ0VlZmG636rTkaIspMWuYb9TqzX1Jcro5RUWByPMX/CZw1fRN2aiX+9eg8VfOpp+xIZZqcApKNyTB/J6pDAhkXA5hvMr/hFySDjV1konVI46SeK5e1IWKAyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783001775; c=relaxed/relaxed;
	bh=e3BBWFg4iK35Io0mWwz6AFuN2Kg8RozrlNCNxnwewCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bvmGsMFpcz0rRI8n2VRqAY3a5VDfpiCO2nLe2+bqPd5hR1vaFJHu9P0UmgEoYzNlpM8L9PG3KgvHHvp2IA1wBkQs0Pg5D8mVNJI2jOm5RA/ytJZpDkrTXPs96v/6Z4KLJhUhZ6fSwMGns9G6/Xvz0QG/NKy8MiVGcJhujBdMMaOBtGKeKBpxgcKvaW1qiigH1Tgtj5RSY3K0AH4LRUf8kZrsHMAywPo6V6WhOMv9LFTM1qkGZQX+cFdSaxUGOPXZB+pMOSMQdcyPStBmTD9zIoowddTdCPBe8wY7kdgF9QCHqf42ojrrGkYOEepwwxRRvO/nNXwCdLd6bRswMvAnuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CeTm1IOt; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CeTm1IOt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=johan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grf7d2LBsz2ydj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 00:16:13 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4659F436D3;
	Thu,  2 Jul 2026 14:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0E91F00A3F;
	Thu,  2 Jul 2026 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783001769;
	bh=e3BBWFg4iK35Io0mWwz6AFuN2Kg8RozrlNCNxnwewCk=;
	h=From:To:Cc:Subject:Date;
	b=CeTm1IOtg3mWxAfxKJOs5Ift8DnN5IwEftP2qWlbYCmM6yr4wavV5L9mn+UxmYxH8
	 2MS6SVPTKiSB0dAQWosVBEbY/HYftYviLEJejjAybuINPF3s9z4qB4q41Fwxs1ogCO
	 XTXcthnLeNsSTycXttYbxPvNoiHFhbZVN4q5YfqO4Ku1Fl2oqnzw/qMVa10XookU+p
	 DWKFmG+3d9knlYCRC+p6XY7cIuWrq1fzB5eULqLqqBKRD2htUBuFhvs+Knwg2/vYii
	 m9Il7CAdQux6hirlC1RxRuk7DkvLeTcFhImzQJmzUasqa34Z+RoZXrpagzUPDCnIup
	 JvN4ZIN+qmgrw==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wfID0-00000000NeY-2daO;
	Thu, 02 Jul 2026 16:16:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/4] USB: gadget: fix device name leaks
Date: Thu,  2 Jul 2026 16:15:32 +0200
Message-ID: <20260702141536.90887-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series fixes a couple of device name leaks in udc driver error
paths due to left-over code.

Included is also a related fix for a fsl driver dev_printk() conversion
which ended up using the wrong struct device, and a related remove()
cleanup for the same driver.

Johan


Johan Hovold (4):
  USB: gadget: fsl-udc: fix device name leak on probe failure
  USB: gadget: snps-udc: fix device name leak on probe failure
  USB: gadget: fsl-udc: fix dev_printk() device
  USB: gadget: fsl-udc: drop misleading unbind sanity check

 drivers/usb/gadget/udc/fsl_udc_core.c  | 99 +++++++++++---------------
 drivers/usb/gadget/udc/fsl_usb2_udc.h  |  1 +
 drivers/usb/gadget/udc/snps_udc_core.c |  1 -
 3 files changed, 43 insertions(+), 58 deletions(-)

-- 
2.53.0


