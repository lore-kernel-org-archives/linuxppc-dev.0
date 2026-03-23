Return-Path: <linuxppc-dev+bounces-18633-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59096F483CC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 16:55:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fffSW4rwqz2yFb;
	Tue, 24 Mar 2026 03:55:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774284955;
	cv=none; b=P2bVtn32/1qFkEmkPhY+7Q23YfzrpcSFuLkHeZaEYzUCFVYoy6pkeNSNJtMHA8j69av82DcNk3/eTaxIjQGonsiBi22PKjx7im366t1+ccXTPYcwfwwSgjx2evSU6UWVwqrKZWt+R6HXtpDQ1rw+HEU6qi82vEudEcdXP0u0TpvOcdDYlBkj8c0ZzezZ84DUnKIc0naxgnNYKy2UYWJBfy4S2647ksRPyoGPIqWiqmPO60c6tdnBH4F970UxSIvG8LAdRg8QXRWneC4GosO/2WkVTWU06+LXB4BG64nrMSQhQunYEHKCROGy5QqxI04GubtGyll1j3wbBoF+Fm3vew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774284955; c=relaxed/relaxed;
	bh=BOjG5Ty6h1juqTAjGNHoKX4nftQIFtN1pMEnmQKVI5I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Fn5XBVSX9YBWAkSZ65LK6foW6ZCNky/eNgB583RbepNCQLU3U01v75OI9ZbKisJ9W0aEkeuMrE7xfr+jaow4tXCfB/P6HMQ9+4VRKvg5OlOnibQwPJPqGwL06+wsYzZFB7Uzr0CLGwF8IacuX4xprxJDfJd9LcFnEUVoeT2/QqTQZ1eYS9guaovLGQPpUbqino313Abg9ehJEHo8YKVZQyuoHohEf4Nf0XWYdtCi2kHMuQ4URWK3tH09YCSc9hkNgFrLsINjB5SRCKysTM2cWTFfwHp+A9gYjISehnXzXppIyW8Y+dY4rwPofR0iRWMstjR1vZbNM2d1CEEZ4maBFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=qgGXTep1; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=qgGXTep1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fffSV4Qvkz2xs4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 03:55:53 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4B45C60120;
	Mon, 23 Mar 2026 16:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F2FC2BC9E;
	Mon, 23 Mar 2026 16:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774284951;
	bh=0LuJYoTQTDvWV9NTWOPFuNPtv2UN3kOMEh+jhXWnc2s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qgGXTep1YmJrPSvqa0ycQRzl2NPgm4AaiOcjYyoeytss6axGtvgS0EzKKZIBsxxsA
	 V6fyRWqr/ZIWLg5r94g6isrv7Lul5Ery6vKJi/XjccJ0tkvgqlQUYmdi/KPsKX+oSy
	 WOcrfjFCALXA7q5Zf2q/7NKZNQeM2jvJT0tXbqY8=
Date: Mon, 23 Mar 2026 09:55:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <catalin.marinas@arm.com>, <will@kernel.org>, <chenhuacai@kernel.org>,
 <kernel@xen0n.name>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
 <npiggin@gmail.com>, <chleroy@kernel.org>, <pjw@kernel.org>,
 <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
 <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <robh@kernel.org>,
 <saravanak@kernel.org>, <bhe@redhat.com>, <vgoyal@redhat.com>,
 <dyoung@redhat.com>, <rdunlap@infradead.org>, <peterz@infradead.org>,
 <feng.tang@linux.alibaba.com>, <pawan.kumar.gupta@linux.intel.com>,
 <dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
 <paulmck@kernel.org>, <lirongqing@baidu.com>, <safinaskar@gmail.com>,
 <rppt@kernel.org>, <ardb@kernel.org>, <leitao@debian.org>,
 <jbohac@suse.cz>, <cfsworks@gmail.com>, <osandov@fb.com>,
 <tangyouling@kylinos.cn>, <sourabhjain@linux.ibm.com>,
 <ritesh.list@gmail.com>, <eajames@linux.ibm.com>,
 <songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
 <samuel.holland@sifive.com>, <vishal.moola@gmail.com>,
 <junhui.liu@pigmoral.tech>, <coxu@redhat.com>, <liaoyuanhong@vivo.com>,
 <fuqiang.wang@easystack.cn>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <kexec@lists.infradead.org>
Subject: Re: [PATCH v9 0/5] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-Id: <20260323095548.fa4e13d6e8ae5005ae585e13@linux-foundation.org>
In-Reply-To: <20260323072745.2481719-1-ruanjinjie@huawei.com>
References: <20260323072745.2481719-1-ruanjinjie@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Mar 2026 15:27:40 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> This patch set handle them in crash core in a general way, which eliminate
> a lot of duplication code.
> 
> And add support for crashkernel CMA reservation for arm64 and riscv.

Thanks.  AI review has completed and it asks questions:
	https://sashiko.dev/#/patchset/20260323072745.2481719-1-ruanjinjie@huawei.com

