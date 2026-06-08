Return-Path: <linuxppc-dev+bounces-22275-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7D9CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:10:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYxp84DYCz3bpG;
	Tue, 09 Jun 2026 02:10:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780935008;
	cv=none; b=dBx30hVrLgoCFbVB5tMKPAXMnux4UDtg0ekmHh3wlyG2JvUDZ09++yN88eGlmXU38etg9kzW7vclBgICXqo4IvQPW03YI9G+VhGxf26ZOADoeGUEG4NndugcljkLhvLKrgGBU1RgjWzvStL7j0IKB1GKpekTbmb9bqwd4wOTVHT0agYyJyKYPAJk+UcW9nrWH8K9PvJwNBsO3u0pJB4qS+p1lxc2K1RKpcJAquLTmcVgrZzi3ehaAPGYWTDlOn+E6qW0GDpOUkK/whX06AOJ8aOAcbVF1mrvO8M/BdSRtdN++KYYZPfUEcq10kXJO9xJoLrQNod7e3GzrVxaLGtc6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780935008; c=relaxed/relaxed;
	bh=HeNvzEtTTeAyiynvrWR03BeK5a7m/jtKDrW58LkAIDk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=j6hevIIDEaTwX1be7c4ahpK5NK1dO3tAnBEHquxisqmts9jYkMQT0YviAiED+3JN9Ew7+uIZWpJWLxQsx5xYAPpwwOeYU2L6mEcUj0WPq6v7Ql2LCBV4ayy+swxMg6WooyIl8LAj7OYnxtdWuATmrF3iH+67bXUjkckPbeW4edak+4n7+xa5GPxnh5BqbvktKA1NsEAlbh5Al03SgId6Ep7sRF9tBuVMjKeZyRL7tINcy6RdT/b5jVbDOr2CWy/uvyUp0+K86cHvG0C1simLQLJXE3tL17D3e2YUu9LHLxNJRod3RiKSd2d3vVC+AXJUubVYfovSyFlmiYYv1dxN7w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=NGHfBNMS; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=NGHfBNMS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYxp66YpXz30FP
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 02:10:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1FA9842DF0;
	Mon,  8 Jun 2026 16:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F0E1F00893;
	Mon,  8 Jun 2026 16:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1780935003;
	bh=HeNvzEtTTeAyiynvrWR03BeK5a7m/jtKDrW58LkAIDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NGHfBNMS1rlirWFtfC0pDdz7EzZeHjyxYg9Ca3Sjn1pulZaZLIDmOYvJmcZBYsc93
	 VQpg5Ivsba3rTH79/1M55QufUmF/lQ9H/jskqKdHB8HrOkPOEhSgnQUMV9M34B2Iz8
	 Fh7VryrdGwslXF2Cr1sq+hzZtoOSb/V4p5rwEeS0=
Date: Mon, 8 Jun 2026 09:10:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <catalin.marinas@arm.com>, <will@kernel.org>, <chenhuacai@kernel.org>,
 <kernel@xen0n.name>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
 <npiggin@gmail.com>, <chleroy@kernel.org>, <pjw@kernel.org>,
 <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
 <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <robh@kernel.org>,
 <saravanak@kernel.org>, <bhe@redhat.com>, <rppt@kernel.org>,
 <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
 <ruirui.yang@linux.dev>, <rdunlap@infradead.org>, <peterz@infradead.org>,
 <feng.tang@linux.alibaba.com>, <dapeng1.mi@linux.intel.com>,
 <kees@kernel.org>, <elver@google.com>, <kuba@kernel.org>,
 <lirongqing@baidu.com>, <ebiggers@kernel.org>, <paulmck@kernel.org>,
 <leitao@debian.org>, <coxu@redhat.com>, <Liam.Howlett@oracle.com>,
 <ryan.roberts@arm.com>, <osandov@fb.com>, <jbohac@suse.cz>,
 <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
 <sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
 <adityag@linux.ibm.com>, <liaoyuanhong@vivo.com>, <seanjc@google.com>,
 <fuqiang.wang@easystack.cn>, <ardb@kernel.org>, <chenjiahao16@huawei.com>,
 <guoren@kernel.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <kexec@lists.infradead.org>
Subject: Re: [PATCH v16 00/10] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-Id: <20260608091000.d88d7f5cc1bc4fa17f5774fe@linux-foundation.org>
In-Reply-To: <20260608073459.3119290-1-ruanjinjie@huawei.com>
References: <20260608073459.3119290-1-ruanjinjie@huawei.com>
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

On Mon, 8 Jun 2026 15:34:49 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> This patch set handle them in crash core in a general way, which eliminate
> a lot of duplication code.
> 
> And add support for crashkernel CMA reservation for arm64 and riscv.

fyi, AI review might have found a bunch of issues in arch-specific
code, all of them pre-existing.

	https://sashiko.dev/#/patchset/20260608073459.3119290-1-ruanjinjie@huawei.com

