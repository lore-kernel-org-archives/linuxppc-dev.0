Return-Path: <linuxppc-dev+bounces-25793-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B40C5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 06:29:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLFnc6DzKz2y1Y;
	Thu, 13 Aug 2026 16:29:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786602564;
	cv=none; b=Q8dgFO4tcvRtSffa9tyNZa1L9hYGG2dvz82vCXw27Jl4rllmbnVEVEy1md+bLd5nIqS90fYq8WyfzuEORNxx9LBuEJhK4+jL33LJT4drmXY+OjYtwVeUqAkhaCavL7uVHM6zg1slraifhyS1mwGCJnPxorTuoXhYot+4YGEnwhS5k3seh06sj5L+cxkbwMl7AsyAevJ8QDiRS9wRoGA8EqFDckpyQyKk0qGBZYiEGSw+8KKiaOPn2oMeC4qKGg8+TFpTr5mrsTqZoumXHjmsqyYFNCltLfb8VSYJ8VQihHl6csZ8B8vI6MCfDaExLyt6uHwmDfH3gmGwAHSqrRAqfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786602564; c=relaxed/relaxed;
	bh=W9hHTx58UhJf0sGWMCZg9Dl1k5hi+Pxe/sKTM8zntEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F5z8uMaroZyr+Bl7RiFGHT5usFvw3uu8X9Eu5RT5vd1htAWdeWNiVyAJAPJ8YAZKRIy9Zeo7U8Sn8zV741LNy6m233M67datW2K4TflykyVA/I24DG7OupAmqgYdOnhMRM6REWALphMpuA2+VhFjdJZozo6G3VdUj2aMuOeJKjEgmdMSLE0Qqe8dauSppo+Z01879l53cZokOGUIWywYnWL6cFjGgHW1zp5EE0MOzrFzFGahIUaSii3JjSuvTxCIOXwWSHUG8S5tpXODYmOTChBSC03Qqo4MRJGg4PXQLyylDj4AOn1RKWs/0+XRc0aVkgvlOkjQ5fwNI7ZchpPViw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=yijiangshan@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=yijiangshan@kylinos.cn; receiver=lists.ozlabs.org)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLFnY4w7Nz2xd5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 16:29:20 +1000 (AEST)
X-UUID: 269bb85c96e011f1aa26b74ffac11d73-20260813
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:5456b1cd-6a67-4246-911d-aa12ad159f68,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:4a3af7f8a64260c916fce2ac9a7c506c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|136|850|865|898,TC:nil,Cont
	ent:0|15|50,EDM:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 269bb85c96e011f1aa26b74ffac11d73-20260813
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1248262031; Thu, 13 Aug 2026 14:28:08 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: chleroy@kernel.org
Cc: 13667453960@163.com,
	gcwilson@linux.ibm.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	nayna@linux.ibm.com,
	npiggin@gmail.com,
	yijiangshan@kylinos.cn
Subject: Re: Re: [PATCH] powerpc/pseries/pci: Fix misleading VF limit error message
Date: Thu, 13 Aug 2026 14:28:06 +0800
Message-Id: <20260813062806.390959-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0798e7f0-47fb-4cd1-9963-5b22f6564e03@kernel.org>
References: <0798e7f0-47fb-4cd1-9963-5b22f6564e03@kernel.org>
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

> What about the following instead, to avoid the double 'if' ?

Hi Christophe,

Thanks for the review.  I've reworked the patch as you suggested in v2: the
two checks are now in separate blocks, each reporting its own limit
before returning -EINVAL.  The PE mapping limit message now appears
only when that cap is the binding constraint.

Best regards,
Jiangshan Yi

