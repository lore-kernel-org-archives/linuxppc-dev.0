Return-Path: <linuxppc-dev+bounces-26421-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8264C624D6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 20:14:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZHBx62Nvz2xns;
	Wed, 02 Sep 2026 06:14:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788293673;
	cv=none; b=biwM1H7zoOCqJ2x1dSf3ZUr/eofcfA8yGLqvt43fMssP1jyEBNedA2EcFvT4F8XMPmrSiKKEHw2R02RnpwEbDjaJpc3fTD9PePCUNBRe2bV3JxO4HksYxw3UaulPm5c/Bsz7/w3haMzhcz380mukUBoS6Sg7G4EilsCZuqtyl0FH+bofXtcmXYBMl8o1uDx6adjP0FOvB93lsuUUsJBaE91XILm6SeDnnWBmZhAbOJ+ASiT1qfyyZvkcA8GUVwMqFTcaNJnyr+HiucSBqO18mRPXkuI46Cgx9AnfvwzPEn0sDnfvVjHef3g7BKFZrRHWCzqws8yHG29uK5onFtw2XA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788293673; c=relaxed/relaxed;
	bh=aEZEmYZMoaqekOPk8qqP2ODpRIO0XT0q9KzPXapNk2g=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ZlI0Vex2MHzNoByd8WdTsj5pCqAq0apnMvRhAws/I1z5F6vHyO6xMSE4A4QWcrpWj31HQxUFsXI8YKZx3fDbO+JuwDAPnaDLN57OYttD3U4lTzuhZKF6qjiYRPHu3KVabS/tOP+xHBxEHWMC2S9sKA8o7l9wV0J+UA/VL7+jDN7S5fTWtjXu7RYK0zPgFxYdYakwMS9cLl3olPaXxbExH2xks4KNKzM2A90Jq3Y4Vde3Sg+Wah1rLj6A3zSAzgZWg/TpAtw+8MxIsLyoOEuV5Zp16Mn9gS2fU7Ny0a816SjZbZo8PZiI2PcqfL0Ztis/+//d2LpM4M9sRAjo6vkQMg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lbice+wL; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lbice+wL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZHBw6hVdz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 06:14:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8B951600D9;
	Tue,  1 Sep 2026 20:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F541F00A3A;
	Tue,  1 Sep 2026 20:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788293670;
	bh=aEZEmYZMoaqekOPk8qqP2ODpRIO0XT0q9KzPXapNk2g=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=lbice+wLj+lCT8QM98ULT3hhnoph1ybVba4ki8BaTAtUERzwAFL3Q3ECL7S5NT1Bw
	 af2GJr4OE3roJ0CS54vKzLOApz5rbUWlstAZhqaAhUNZ+JAnPt7rSJsk7J5froWi6z
	 n6f784ysOfk8nLzxDJ3tgE66oJGb46pYShdqP6dF53A4x5gCcAGnWTkm2AlG7GUgbe
	 7psRiBXFRCeVSoQRgDSVpVkwPSeHbJYdpqYtqhOmr7exMFXhudxgQCLL7hmUTZebm0
	 wspK7+0gVSANfLCupzkEWgZLef4c9lQ7lAmSrFa9KB3Su9TirvLHRfJcxRMW4GPASs
	 HWsZUWUQSNuLQ==
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
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 02/17] kexec: Extract kexec_free_segment_cma() from
 kimage_free_cma()
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, tglx@kernel.org, 
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
 akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, 
 pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, 
 kees@kernel.org, thuth@redhat.com, gshan@redhat.com, jic23@kernel.org, 
 james.morse@arm.com, ardb@kernel.org, leitao@debian.org, 
 yeoreum.yun@arm.com, sourabhjain@linux.ibm.com, coxu@redhat.com, 
 tangyouling@kylinos.cn, hbathini@linux.ibm.com, adityag@linux.ibm.com, 
 ionut.nechita@windriver.com, liaoyuanhong@vivo.com, seanjc@google.com, 
 fuqiang.wang@easystack.cn, makb@juniper.net, piliu@redhat.com, 
 ebiggers@kernel.org, jbouron@amazon.com, mclapinski@google.com, 
 me@linux.beauty, graf@amazon.com, bgwin@google.com, robh@kernel.org, 
 takahiro.akashi@linaro.org, palmer@rivosinc.com, x86@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org
In-Reply-To: <20260826092541.3905933-3-ruanjinjie@huawei.com>
References: <20260826092541.3905933-1-ruanjinjie@huawei.com>
 <20260826092541.3905933-3-ruanjinjie@huawei.com>
Date: Tue, 01 Sep 2026 23:14:00 +0300
Message-Id: <178829364020.3691424.17302958503793700435.b4-review@b4>
X-Mailer: b4 0.17-dev

Hi,

> kimage_free_cma() relies on image->nr_segments to iterate over segments.
> When an architecture loader (e.g., arm64) truncates nr_segments on a
> mid-way failure, CMA pages allocated beyond the new boundary become
> unreachable, causing silent memory leaks.
> 
> Extract the per-segment freeing logic into the exported helper
> kexec_free_segment_cma(), so that architecture loaders can release
> individual segments before nr_segments is truncated. Refactor
> kimage_free_cma() to loop over the new helper, preserving existing
> behavior.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 83c296c0eb6cc..d7c83938dfd3d 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -533,6 +533,7 @@ extern bool kexec_file_dbg_print;
>  
>  extern void *kimage_map_segment(struct kimage *image, int idx);
>  extern void kimage_unmap_segment(void *buffer);
> +extern void kexec_free_segment_cma(struct kimage *image, unsigned long idx);

No need for extern, even though it's inconsistent with old declarations.

-- 
Sincerely yours,
Mike.


