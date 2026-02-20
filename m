Return-Path: <linuxppc-dev+bounces-16969-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C34C531FC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Feb 2026 04:10:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fHGxl4gh8z30GV;
	Fri, 20 Feb 2026 15:10:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771560635;
	cv=none; b=d66kjcvgfy085GxuKKk35UNHt2WSBNe5vue0v9t4J4ELkVZsV7IHmDPn/EFwW1m5mPYbPZYaJILYW0A3HnLLCAPJgF/JNG4DFBmEDU116ZFz0BgoSpubCDPniVhqUV5KUwyShZffuS/3UQkQxfYjNOHEcBsoSfgNX2aLtpqGxUUN8rK1YSpkC0VH/hjCMX4Ip85Dm7+6wexNQT9vDTWE1LrcQK22WPMLcucoQ6jhx8mUVoWKkPHV1zj0wTBaUy+4SJNls2Nfc0n3J9hGwBDVkhiYDUsqB6w9iLcoXwknFoWPU8rN7gxAZ74pf/TVRI4cTsFshf3WhGU+Sy7YOYNZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771560635; c=relaxed/relaxed;
	bh=QmGz/nz89BPlHPn/CEPU0KsA77OiPdkRUGBt8Jxsdoo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VA6uGeeRtgIxhXshhhJtl3+f9MDX/gkGF8Rs3CVYNouRqtOsro7bMxtbbudVQi4WHxFhDcB5qH4n6XLv8s7LbyQu5Cmq8X4GifQ0rf2pJa+64lcyRKz4CchrlZxa2u746GBsKdOBDHwJMQ/gjBC7mY9RBSHdhGKSHeAdaKuCSaUhyXBYUWV8Si4P9Bkfbplvv1jcnvTauI1ue60gSyQQ0BdGrGfT4NXWCb7cshTQFIEJcMWdew/ZhphxIJdq+FDJpuCLqKC67UMgfTMJJ+GHHwPj9+7EsvT6h3w3G9trRdwIqppHWrmY8OEtiwTSq8yY6DKtdFmR4ake2fThmWWMtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kTtK5AKZ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kTtK5AKZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fHGxk3HSNz2xpg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2026 15:10:34 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 84F376184E;
	Fri, 20 Feb 2026 04:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267C4C19421;
	Fri, 20 Feb 2026 04:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771560631;
	bh=YLLAbyGm0F9m0Mypc3ideA8QOvIO6kTmhd+3yWxkaE4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kTtK5AKZ1RD3Hd+Qxzib1YAeeESOC+72wxWtnIJN6iDEVUEIY7Rxl2ePuPiN/V5o/
	 k+rZIs9FvLnPIxPUWEwmtTWZePyqnygsvQ/oRArPOSMUQehN9ZmGNPzN/htt5J58Ai
	 qcfxI2WQy0ULly43wzvW5aObYdstSnWi5aOFUekprwhQS9sIRFzYU9aMBGM2c3HeI2
	 Zee+wtGMbpNJzghQBk7w0eK0VIxBPrxD2SptGPil48nFuUCxTHwCt5C3MokQ+6Oo4M
	 NnfGIuud5nhQXgIazdRPxlu5zrkOUi0ojKCNfxJMh6pEIcV6UUhN2bIxI3/yprxCQG
	 neCFLK/sxgU3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EF73809A88;
	Fri, 20 Feb 2026 04:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
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
Subject: Re: [PATCH v18 00/12] Support page table check on PowerPC
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177156063929.189817.18154815738132303149.git-patchwork-notify@kernel.org>
Date: Fri, 20 Feb 2026 04:10:39 +0000
References: 
 <20251219-pgtable_check_v18rebase-v18-0-755bc151a50b@linux.ibm.com>
In-Reply-To: 
 <20251219-pgtable_check_v18rebase-v18-0-755bc151a50b@linux.ibm.com>
To: Andrew Donnellan <ajd@linux.ibm.com>
Cc: linux-riscv@lists.infradead.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, pasha.tatashin@soleen.com,
 akpm@linux-foundation.org, maddy@linux.ibm.com, npiggin@gmail.com,
 rmclure@nvidia.com, chleroy@kernel.org, alex@ghiti.fr, x86@kernel.org,
 nicholas@linux.ibm.com, sweettea-kernel@dorminy.me,
 andrew+kernel@donnellan.id.au, ssrish@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Fri, 19 Dec 2025 04:09:32 +1100 you wrote:
> [I will be leaving IBM in about a month from now, and will also be on leave
> for most of that time starting tomorrow. I've cc'd my personal email, which
> I am going to use for any kernel development I do after I leave, and also
> Srish Srinivasan, who will be taking over some of my work.]
> 
> Support page table check on PowerPC. Page table check tracks the usage of
> of page table entries at each level to ensure that anonymous mappings have
> at most one writable consumer, and likewise that file-backed mappings are
> not simultaneously also anonymous mappings.
> 
> [...]

Here is the summary with links:
  - [v18,01/12] arm64/mm: Add addr parameter to __set_ptes_anysz()
    https://git.kernel.org/riscv/c/9ac4941aceb0
  - [v18,02/12] arm64/mm: Add addr parameter to __ptep_get_and_clear_anysz()
    https://git.kernel.org/riscv/c/ee329c29fde8
  - [v18,03/12] mm/page_table_check: Reinstate address parameter in [__]page_table_check_pud[s]_set()
    https://git.kernel.org/riscv/c/c4a0c5ff85b7
  - [v18,04/12] mm/page_table_check: Reinstate address parameter in [__]page_table_check_pmd[s]_set()
    https://git.kernel.org/riscv/c/6e2d8f9fc4ed
  - [v18,05/12] mm/page_table_check: Provide addr parameter to page_table_check_ptes_set()
    https://git.kernel.org/riscv/c/0a5ae4483177
  - [v18,06/12] mm/page_table_check: Reinstate address parameter in [__]page_table_check_pud_clear()
    https://git.kernel.org/riscv/c/2e6ac078ce5d
  - [v18,07/12] mm/page_table_check: Reinstate address parameter in [__]page_table_check_pmd_clear()
    (no matching commit)
  - [v18,08/12] mm/page_table_check: Reinstate address parameter in [__]page_table_check_pte_clear()
    (no matching commit)
  - [v18,09/12] mm: Provide address parameter to p{te,md,ud}_user_accessible_page()
    https://git.kernel.org/riscv/c/d79f9c9cf703
  - [v18,10/12] powerpc/mm: Implement *_user_accessible_page() for ptes
    https://git.kernel.org/riscv/c/2f5e576598c9
  - [v18,11/12] powerpc/mm: Use set_pte_at_unchecked() for internal usages
    https://git.kernel.org/riscv/c/2360f523a49b
  - [v18,12/12] powerpc/mm: Support page table check
    https://git.kernel.org/riscv/c/641d47d4c963

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



