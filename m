Return-Path: <linuxppc-dev+bounces-27727-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C911C982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:42:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmTjY07Yxz2y7r;
	Fri, 18 Sep 2026 20:42:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789728176;
	cv=none; b=awGHHFcjy1bVlt6BQD6OWOTWRLG5XsixZh1ygLGAnmFG3Mll8E5+jd0xTdNf/gfR/FY4mTvZOUbr8gSl5PY1ihS3YTs3pZaPBxLPRsk4yL4wPOWi5oDhvvjmlidwp8HewZg6zXN/yLNcFzrA2KlGWvojgmjjWQIz77L3TqyM/9bs2KibVsLLJwZ9e9SAZSe9bOi821HJ2wYRqstSNph+AEJJcQZUkvvDBttZgvIV0q6GvX+Ov0rl+iaXKHW7C7a2DOpRDBeNGQrISHHKXrOUkdjtQc3qvX56RXMl1VUNnJbRsfjk+HTMwehA0YpiXnpF2uzKoqs9xN90pQgBJqeXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789728176; c=relaxed/relaxed;
	bh=ak8nh2SAnHlrH5Gov+HSivc8cOu/u80U/J5TpC+xpEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gL9Po8IYeFlxnDQu687nJCLfEUj3E/eCzBr3lvWdYz/HLyFRsq1BmFGArCniNGvrLJalC2tQmc2D8RdZiEMaAZD9OZVuuzCPavA1f9HpVr/S0kmZX0bOQSElrRiOjjual+tIrqzxsoVF4xQg0slgwak5tk/v6WnbZqRBQBjXQYBR+z8vox5yjBfQeKeD0Lt6BwgS6oeIVSM7+3phdxpoRfadUkWOA5IFhCU8Xg4p4vyr6daFMScKgIiqF6pr+svpYKt3ZYB+FThcdJIX/sVPiTedIPa9Q3AC+x4UGl9IyazM+2rx6XM3w8QGoKkO81DkZzGnmQaNF+cNOa3i6P7xdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org; dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=nK+0EYK/; dkim-atps=neutral; spf=pass (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org) smtp.mailfrom=debian.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=nK+0EYK/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=debian.org (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org)
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmTjW6qvnz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:42:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ak8nh2SAnHlrH5Gov+HSivc8cOu/u80U/J5TpC+xpEQ=; b=nK+0EYK/9BTfAlJwWP6AvOQJLF
	c15I5JymFF9K2yedwWqzusksKy4eQ5viR8nw3qriMok9WWjsTGTBJqyX7vUZOYQXAgOrEVMbNrZuv
	mjim6c7AEHBA7MnJy/903HNCuWnYczSfYXW5QC0F/OBJf0dY7ju2961gPIkDrOT5ExmqAFKwzqxcC
	XiYLMxnLjQ39eErgrwFWiMno2NauveXgtxV+dkki815BfVZ5ZzLxKpclYHT585S62SVGSmWuPCJin
	9MSZjVXwRNN1boS/jdHCenBQWO8ruAfwzANSV4/t21AyyOLxCm3iTBm1RVzeREYUe38b8ciyJaWu7
	GijK2PpQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x7W1x-006f1D-2W;
	Fri, 18 Sep 2026 10:41:22 +0000
Date: Fri, 18 Sep 2026 03:41:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com, 
	tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org, dakr@kernel.org, 
	akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org, pasha.tatashin@soleen.com, 
	pratyush@kernel.org, ruirui.yang@linux.dev, kees@kernel.org, thuth@redhat.com, 
	gshan@redhat.com, ardb@kernel.org, james.morse@arm.com, yeoreum.yun@arm.com, 
	sourabhjain@linux.ibm.com, robh@kernel.org, coxu@redhat.com, tangyouling@kylinos.cn, 
	liukexin@kylinos.cn, guodongtai@kylinos.cn, maqianga@uniontech.com, 
	zhangtianyang@loongson.cn, blum@kernel.org, adityag@linux.ibm.com, chao.gao@intel.com, 
	kas@kernel.org, vishal.l.verma@intel.com, seanjc@google.com, piliu@redhat.com, 
	jbouron@amazon.com, me@linux.beauty, mclapinski@google.com, graf@amazon.com, 
	bgwin@google.com, eric.devolder@oracle.com, hbathini@linux.ibm.com, 
	takahiro.akashi@linaro.org, lizhengyu3@huawei.com, palmer@rivosinc.com, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, driver-core@lists.linux.dev, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 00/17] crash: Rework and add arm64 crash hotplug
 support
Message-ID: <aq0UR62q6gGJUQ49@gmail.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918100442.3841135-1-ruanjinjie@huawei.com>
X-Debian-User: leitao

On Fri, Sep 18, 2026 at 06:04:25PM +0800, Jinjie Ruan wrote:
> When CPU or memory hotplug events occur, the elfcorehdr in the kdump
> image becomes stale, potentially leading to incomplete crash dumps.

Looking through the series, it seems to mix bug fixes with new
feature work. Would it make sense to split out the fixes so they
can land independently, and keep the new features as a separate
patchset?

I'm currently rolling out crashdump CMA across the Meta fleet, so
right now I care mostly about picking up isolated bug fixes. As it
stands, it's difficult to tell which patches are fixes and which
are features.

