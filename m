Return-Path: <linuxppc-dev+bounces-20455-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1792CD3430
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 09:05:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8t0F1VDFz2xMV;
	Tue, 05 May 2026 19:05:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777971949;
	cv=none; b=O1A3wk7S32jwrKEXrwWE2VZWF+G66BKqwhwMcMrtLAWiL+kkZ7baDWb05bQF81lmCI29UrMwoEuOoMbuPF02rCYfYtJSLTNUmn7ZF+Ew7LU6lDxkDB+LxDjVK1Ktqg3rAmoueOhPD+v3m1CTr+paAJMGbWfrSEgFMuyNXfYyyi8sMhtY25TuvpNHdOlvMFgsLwLObPPE5lORPcMRZXM6YEUUZVIZ1QGtVwQzEvDxl00muFXAhuOfjQuMNHmUV6H5TXw2bgpptFMWTss8FmU9ixCy50HtImtCgAeRFh474ajYZovpIcMIvbXRePJXMcoDX+Lkkncfcn0wS9ntpnPR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777971949; c=relaxed/relaxed;
	bh=X++yykQP12pApy0+FVTlzIEFtjiCncYwBTN1tiTK7Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JFg2Hy+x5ABFsmEq17m9sbavoS4gW5mtGxDx/vaeomipbROr6EdtpE2EebqxnPTsfcF9eIXxf368hhaT5zL4VG46T9ymBVA5/9AbOv9vM2hooT61sWGbZSiMrVZUB9Pg78aHu6Ib8nqXKKXCLR4aKp/+pv67HnV2EsJ3kdtm9OjGWwpCdzUV7lNshGfGFK/BkSnu3IVvucMG4FZoRrEUHUt2gAoqzl7QZqLj6YPvwXcYbNCaTN282fSelE/kMXJz06Qf0R6y++ra2AnCCHfO6LldFG8nMz9yTWB3bJknPG5lxnOOcki1anKfZS0iiIa1yOFhmexViVW+A8fvCsz7/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RMb9118o; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RMb9118o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8t0D0pY3z2xGc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 19:05:48 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2F6D240A28;
	Tue,  5 May 2026 09:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F0FC2BCC9;
	Tue,  5 May 2026 09:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777971946;
	bh=4UCQ3QN2QWNXrWHKBHRPi0SoBfJaK8yevcbCvXDwQRI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=RMb9118oEn/g2hQTEza+TcqN7fPkdsI+GbNLQYi2lM1GOv21ELF6l+bC5+TntjDzH
	 z8WagyI9GdPcttqqk7+L84RwC6zYv/Z6FreCuTwN/4IMpJ2GSegMnZSO6C56M7wsJa
	 at05/XZ3+2/5Lp4WM6Pl2RO3l5wLuderbvA0cVxI3TEpFh/3Ot08pzI3vt0zenbhxE
	 kUYkSg6Uk9x1HhJ5pnAX03SvxvnERm5cOs9CPSf+IIwE6uM45CRUn8wrpa3M7Hz7aq
	 c7XYAkdSdkQbfJeVpGkwUNgK2kB4uSVsm9uneXL4M4ynU6lQhoZNuVdt9SGqDxmg0D
	 9LZh2ZiC5KzTg==
Message-ID: <c8249a6d-55ee-4ad2-83ac-c25f86759a46@kernel.org>
Date: Tue, 5 May 2026 11:05:35 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] objtool: Fixup alternate feature relative
 addresses
To: Sathvika Vasireddy <sv@linux.ibm.com>, nathan@kernel.org, nsc@kernel.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 jpoimboe@kernel.org, peterz@infradead.org, ojeda@kernel.org,
 masahiroy@kernel.org, lossin@kernel.org, tamird@kernel.org,
 thomas.weissschuh@linutronix.de, rostedt@goodmis.org,
 ihor.solodrai@linux.dev, thuth@redhat.com, pmladek@suse.com,
 aliceryhl@google.com, elver@google.com, kees@kernel.org, legion@kernel.org,
 ardb@kernel.org, yuxuan.zuo@outlook.com, alexghiti@rivosinc.com,
 alexandre.chartre@oracle.com, bp@alien8.de, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20260505084628.17940-1-sv@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260505084628.17940-1-sv@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/05/2026 à 10:46, Sathvika Vasireddy a écrit :
> This patch series implements build-time fixup of alternate feature
> relative addresses for powerpc.
> 
> Previously, Nicholas Piggin proposed a build-time solution using a
> custom PowerPC tool [1], which provided the foundation for this approach.
> The current implementation leverages objtool's existing ELF parsing
> infrastructure to do the same.

What are the changes since last RFC 
https://lore.kernel.org/linuxppc-dev/20260316062237.30948-1-sv@linux.ibm.com/

> 
> This patchset applies atop powerpc/merge branch.
> 
> [1] Original PowerPC tool approach:
>      http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20170521010130.13552-1-npiggin@gmail.com/
> 
> Testing:
> Build and Boot tested on ppc64le, ppc64be, and ppc32be configs.
> 
> Sathvika Vasireddy (6):
>    objtool/powerpc: Add build-time fixup of alternate feature branch
>      targets
>    objtool: Set ELF_F_LAYOUT flag to preserve vmlinux segment layout
>    objtool: Fix "can't find starting instruction" warnings on vmlinux
>    objtool/powerpc: Skip jump destination analysis and unnanotated
>      intra-function call warnings for --ftr-fixup
>    kbuild: Add objtool integration for PowerPC feature fixups
>    powerpc: Enable build-time feature fixup processing by default
> 
>   Makefile                                  |   7 +
>   arch/powerpc/Kconfig                      |   3 +
>   arch/powerpc/Makefile                     |   5 +
>   arch/powerpc/include/asm/feature-fixups.h |   2 +-
>   arch/powerpc/kernel/vmlinux.lds.S         |   8 +-
>   arch/powerpc/lib/feature-fixups.c         |  12 -
>   scripts/Makefile.lib                      |   4 +-
>   scripts/Makefile.vmlinux                  |  11 +-
>   tools/objtool/arch/powerpc/decode.c       |  15 +-
>   tools/objtool/arch/powerpc/special.c      | 451 ++++++++++++++++++++++
>   tools/objtool/builtin-check.c             |   2 +
>   tools/objtool/check.c                     |  57 ++-
>   tools/objtool/elf.c                       |   4 +
>   tools/objtool/include/objtool/builtin.h   |   1 +
>   tools/objtool/include/objtool/special.h   |  56 +++
>   tools/objtool/special.c                   |  29 ++
>   16 files changed, 637 insertions(+), 30 deletions(-)
> 


