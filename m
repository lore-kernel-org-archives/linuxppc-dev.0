Return-Path: <linuxppc-dev+bounces-26457-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BE7C61DD6
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2026 03:10:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hb4NQ0SwPz2y2W;
	Thu, 03 Sep 2026 13:10:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788405029;
	cv=none; b=ZklpLOIEDwgB3ruRj6isT3N8JlDS7Ya1qll2WUBXROlxDyd8ZJaG/Hhw9/qNhOFm/4ljy0WmBfMLkEUN9b1Xpyp/ajZgT1gcORxcIsKcj3QrfQkDXRXkKOlH/isgA1D1Mv2OU0kkbvDmXcEpr8raT1TW36E/JhftUsdsCk2b6onp40rcKEeZazPtMIfHhLZLT3gdIV5OXTxv8l8pRVbhOWggqRtIomxUl+gRzPqNNQd7NZJX1nv480dzz2SjZZE/CSGqk3eevPfvbRl1Zvmvm0KcMIPs9xESSl2auk1kVHnUidOdCiy0V1cZYYUXWl2ENQR7SzxH+ym8BakQajwFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788405029; c=relaxed/relaxed;
	bh=piM931iS3QcfCvF/iNCzNGuy1jpOOsm4i5NMdfyql7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KJhin+MAdhBGNWT7dhRb/Ozp+uJMQMHWAUEci/mLcD2z4awiFQG3lwoCrLxaQkAcn6S+Q5eDOeVdD67Nj0+BUg9ZX38QWp4lUNeDx2qKKGnAdRnIJ/3b8TrEYGDV4WcPB6/XBMoM2NAKDy//i/VbNR2G6bBqk3r9DtnLuxOidFAokVvAiHhhZurH02heNc5K8suQflNPyjfIhlVx47cvmRSCoLQrZAmrQgyyCX00l/JGP/oBkPzDehTJkDrSs3gooSzOwLD0igSFeC1ZExQ8xUJkA3ki6ZuyHODS3zOeiS7pImnxjjOKZgNTxgFFyZFuaEAPPwUwAA031BsanjzkIQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pqx/rl34; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mkp@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pqx/rl34;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mkp@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hb4NP33b3z2y2Q
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 13:10:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 00E7543239;
	Thu,  3 Sep 2026 03:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8061F000E9;
	Thu,  3 Sep 2026 03:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788405026;
	bh=piM931iS3QcfCvF/iNCzNGuy1jpOOsm4i5NMdfyql7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pqx/rl34GXIy2YUVQIAN8KcHzRqFCKapNXV1jX4PRub8FPpiWJe3GPRjv0nqjy3Li
	 oGUWKRwiqghdEnN315R1fxtCUjwW58jttnYawIWL4ZfZyGXSKW6Y6zSNJam7XEsoNQ
	 rNZcb9mx60taj89JBpVXLZhjOEB4LW7RNYtOmGs5yqNzZofqHt3qcn/18bYCHBBqnI
	 Gktdmtn44aLWnBO2UXc/FnTSQMRRmjCArGZ/knNvlpLGLrUsoBnBaRJb+TeXZfe+hJ
	 JAgJhIFTXIEQ01DVh58ybiI3SuHijVm2elKoWWH6lL4NbOv6oR+JWiCnaQC6mfO2RV
	 kHbOf32YGsLcQ==
From: "Martin K. Petersen (Oracle)" <mkp@kernel.org>
To: Tyrel Datwyler <tyreld@linux.ibm.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	Muhammad Falak R Wani <falakreyaz@gmail.com>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	Christophe Leroy <chleroy@kernel.org>
Subject: Re: [PATCH 1/2] scsi: ibmvfc: fix kernel-doc name for ibmvfc_scsi_relogin()
Date: Wed,  2 Sep 2026 23:10:06 -0400
Message-ID: <178840472584.670675.12007008371974390707.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <dd866cf2321381694af027fbd726bcbd63ac3751.1787828961.git.falakreyaz@gmail.com>
References: <dd866cf2321381694af027fbd726bcbd63ac3751.1787828961.git.falakreyaz@gmail.com>
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

On Thu, 27 Aug 2026 16:50:37 +0530, Muhammad Falak R Wani wrote:

> Commit e0fca728a89f ("scsi: ibmvfc: delete NVMe/FC targets as well as
> SCSI") renamed ibmvfc_relogin() to ibmvfc_scsi_relogin() but left the
> kernel-doc comment referring to the old name, so a W=1 build warns:
> 
>   drivers/scsi/ibmvscsi/ibmvfc-core.c:1901: warning: expecting prototype
>   for ibmvfc_relogin(). Prototype was for ibmvfc_scsi_relogin() instead
> 
> [...]

Applied to 7.3/scsi-fixes, thanks!

[1/2] scsi: ibmvfc: fix kernel-doc name for ibmvfc_scsi_relogin()
      https://git.kernel.org/mkp/scsi/c/9a0716348daf
[2/2] scsi: ibmvfc: document protocol parameter of ibmvfc_alloc_target()
      https://git.kernel.org/mkp/scsi/c/9a69cc5f192f

-- 
Martin K. Petersen

