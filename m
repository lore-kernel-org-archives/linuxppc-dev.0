Return-Path: <linuxppc-dev+bounces-26174-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3117C61DB9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Aug 2026 01:38:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hWyb32ksTz2xd5;
	Sat, 29 Aug 2026 11:38:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787967535;
	cv=none; b=WGCLIivrm4BnzgKBB4db4cVHcIDysQ9vF5edNU+tnl6Act50gJwAEiZm61ZJWeBczFhdCB5d+wz9eWpjlJUnQCGevRKkc/KDE1CZq00ipqJ6bOUyn+leVWGXTCPUBW7LdpNgytkYwDI83R/AjIV86ELQ5QZckKKENvVWD5f6p8WyZK+3AS/qEhh32GCYh5yZAJ659c7KUvIrq9pQfxNd+oZ4jAJRJoy/wx4Nh0UEKO68b90IumobBQkqRQsQAEVWMGI4PQnilnPTA26OK25X7VM+t7RhjKAd+2K4egCXr3jzypaqSABS6Ns1YXLrlLOc/Jbk2LbpE49K6E47We4Dlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787967535; c=relaxed/relaxed;
	bh=Re5XvAwgWVCTWF6fMwZLKtrKt/jem97G2EA9JnlFwmI=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 MIME-Version:Content-Type; b=Lfi22QolTQMjYYHI9WvOFGQI5eQeoYXxwCI/U1zH0E7Y6vANCtGR0UdSlHwBtz5ZhTDbzipVVMSjkNnF11HCHBP4FqDXOK5LcQrbwuGTeLxhy7J67RIXT2SjluJ2+TRhCPD7NSuCBsZr/ZrNiJpLiTQm29S/QAE7hCqgjm90cWQB/0lOEB2Ffl878bCPhNq41Qx883G6jDUapd+cr8syYiBo/7ivsarUgtPlKr4ruRk4MrrsANc80Uc8U62sgAg0Tvta3CK3FsfilAHHrAe6uVuy12PXjoRTBEtY6amVSpxlZlrQg65MmEvfIeWOyPp84QF3AqMDWRboZqwBxAuMQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TxrPC0Mo; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mkp@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TxrPC0Mo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mkp@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hWyb21nc8z2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2026 11:38:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B8E6960A62;
	Sat, 29 Aug 2026 01:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C68D1F000E9;
	Sat, 29 Aug 2026 01:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787967530;
	bh=Re5XvAwgWVCTWF6fMwZLKtrKt/jem97G2EA9JnlFwmI=;
	h=To:Cc:Subject:From:In-Reply-To:References:Date;
	b=TxrPC0MoowBBxNbDPzizuShZJUAhUDes11AHvVeqrQE/L4mPweY+iHKvZG8vuxCwy
	 kjtJwIDr2nwIVLUa95JjXx+Qv9RcFqUppemb1ZuBveijzNpee0bEJS+8ZAEdD+hRAq
	 +H6H3+umOXAkpjC7+hvOE88Xv59UdygH3LGHWV4VjWYC3gOBetdz/SIenC1+cELb1u
	 asepSuFrHhN8Q4sDJ2M34JI9cEt2OGZA2Dsczi59+RE6JGuHFrQEZTq8/0RsFUb7Ee
	 Huz/9TFhFOcM9M5VV7sJgUriGsR7C8U2htuQXhvB6wOqKDnbE0gZUeRMN06ass5Jwv
	 3JqF8j7foEgWQ==
To: Muhammad Falak R Wani <falakreyaz@gmail.com>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>,  "Martin K. Petersen"
 <martin.petersen@oracle.com>,  "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,  linux-scsi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel test robot <lkp@intel.com>,
  Madhavan Srinivasan <maddy@linux.ibm.com>,  Michael Ellerman
 <mpe@ellerman.id.au>,  Nicholas Piggin <npiggin@gmail.com>,  Christophe
 Leroy <christophe.leroy@csgroup.eu>,  linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] scsi: ibmvfc: fix kernel-doc name for
 ibmvfc_scsi_relogin()
From: "Martin K. Petersen (Oracle)" <mkp@kernel.org>
In-Reply-To: <dd866cf2321381694af027fbd726bcbd63ac3751.1787828961.git.falakreyaz@gmail.com>
	(Muhammad Falak R. Wani's message of "Thu, 27 Aug 2026 16:50:37
	+0530")
Message-ID: <yq1cxv1k8o3.fsf@mail.kernel.org>
References: <dd866cf2321381694af027fbd726bcbd63ac3751.1787828961.git.falakreyaz@gmail.com>
Date: Fri, 28 Aug 2026 21:38:49 -0400
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
Content-Type: text/plain


> Commit e0fca728a89f ("scsi: ibmvfc: delete NVMe/FC targets as well as
> SCSI") renamed ibmvfc_relogin() to ibmvfc_scsi_relogin() but left the
> kernel-doc comment referring to the old name, so a W=1 build warns:

Applied to 7.3/scsi-staging, thanks!

-- 
Martin K. Petersen

