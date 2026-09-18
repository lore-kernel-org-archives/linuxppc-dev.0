Return-Path: <linuxppc-dev+bounces-27661-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720DDC88E75
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 06:20:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmMtk6rM7z2ypW;
	Fri, 18 Sep 2026 16:20:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789712430;
	cv=none; b=Xxk84JWq/q4m9+MaIzViJyB0XkmZfXUEp8jbJVJknrQ6zikRBRvrIqw90h6JNgPqCbMxsRh6BN29ATOfFcjjD0mpJmxLlR/+n1yHxTzZBCtzpdI+9p7E57t+81GidukwzoQAy3KlzdwB9EoiOB6ZAuNGqvr+nFE9YzbSnCri57y+7T7+sWW/yh1kPIxbuYo8u6T6qvYJBhSTFMVoB19W34E/z+dQl6+DOytDp/+bn6aH8MBF5p9G2mn9oyrrHZhPLVHah6YSAkPCqnrkaBnPuUunVaNpI9NI/8gIbLb+mukalYtE7T1ZSfQ05UF/4C61xCm2mTRrxvWq/RcngOCeOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789712430; c=relaxed/relaxed;
	bh=rjSyTx2NS4saXzDHQPxuotaV2pkcNZJzOoz/PGA6I5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZouHTi9uWXXi/vGCW2JjzUv53lDMVlq1pPpYhvbn4H7J+/+nuA2mpNRl9h3j9YYXIlHpTDiE+fcmEGVQzCucF9Lg0pm8OSESKgSqioXM6J6PvGC17UCx0+YwH+Yc7ppeE0ewn70r0CdZPHnVIYLk6Vhs+VfliMt7tVNKNajX5d+a20S+Q2qazHSVvfe020AdkQUBcxXJmKN9mPInD9kaOLltNd4wVIiG3miSMV8qO155dGLXJTreH+qSov+IGyC8fKfBKzxSGdwWJo1sHotrwHTLWhMlKC4ASr7ikS479ErRulaQ+cuoumR0tdaAXcHYlvbaytXZLjaEd/CSOxtL9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lpG9hfia; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lpG9hfia;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmMtk1RdBz2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 16:20:29 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 09BDD601EF;
	Fri, 18 Sep 2026 06:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B851F000FF;
	Fri, 18 Sep 2026 06:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789712427;
	bh=rjSyTx2NS4saXzDHQPxuotaV2pkcNZJzOoz/PGA6I5w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lpG9hfiaBAlN6KxOB6m27R3lLQwwY0lELmtMMRQ/dnVNH+v+3t1VgYagZLCJkXFQO
	 i87D/N5cBj8t2ddQpp7eLg/eGGqOSpnm0FSwdF5YsDxyuvO6eV61oKHk3jeb106ZEA
	 LxbXuX2dgBNXqiZlI+NBVOSoX1HQ9tDLz2KrEzhJaCnCWMPqLigCzEtCrVfiDBuFgg
	 NPo3KQRKIivrJ6iNe6Ze9C33cuKQpQF/deXeTKsleao86CE7fu4NQdfrV8nVSjHi4b
	 yJZE2ynb/qjIC4y4ODCyILkOSjKLv4ZiB5cgnFLt0nIhyA7Yfu/tce8fCbhuwMfdOV
	 ghQga3OVYRBrQ==
Message-ID: <e0e23ac1-7d56-473f-b449-64ba69e5b2af@kernel.org>
Date: Fri, 18 Sep 2026 08:20:22 +0200
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
Subject: Re: [PATCH] powerpc: remove unused audit_32.h header
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
References: <20260918030810.420490-1-enelsonmoore@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260918030810.420490-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/09/2026 à 05:08, Ethan Nelson-Moore a écrit :
> The last use of arch/powerpc/kernel/audit_32.h was removed in
> commit f26ad12356a2 ("powerpc/audit: Convert powerpc to
> AUDIT_ARCH_COMPAT_GENERIC"), but it was left behind. Remove it.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   arch/powerpc/kernel/audit_32.h | 7 -------
>   1 file changed, 7 deletions(-)
>   delete mode 100644 arch/powerpc/kernel/audit_32.h
> 
> diff --git a/arch/powerpc/kernel/audit_32.h b/arch/powerpc/kernel/audit_32.h
> deleted file mode 100644
> index c6c79c3041ab..000000000000
> --- a/arch/powerpc/kernel/audit_32.h
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#ifndef __AUDIT_32_H__
> -#define __AUDIT_32_H__
> -
> -extern int ppc32_classify_syscall(unsigned);
> -
> -#endif


