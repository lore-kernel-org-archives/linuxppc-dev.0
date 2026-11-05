Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22809606A339
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ewqv2x7q
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKvfq4d1Bz2xPB;
	Thu, 05 Nov 2026 18:52:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793865155;
	cv=none; b=EI50xqIoDY+eZ9WVnE1Nab3ls0MQSjKVblCAPeUceuE9ck6SKq3mrrKQkiZkULTiN6koqJx/H8312oUOVo9xQLtaH5U+/3unSPTM4qQaa8gHBOsn3YSUfg4t1fKER0689MGLZzY25QhQIxI2iNW7ixjKHxjnibX2iR+830iQ6TktBDWJ2sCgzqjTzpA487EBvYrMUfyB8vRCWYmicSC6G5VY3qPWC8VOTAu4078ZhykG+Q0NUv5hMGfXi1Elg4XEQYRP1Z3PvwpP0W0WHBy7pWzwE4OcAY8pUuTXg/kJgfoZ+mks64KAEGTGXeEkq2e7qJqSm/G27vHCIHnlPsFBfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793865155; c=relaxed/relaxed;
	bh=PshXrkjIu/oVh8H0uuMMexWF+3wbEqyJSvZGNZ3+nBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXbYE7AIzegNP+E4h7kXvNBESUNTVn1u5adZm09SdRiAifsBig9z5sTlCCPOSjUFcflTgMEtsTwAlpI5VZsgxh0hCu8zCyBBd+8BYp7MJoYipjOZvBUbKIWVsgAE74K4EK2FgPUToFGHaIL5f/Ka1Uv6GfB8TqZRP6Sv9qpg5M2JZY6OXaQF8K1c6CKWBb0iDGxa8uNdxrT2PRaB4CLzSq60baM7Xl57OlcxwwrdiWHQKXgxMmfw/PSJOO9Gtb1tahfo1wWqFZth+z4hqS+IVvyjaR0Gxeo3S7A4NOmxX0+uQIDhQud8wQnG33BTl/uFTHhiJ8ATDrOBSaYgWtNBhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ewqv2x7q; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ewqv2x7q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKvfp6pPHz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 18:52:34 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 82C67605FF;
	Thu,  5 Nov 2026 07:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90ABD1F00A15;
	Thu,  5 Nov 2026 07:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793865151;
	bh=PshXrkjIu/oVh8H0uuMMexWF+3wbEqyJSvZGNZ3+nBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ewqv2x7qC/seZGztnmn60Jxwl1553DY/3Df5K32EVdXJ/LFXDDt8XPm0md4mvIdbe
	 O7baTlLtl+fjfHYpiP6NcAphW25/jd9J02KuH6IpVpOf128w6Gk/QhyuyYiZ8AkWEd
	 5I8acWTijjPru9qgJ7HQjHMGzi6ZlJdrE9q8FPGTREZLPcuF2t9RZCaCb3gZIq0i2F
	 0CenpiJNcoERzlwxTs0A3D2xG24ySM7ZrAY0uQR/yg7LLM7PxiAALyYLO9ZiDNOVS8
	 XhlU+5NQ65DYU30sIL8WOqi4fmSQc0g+DhJNmCoP27d9xfq6w4CfLjfd7xU/0Ji7zb
	 e/wsPKB9qBz9g==
Date: Thu, 5 Nov 2026 09:52:10 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	akpm@linux-foundation.org, baoquan.he@linux.dev,
	pasha.tatashin@soleen.com, pratyush@kernel.org, thuth@redhat.com,
	leitao@debian.org, yeoreum.yun@arm.com, robh@kernel.org,
	sourabhjain@linux.ibm.com, kees@kernel.org, coiby.xu@gmail.com,
	Yeking@red54.com, tangyouling@kylinos.cn, maqianga@uniontech.com,
	zhangtianyang@loongson.cn, guodongtai@kylinos.cn, blum@kernel.org,
	adityag@linux.ibm.com, hui.wang@canonical.com,
	sohammetha01@gmail.com, guoren@kernel.org, gaohan@iscas.ac.cn,
	kai.huang@intel.com, kas@kernel.org, vishal.l.verma@intel.com,
	piliu@redhat.com, jbouron@amazon.com, mclapinski@google.com,
	me@linux.beauty, graf@amazon.com, bgwin@google.com, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, kexec@lists.infradead.org
Subject: Re: [PATCH v7 00/15] kexec: Fix CMA and elf header leaks and rework
Message-ID: <auw1qgmjWko52oS_@kernel.org>
References: <20261026075201.699550-1-ruanjinjie@huawei.com>
 <179380419709.28814.2122135856184991710.b4-review@b4>
 <932cdfda-7030-4829-8b43-062d208450e4@huawei.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <932cdfda-7030-4829-8b43-062d208450e4@huawei.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 11:45:39AM +0800, Jinjie Ruan wrote:
> 在 2026/11/4 22:56, Mike Rapoport 写道:
>
> >> Patches 8-10 pass the kbuf fields to crash_prepare_headers() to
> >> simplfy code.
> >>
> >> Patch 11 frees the elf core header from the generic post-load cleanup.
> >>
> >> Patches 12-15 add kexec_load_other_segments() and convert the three
> >> architectures, and arch_kexec_setup_other_segments() builds
> >> the architecture specific boot parameters (a DTB or a command line).
> > 
> > I think the refactoring should go before the identical fixes in arch/
> > code.
> 
> However, this will cause trouble for the fix patch in the stable round.

That's right, but since actual fixes anyway require changes to kexec core,
I think it's better to refactor first. The core than will take care of
proper freeing in the most cases.

And since CMA support in kexec is quite new I think the entire set can be
backported to stable then.

I'm planning to have a closer look at the refactoring Really Soon :) 

> -- 
> Best regards,
> Jinjie
> 

-- 
Sincerely yours,
Mike.

