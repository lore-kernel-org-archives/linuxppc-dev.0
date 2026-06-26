Return-Path: <linuxppc-dev+bounces-23004-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C7CCDE013
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 08:21:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmpY05vN4z2yfH;
	Fri, 26 Jun 2026 18:21:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782462084;
	cv=none; b=FGyeDGp+h7a38y3VxSXlK1Rj/7ga5DfcGhVrb2Uh2Z2dQ0R2qJKhfNceV5dcGg/cD3TSRYGaES4kjEnysvODN6b14+BouU+QCuh26weD1EDX+dwZXsJVmpSrOyL9nTVaFTY9RyJWOFTjEIwL8taUpBj7N5DNlLCnCsKx5B/MFXPpogbW0KaQrwgM8R0ODqiloDDAczCRkRSNFocEtK+fGUhCkXNcA8OCSyzoTMdHLeh/UY5s2AIHi+0ky6TiL0E9kn/nxRbkGz9U4ovj482h+sB656Lvn/QVvQnFLuRdYJksPhqs58MPod5c6Y9nZcAFeDkaRnVBaBGk45+4kHlp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782462084; c=relaxed/relaxed;
	bh=cnDZkcdojzG6TP+7FyMqVMauu4QrpFoQrKFZui4fel0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ais2pyYwcMw8EC04b2g5JpTSYTiZ3vhsgLTLV4pak+qrMeQnlWVSBx+AKJAHL2kj/K823gEqAiqhl2QSx50kvmC/6axdJwdkk07UeHxYErClZFluLzyyl5g7XNqCR0h3QLoQ8JfCdaUfoWkJghL2m1BV9PXCBf56rVBAeT/Fwrd+CWtfiYMzgAI8J4FsGytJViqzM0nnkILDG7iGBRUXUaDiZx+tE3RGHJrvy3S7YqrPCQQkmfrDDRGg10IppzedSKWNcNmrc+vTIYvhLonnMzvJddg7Rs8i/eMr0XlgHKpnvDc7M9DU+uTIXwvH+q2KQRDUpiREpriUcXq1w6T14g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MC6yAmsd; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MC6yAmsd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+linux-riscv@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmpY00Wcdz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 18:21:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 047B640A8E;
	Fri, 26 Jun 2026 08:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FFB1F00AC4;
	Fri, 26 Jun 2026 08:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462081;
	bh=cnDZkcdojzG6TP+7FyMqVMauu4QrpFoQrKFZui4fel0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MC6yAmsds/bx8R7anvknX1AQ8wYErykOAlLqPC3rBrW/haRJJv9chUhiwT+CvnTmN
	 khK/Dcw19LSCUFchb8D/hw+DpMaTb1XpLahGVWuQ2ovAXgjD87gIQurL0gIl9+xHit
	 ncTog7IyU918i0n0R2d/om837p9tvnVMwNZwfwlMdGa5QlmnH1j/rqWXUCSJ6gUh9Z
	 brR2GYKjb1zdGevtCBdmugxCTe8YRqU7Ur91VQYGPcJyxomzPIKGl4smPb/Yxi36dG
	 9lOJILFIUiOpBT1cUYSLvvKVEE9Xu8TR8Q7d0eK5LtRY1OrEVkIWnTXlTpm48x7ej4
	 4HMiz7mE0JbVg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198C839389E8;
	Fri, 26 Jun 2026 08:21:10 +0000 (UTC)
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
Subject: Re: [PATCH 01/19] btrfs: require at least 4 devices for RAID 6
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246206859.3816447.16178589769412306177.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:21:08 +0000
References: <20260512052230.2947683-2-hch@lst.de>
In-Reply-To: <20260512052230.2947683-2-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-riscv@lists.infradead.org, akpm@linux-foundation.org,
 catalin.marinas@arm.com, will@kernel.org, ardb@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 herbert@gondor.apana.org.au, dan.j.williams@intel.com, clm@fb.com,
 dsterba@suse.com, arnd@arndb.de, song@kernel.org, yukuai@fnnas.com,
 linan122@huawei.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-raid@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Tue, 12 May 2026 07:20:41 +0200 you wrote:
> While the RAID6 algorithm could in theory support 3 devices by just
> copying the data disk to the two parity disks, this version is not only
> useless because it is a suboptimal version of 3-way mirroring, but also
> broken with various crashes and incorrect parity generation in various
> architecture-optimized implementations.  Disallow it similar to mdraid
> which requires at least 4 devices for RAID 6.
> 
> [...]

Here is the summary with links:
  - [01/19] btrfs: require at least 4 devices for RAID 6
    (no matching commit)
  - [02/19] raid6: turn the userspace test harness into a kunit test
    (no matching commit)
  - [03/19] raid6: remove __KERNEL__ ifdefs
    https://git.kernel.org/riscv/c/3d6beb659ddf
  - [04/19] raid6: move to lib/raid/
    (no matching commit)
  - [05/19] raid6: remove unused defines in pq.h
    https://git.kernel.org/riscv/c/06d2a66fb7c0
  - [06/19] raid6: remove raid6_get_zero_page
    https://git.kernel.org/riscv/c/885d31423183
  - [07/19] raid6: use named initializers for struct raid6_calls
    https://git.kernel.org/riscv/c/7e91f76a9668
  - [08/19] raid6: improve the public interface
    (no matching commit)
  - [09/19] raid6: hide internals
    (no matching commit)
  - [10/19] raid6: rework the init helpers
    (no matching commit)
  - [11/19] raid6: use static_call for gen_syndrom and xor_syndrom
    https://git.kernel.org/riscv/c/10f4b8e2a164
  - [12/19] raid6: use static_call for raid6_recov_2data and raid6_recov_datap
    (no matching commit)
  - [13/19] raid6: update top of file comments
    https://git.kernel.org/riscv/c/30bf04bd13a5
  - [14/19] raid6_kunit: use KUNIT_CASE_PARAM
    https://git.kernel.org/riscv/c/2175395f76c3
  - [15/19] raid6_kunit: dynamically allocate data buffers using vmalloc
    https://git.kernel.org/riscv/c/d67c25712fe3
  - [16/19] raid6_kunit: cleanup dataptr handling
    https://git.kernel.org/riscv/c/562bcbfcb99b
  - [17/19] raid6_kunit: randomize parameters and increase limits
    (no matching commit)
  - [18/19] raid6_kunit: randomize parameters and increase limits
    (no matching commit)
  - [19/19] raid6_kunit: randomize buffer alignment
    https://git.kernel.org/riscv/c/8cf0a6c4bb9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



