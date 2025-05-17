Return-Path: <linuxppc-dev+bounces-8633-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DDFC2D0CD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 May 2025 22:20:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b0JLG4vr6z2xpl;
	Sun, 18 May 2025 08:20:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=93.17.236.30
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1747520438;
	cv=none; b=QPiJSd37N56ef/eJISnUEBUYnDK5nbZETUVralTCcx3Dl/kzGdFgfhPf84qQEWeLCYviYoKhl9P1Pd/rzxGaEAPOpKhKEKSmANcyUbg2Mk+6BeM7dWJBnzCozch0GZC5DXEtKHcLGaFHGKGkhckdENOeKccMjOG640jZ3TI/2nNuz4/ELw407birF5bmB/4+L17z3Js4eBb0fiTPRNJktWoZzOhjc54+yt1aQ/pEDsJU904j9f4ZshoECiskIK6nr9cciAdsx6wgZFZz6vMwHHHcWwaS0+7pwL8rIEbCAb8GldTRxhOYiYlIwIaG3lw0c1X11SqS0yySfiMNovMBdA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1747520438; c=relaxed/relaxed;
	bh=8kpdlOkhKLJi+9AUsKtHrnMo/d6kPO/afkht0Jg6Xz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnUr8y60J0gj5SNg1IxsSthYy5EEzqbw6QhxzoJ18bR1z88J3EDyD+fKa++yOihPsot1iiMwiIWasKfTlEH/284R9Gd8V04XQgBDidpFg4Ge6T94Zv1Rox8btYVxUKFtNbZSJzZZ+zGONNNft34Zp6Wen4x6fGHs2eVtM4fPesrpxDMYGiU4Nz+0i6Du77HmAMT2w038E32hJYTFKSgj1K8Hv1kRWpabgXiVWag8ftwEQU1c+s0+H4RNf5z4PUheKbV7efQb7jIduiqyvIPyzqGmphAvZA3+43giSifWqGzHFVjF8p1ldt0mJbZ/sPD/Ga1AIZbiDI/7ewDkMfpUhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass (client-ip=93.17.236.30; helo=pegase1.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org) smtp.mailfrom=csgroup.eu
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr; envelope-from=christophe.leroy@csgroup.eu; receiver=lists.ozlabs.org)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by lists.ozlabs.org (Postfix) with ESMTP id 4b0JLF6n3tz2xlL
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 May 2025 08:20:36 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4b00Lx0r2Tz9sXD;
	Sat, 17 May 2025 12:20:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gVS1VMTT4htB; Sat, 17 May 2025 12:20:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4b00Lw3mgPz9sWb;
	Sat, 17 May 2025 12:20:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7B3A08B76C;
	Sat, 17 May 2025 12:20:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id sX0Ibc-wRh9m; Sat, 17 May 2025 12:20:08 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 43AE28B767;
	Sat, 17 May 2025 12:20:08 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
	by PO20335.IDSI0.si.c-s.fr (8.18.1/8.17.1) with ESMTPS id 54HAK0O0013281
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 May 2025 12:20:00 +0200
Received: (from chleroy@localhost)
	by PO20335.IDSI0.si.c-s.fr (8.18.1/8.18.1/Submit) id 54HAJwrv013273;
	Sat, 17 May 2025 12:19:58 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: linuxppc-dev@lists.ozlabs.org, Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/6] bus: fsl-mc: cleanup and fixes
Date: Sat, 17 May 2025 12:19:34 +0200
Message-ID: <174747706456.12970.12343198845578561445.b4-ty@csgroup.eu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250408105814.2837951-1-ioana.ciornei@nxp.com>
References: <20250408105814.2837951-1-ioana.ciornei@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747477178; l=1260; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=lsoOGwliJXxgH2wrZilH+358d6nah7lpYkRKmBU9ILU=; b=rsItyETdUBXri2W9kvI4O5P8MQjnJFTnGPtGvyYgaxJagDZAJ7ycDlVs1tGeZSK3mpHeXEYHQ 9RGdeaf19x/DtPlSB7NnXS+63OjnqS+B835eigSXy4DMCpbMz0VvXpa
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit


On Tue, 08 Apr 2025 13:58:08 +0300, Ioana Ciornei wrote:
> This patch set is a combination of small fixes and some cleanup.  Some
> of the patches were already submitted in the past years but were lost in
> the process due to an uncertain maintenance path.
> 
> Ioana Ciornei (3):
>   bus: fsl-mc: fix double-free on mc_dev
>   bus: fsl-mc: do not add a device-link for the UAPI used DPMCP device
>   bus: fsl-mc: add the dprc_get_mem() command to the whitelist
> 
> [...]

Applied, thanks!

[1/6] bus: fsl-mc: fix double-free on mc_dev
      commit: d694bf8a9acdbd061596f3e7549bc8cb70750a60
[2/6] bus: fsl-mc: do not add a device-link for the UAPI used DPMCP device
      commit: dd7d8e012b23de158ca0188239c7a1f2a83b4484
[3/6] bus: fsl-mc: fix GET/SET_TAILDROP command ids
      commit: c78230ad34f82c6c0e0e986865073aeeef1f5d30
[4/6] bus: fsl-mc: add the dprc_get_mem() command to the whitelist
      commit: a8c17b9cbf87cb9d98d501a16a47e5fe5839e855
[5/6] bus: fsl-mc: drop useless cleanup
      commit: a941bed23c9473665c773453f8a835668af070bf
[6/6] bus: fsl-mc: increase MC_CMD_COMPLETION_TIMEOUT_MS value
      commit: 23d060136841c58c2f9ee8c08ad945d1879ead4b

Best regards,
-- 
Christophe Leroy <christophe.leroy@csgroup.eu>

