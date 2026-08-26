Return-Path: <linuxppc-dev+bounces-26118-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419CDC5DF97
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 15:20:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVSyX1pstz2y32;
	Thu, 27 Aug 2026 01:20:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787757636;
	cv=none; b=YtnHgFYc7G3wFHxAFSKhIZnSI9osvm8kMqI27Srq54291uPgWpb5BQ0oESzh/1VNI1bUiaiH/tFjg2WoW/Ri5VfR/UnVPiW7ChKgmMTRaXGtKhTMf8LMohvwsQQIF7jfs7Ui3X+LYQ3gzsWeDfCqFmRTUzYoLKyU7BosQR6cUhi4/nRqH8NmDGWEnjjpJ+VI71Lz61g61jqNVMM5zU9IlblhFGFa+cO3m93b+pzBl9VIlv+8+3WeEnI+6Yde50axtM2cwtWZiQG9ptBww1JyGZ/aLtxMxs17dD6cSYiUXy7dXBZVuGY2fVmuckYKnZNtz6/5L/mVjLBQLmfTg0hX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787757636; c=relaxed/relaxed;
	bh=jphUJK5ZLwWhd53YVv8V3auiihN0qXdGkXQ/u22obuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WheMjINUBM2xla6qxPktusswXDS3+SQkEE6A9sorDvdBwFHMY2fiKfvolnFUkJ0nhzijoM64cUzSEf3KPv4rw5zkr53M9kPONxiYce9xJ62s+Ad7PhYGOL1Uq3dX9YV6DnTCfgqyLhlCGlkHF4CAi6cjVPA/fRKD5JTXyGQRrJV68bss3aP06E3XMc5zKc5mku2BfDEUkegqw/pK/A6rvFDjRb7had/gvjnHnt6Nti/7hT5o31pFax6LUOAGnuve+E8noFdToh+4op0Ev7VzEnQFS7lLwoTJ6DD0K4idKVlGAKC1rXb/v3hO9zSIH1v5LW5iSjQm1DlEa3z/ZTzJ+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fx3bvxtz; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mkp@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fx3bvxtz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mkp@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVSyW3TyYz2xLG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 01:20:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1696E44F61;
	Wed, 26 Aug 2026 15:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2C81F000E9;
	Wed, 26 Aug 2026 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757630;
	bh=jphUJK5ZLwWhd53YVv8V3auiihN0qXdGkXQ/u22obuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fx3bvxtzS5GgNrpwzQMQcUPkTAeBiPImutCpd9MnxyQA129wS/1eSoGf22q6QcBTY
	 Dv3OFGrewibtUjZmcRVSsVDAxzHIvGBGPHcrAxu9Zww0ZnIlUm1jqpAisyOZt3jhjl
	 unhBtkXq2gE0ogtSianvkXeDWOZ4xKt6KTQQR0AI481QcLKu6qqa1LAIM3J97azsQ/
	 J3cBqRHqdtO48kA+Z4esT96ekTREfAWnNlBP7JJ+g7ksxQFJW4MadicVurYwRsDq+h
	 QLotvRFjwYUXMk0uBOTx6gLI43sj1WclMeGEIms//JQOP48Fz9I3caIrQdy+KHeV/R
	 UKPCyWL4WOg4A==
From: "Martin K. Petersen (Oracle)" <mkp@kernel.org>
To: Tyrel Datwyler <tyreld@linux.ibm.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: ibmvfc: Fix use of uninitialized rport in ibmvfc_do_work()
Date: Wed, 26 Aug 2026 11:20:15 -0400
Message-ID: <178775714066.3862282.8143552367405042697.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817-ibmvscsi-rport-wuninitialized-v1-1-0fdfb27a5f01@kernel.org>
References: <20260817-ibmvscsi-rport-wuninitialized-v1-1-0fdfb27a5f01@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 17 Aug 2026 12:04:55 -0700, Nathan Chancellor wrote:

> After commit 696d1cc2aaa2 ("scsi: ibmvfc: process NVMe/FC rports in work
> thread"), clang warns (or errors with CONFIG_WERROR=y / W=e):
> 
>   drivers/scsi/ibmvscsi/ibmvfc-core.c:6154:15: error: variable 'rport' is uninitialized when used here [-Werror,-Wuninitialized]
>    6154 |                         } else if (rport && tgt->action == IBMVFC_TGT_ACTION_DEL_AND_LOGOUT_RPORT) {
>         |                                    ^~~~~
> 
> [...]

Applied to 7.3/scsi-queue, thanks!

[1/1] scsi: ibmvfc: Fix use of uninitialized rport in ibmvfc_do_work()
      https://git.kernel.org/mkp/scsi/c/b79b88b655a8

-- 
Martin K. Petersen

