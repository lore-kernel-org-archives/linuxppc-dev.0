Return-Path: <linuxppc-dev+bounces-26056-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EEAC5DF97
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Aug 2026 01:39:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hStrR34TYz2y2P;
	Mon, 24 Aug 2026 11:39:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787535591;
	cv=none; b=IgzDnQhLUiuuRmNv4XEoPV5aHHmD81Wi/O43W8clLwqW+oAvEQegUrPYU2e7bv/ATifYrM6CBJ63jvauUgpD1CyP1yUPotqjh9b7dhMGUzcQQ7UwbXFuuiwhi6teeZHg7DXY6CI3zy/OcGYDw0b6P1KljhMA09h5LCcWqK1PxYHBRZvdGnyT1f/CCCAli2CwciIcISwa251IFshDV6kM+EXi20UiLtwGFtN9bZTKcFQCPmJ1s+KOdmivB3oO9eJgSffblQk4lCStbU3vgOW2YSiU41kPYqVF2/IHNbbmpi3pxsh0jdRoent+58hsBcDYNlmOd7B1TD3MwqDdvjhEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787535591; c=relaxed/relaxed;
	bh=MosCNLmX0s2XDvXfNC2OyDh+Zo8xsRa5ojo/fMl0hy8=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 MIME-Version:Content-Type; b=FImqsexRJMLNcs7QEKQo9XSQCK4aAA/Ciwj6tmBzPfi1y+6Oehqhxk/lIAFI7HD53IiixKyg6iaXdwLVhv9uVf7hNVZBGkRKZCrIG3FNx7OoBEHIxmiu0hT4qBySWCaKHwY1JWXRt6IRZsQ40mSbX+Whs6hJVXc9CJhDiV0aCimyFgOJIW1e9XRzbCrLphGNGYNBKUqQVPSt2LODj6X1ocX2lNmwd0gsxRW1Tu1FCdbTDsW+xMSq1dLH3H6SZv2109frYCoDesLWOpAFPbWTrM+91QZK6AAGbCTu+9DZ70En5Umgw/kflFbuj/V14XSPuD9sgvXUw/ReTscmj4sMpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NZhVm8sq; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mkp@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NZhVm8sq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mkp@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hStrQ2sWpz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2026 11:39:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D2AC642A7A;
	Mon, 24 Aug 2026 01:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3651F000E9;
	Mon, 24 Aug 2026 01:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787535587;
	bh=MosCNLmX0s2XDvXfNC2OyDh+Zo8xsRa5ojo/fMl0hy8=;
	h=To:Cc:Subject:From:In-Reply-To:References:Date;
	b=NZhVm8sq44pfCM0iA5RY4WivhOAFFzwhMV+PvK+JKk0IBNFwfY6jgDNmMqttbKUA2
	 nTmNtlab2bUnjO0abWGu8Bj+Q8Dw4ijndHuStONCqbuJS2sAp4R7UGaF0fNSFuyDQB
	 RimFTG69PI7Z/QeLZOSgZLpRa/JgUXBJdKF7nBA6aOcCL7i5RyLiw9JQftGx7CwhXH
	 ex7IdA3VX8SAdJWQxII8XGl9zX0/PmMUVUhOPfjK2laHlgcZIMSPr5Q7UH3pzVAXsh
	 15g5U7zzpruy19DrqYrLQWF8kD9gZFDkcKytU4f/BLwvUgxaMUBhWHRDHw7KZrA7+i
	 WN/ZRFMCB/hPA==
To: Nathan Chancellor <nathan@kernel.org>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>,  "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,  "Martin K. Petersen"
 <martin.petersen@oracle.com>,  linux-scsi@vger.kernel.org,
  linuxppc-dev@lists.ozlabs.org,  linux-kernel@vger.kernel.org,
  llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: ibmvfc: Fix use of uninitialized rport in
 ibmvfc_do_work()
From: "Martin K. Petersen (Oracle)" <mkp@kernel.org>
In-Reply-To: <20260817-ibmvscsi-rport-wuninitialized-v1-1-0fdfb27a5f01@kernel.org>
	(Nathan Chancellor's message of "Mon, 17 Aug 2026 12:04:55 -0700")
Message-ID: <yq1h5kkpa95.fsf@mail.kernel.org>
References: <20260817-ibmvscsi-rport-wuninitialized-v1-1-0fdfb27a5f01@kernel.org>
Date: Sun, 23 Aug 2026 21:39:46 -0400
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


Nathan,

> After commit 696d1cc2aaa2 ("scsi: ibmvfc: process NVMe/FC rports in
> work thread"), clang warns (or errors with CONFIG_WERROR=y / W=e):

Applied to 7.3/scsi-staging, thanks!

-- 
Martin K. Petersen

