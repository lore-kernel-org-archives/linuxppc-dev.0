Return-Path: <linuxppc-dev+bounces-20239-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D597FF8868
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 12:53:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4gNB2Skgz2xld;
	Tue, 28 Apr 2026 22:53:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777380810;
	cv=none; b=FnfZzlKIkQzZs3XFTdFudqGjD4Rlx4q7UyDB1N2w0kvLqMP7h+tSrQnXzstuzYjQE91n6UNZFMNB8QYTLtp7aBGXSGxMmg75jxfdov02dADqOPU1tHl/ZaSlFsjy6pRMqItSRQVQrzVxzaRUAWb3tmGFdlImATRguIKjIzdxHxFBx/4nEw/5cREcTaKdjajf8jJY8tUY/n3uBQWefWPzZK90470qSeQw1nr8NFMqxUynGX6yBdq2hJK7fcS9mWHGbhmhWaeK5ZZcpE5yIfQt8djeTygBBeI4i0xVUMb+LX3Au01ay/Ev9XCjV1jeoT3Kj1eW8PC/g26M5AUzo41y5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777380810; c=relaxed/relaxed;
	bh=o3e+e3CqMXXEJPbiX3zpHjjoz6jJp/fI4BVPAx39btw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EB2HbZIFLuiAcBGgERckGFqsjkpSVJa6A0zcbmusoHiHPjztD5NIBds118yvG+3CVqDD/bYM3B4nEEnWThHMh4RB6tBTOOTYihf4TeDunK6CDU+qz/Tvyr8DE68i3OrmnW4/2scT7odnfy4XG11UYJdZf7mP02VtA/WlH6+XlyxJ2X1E6QZUEuk+4MuwcFP8HqNvKansm/lf2ROM6ERbATv6EMUlz2gLJrexREhVuL0pz4T9Iw025PxjUzI+9re4n9GOnXWu1lXf1ZXYPvGMaKE/pbk0qHQsJu1YL4Zs/fE0U5j+PcY5G99r6WKmt3wivUSqjvu+BmMhP2UO6DQVRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q2H9r0W1; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q2H9r0W1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4gN91l2Pz2xWP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 22:53:29 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E11EF6111B;
	Tue, 28 Apr 2026 12:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3A7C2BCB7;
	Tue, 28 Apr 2026 12:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777380805;
	bh=MFTHBWIVPPds/6umCo+/GsrLJiT9dmnX5t+TJKOu5mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2H9r0W1pFFOcIVTMHsruFr/GMxPujb4LuXdLrJe3uKYcZNxQlHL325YdzeYIaqGb
	 YgUJCml9iD59Ml9MwxFlDl8g45HE5SHDfQGNKeas7kf1pYmKZ8jVqRDzf6HHicsR74
	 sZhFSzs8Ra8AOxlyR0j8SYeZmmbjYyl+cqItSnBMh0HfeU971hN2OffDpUKu+aAFBj
	 GLEtiSpFA8P4RWzmvn81yKRR+hygNgh10efvXltfAPPC4wXMVhE51Jp4/oUrhxxohi
	 717FMNQI5CLuRE78CHCswC/iUhsYlDYFPjyu26ZyBg3OTRsdTyrq/yecTvXuGJxsmB
	 j+0ksBK4wyZcg==
Date: Tue, 28 Apr 2026 14:53:01 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, corbet@lwn.net,
	skhan@linuxfoundation.org, catalin.marinas@arm.com, will@kernel.org,
	chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org,
	saravanak@kernel.org, bhe@redhat.com, vgoyal@redhat.com,
	dyoung@redhat.com, rdunlap@infradead.org, peterz@infradead.org,
	pawan.kumar.gupta@linux.intel.com, feng.tang@linux.alibaba.com,
	dapeng1.mi@linux.intel.com, kees@kernel.org, elver@google.com,
	paulmck@kernel.org, lirongqing@baidu.com, leitao@debian.org,
	ardb@kernel.org, jbohac@suse.cz, cfsworks@gmail.com,
	tangyouling@kylinos.cn, sourabhjain@linux.ibm.com,
	ritesh.list@gmail.com, hbathini@linux.ibm.com,
	eajames@linux.ibm.com, guoren@kernel.org,
	songshuaishuai@tinylab.org, kevin.brodsky@arm.com,
	vishal.moola@gmail.com, junhui.liu@pigmoral.tech, coxu@redhat.com,
	fuqiang.wang@easystack.cn, liaoyuanhong@vivo.com,
	takahiro.akashi@linaro.org, james.morse@arm.com,
	lizhengyu3@huawei.com, x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, Baoquan He <baoquan.he@linux.dev>
Subject: Re: [PATCH v12 00/15] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-ID: <afCtrXaUAGDcseq3@kernel.org>
References: <20260402072701.628293-1-ruanjinjie@huawei.com>
 <dfa24c4b-a423-4c80-9a8f-28c577c9ec11@huawei.com>
 <20260428035256.cbb3ac77c4bbb89bb7efcc19@linux-foundation.org>
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
In-Reply-To: <20260428035256.cbb3ac77c4bbb89bb7efcc19@linux-foundation.org>

(added new Baoquan's email)

On Tue, Apr 28, 2026 at 03:52:56AM -0700, Andrew Morton wrote:
> On Tue, 28 Apr 2026 11:30:13 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
> > It seems the patches for crash core rework, powerpc, riscv, and arm64
> > are mostly ready to be merged. Could any maintainer help pick these up,
> > or should I rebase the entire series against v7.1-rc1?
> 
> April 2 is prehistoric ;)
> 
> Yes, refresh, retest, resend.  Note that there have been maintainership
> shuffles in this area.  
> 
> KDUMP
> M:	Andrew Morton <akpm@linux-foundation.org>
> M:	Baoquan He <bhe@redhat.com>
> M:	Mike Rapoport <rppt@kernel.org>
> M:	Pasha Tatashin <pasha.tatashin@soleen.com>
> M:	Pratyush Yadav <pratyush@kernel.org>
> R:	Dave Young <ruirui.yang@linux.dev>
> L:	kexec@lists.infradead.org
> S:	Maintained
> F:	Documentation/admin-guide/kdump/
> F:	fs/proc/vmcore.c
> F:	include/linux/crash_core.h
> F:	include/linux/crash_dump.h
> F:	include/uapi/linux/vmcore.h
> F:	kernel/crash_*.c
> 
> I believe that Pasha/Mike/Pratyush are setting up a git tree, but there
> isn't one listed here?

On it:
https://lore.kernel.org/all/20260428124833.1903302-1-rppt@kernel.org/
https://lore.kernel.org/all/20260428124325.4189486-1-pratyush@kernel.org/

-- 
Sincerely yours,
Mike.

