Return-Path: <linuxppc-dev+bounces-19002-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F017DFB3CE5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 09:16:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fklwm4Bw2z2xpt;
	Mon, 30 Mar 2026 20:16:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774862168;
	cv=none; b=WQov/Ouw5BXqhR/Gk1ef5wyKBAOgNoG8v5O6ort44z/wNFWHF9d+qb3pUFQjYz10YqSD+gm8pY/rsIwc50FWyBFRjpYZ3sTO9FHLWVwcchZgWSJw/5SAZk2ZM+QzPHKsMd/Aj0KzVY9SvJ83ioee7JOixAeVHXnGtQqbDmVIaw8yPXB24sa3L82tPKdVTt91ZvQgq9bfaJplVwx/psdfR8eHNY15bWA8w5KDjjsUhWdNfMMlUsfpJifhuTmkUsKkH8zdzG7UJR4z5Uw+K0AwqjaoMrFlra1GVDP6+agn/kgCbECe1vMjWCFN6izwFmBPSP2zKZ17ppdi4HjpIvEqLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774862168; c=relaxed/relaxed;
	bh=WO1vn6Tln5KFquM2TJaKxzbEqp7cPSRmlLOOnQm4DBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USa1lHxac9Q5OfEze4jJRDtn/tJJQSxY3w9V3ZlOjX9JxOejlF0yXN65W4VdGSj6noZZMNj8yBBUGPaGDZFu0BPUwlYamjlBetbxGvbPXyg4RxPS7AkmxDuvHlxOYyOhD+kdEpBF3criUmu6FYCrdC2NMp2sLH5i1ifHIx+pRs9N6cZ/qEBi5wX0Md4EoAztP4NiRPv+XiCg6CcBNBwi7GGSGLJMriGt/BnOECooYocjDwMTqwBV9Jfbit4COB0yvfqVDc7QPsfyZeuKSL3pcPryQMYQOMEi2wDyeSd45EfKAhLZM/V+XT9i09vB40w1CsDRgrdv3m+34JO9yVlIiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org; dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=IjoUdYg7; dkim-atps=neutral; spf=none (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org) smtp.mailfrom=debian.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=IjoUdYg7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=debian.org (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org)
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fklwd3Whnz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 20:16:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=WO1vn6Tln5KFquM2TJaKxzbEqp7cPSRmlLOOnQm4DBk=; b=IjoUdYg7H5HjzhmD9Ya8KzCZED
	MOdt/f/iybG0j7ZLGmiC7aJOgf9EGEZ5AT6v30A7lr8C+eX+qUGhl5lLwhUy7Ag2vW87+rI4cKgR0
	IreKmv/ogatlCLSyoDgJQL/Bm0oZPTC3Ph6N6bEB8K2FbqIE9a2RJzwF5rC3QyiVtqaFsRExlbFnq
	w6kBr9fPUeAdfZ2RsOnmOj6jLS7FgdEY+TwNyaPu3c4DAiLI7ICVb5EP/dox4qH2GHtCEzV9jz6MU
	LmEcDrV31BMlEKYMm8KfrbhCwKfgUBdd6N399NiMCtz+aDHCvorriy5EW4hCaA9xT6qUKgk0TT0qt
	Qm7u5jxA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1w78hH-001L8R-10;
	Mon, 30 Mar 2026 09:14:10 +0000
Date: Mon, 30 Mar 2026 02:13:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com, 
	vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org, peterz@infradead.org, 
	feng.tang@linux.alibaba.com, pawan.kumar.gupta@linux.intel.com, dapeng1.mi@linux.intel.com, 
	kees@kernel.org, elver@google.com, paulmck@kernel.org, lirongqing@baidu.com, 
	rppt@kernel.org, ardb@kernel.org, cfsworks@gmail.com, osandov@fb.com, 
	jbohac@suse.cz, tangyouling@kylinos.cn, sourabhjain@linux.ibm.com, 
	ritesh.list@gmail.com, eajames@linux.ibm.com, songshuaishuai@tinylab.org, 
	kevin.brodsky@arm.com, vishal.moola@gmail.com, junhui.liu@pigmoral.tech, 
	coxu@redhat.com, fuqiang.wang@easystack.cn, liaoyuanhong@vivo.com, 
	guoren@kernel.org, chenjiahao16@huawei.com, hbathini@linux.ibm.com, 
	takahiro.akashi@linaro.org, james.morse@arm.com, lizhengyu3@huawei.com, x86@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v11 10/11] arm64: kexec: Add support for crashkernel CMA
 reservation
Message-ID: <aco-v4BuRSiZx7yy@gmail.com>
References: <20260328074013.3589544-1-ruanjinjie@huawei.com>
 <20260328074013.3589544-11-ruanjinjie@huawei.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260328074013.3589544-11-ruanjinjie@huawei.com>
X-Debian-User: leitao

On Sat, Mar 28, 2026 at 03:40:12PM +0800, Jinjie Ruan wrote:
> Commit 35c18f2933c5 ("Add a new optional ",cma" suffix to the
> crashkernel= command line option") and commit ab475510e042 ("kdump:
> implement reserve_crashkernel_cma") added CMA support for kdump
> crashkernel reservation.
> 
> Crash kernel memory reservation wastes production resources if too
> large, risks kdump failure if too small, and faces allocation difficulties
> on fragmented systems due to contiguous block constraints. The new
> CMA-based crashkernel reservation scheme splits the "large fixed
> reservation" into a "small fixed region + large CMA dynamic region": the
> CMA memory is available to userspace during normal operation to avoid
> waste, and is reclaimed for kdump upon crash—saving memory while
> improving reliability.
> 
> So extend crashkernel CMA reservation support to arm64. The following
> changes are made to enable CMA reservation:
> 
> - Parse and obtain the CMA reservation size along with other crashkernel
>   parameters.
> - Call reserve_crashkernel_cma() to allocate the CMA region for kdump.
> - Include the CMA-reserved ranges for kdump kernel to use.
> - Exclude the CMA-reserved ranges from the crash kernel memory to
>   prevent them from being exported through /proc/vmcore, which is already
>   done in the crash core.
> 
> Update kernel-parameters.txt to document CMA support for crashkernel on
> arm64 architecture.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Tested-by: Breno Leitao <leitao@debian.org>

