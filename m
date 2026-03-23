Return-Path: <linuxppc-dev+bounces-18565-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820C1D58CB0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 01:59:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffGYb1q2Yz2ySB;
	Mon, 23 Mar 2026 12:58:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774231139;
	cv=none; b=hAvgWlFqlwFdCQ3F77VZXS2H6agkVfoVJQYL2fZE15iZQm//LY+bUEA1Y8U3IBZLc6LoofU8bcu74TYpf/8PLmbMi3yBoC2Mx4qzPNnMaO/A/0FFqkHSUNq7E5BBfk7cr6jES5w6CSt3DYaJrIU0Puodi4wZZB9XnbhVwcyM0dVuBuElOlT8VWBe/FHnXQDFh4Aqt8A50FCrInOqzp8wzT2uwDGAJbysE8Ve4hZ4zUxO+mlQ+p4HziORT6OjLQ/asnMx2JuTxfJ6cMTKETPIVRhsuUNsB+p8qdTdaIGpOP60hY3jlVml4DOd/nCpIQx6LEe+vd1SiwVAoLXG72Wfzw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774231139; c=relaxed/relaxed;
	bh=BnMGF1hF1WW6/Gtz51mz8K6u9S5YKJbEi/GgrCMRCcI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VdqmzBMFg7BRUqHjvNdjyGwLP3U2nOaHYHVRf+RQiDtuQBNs6cexHYfKmhSAf82JXiP8vf4T16mSTEK+TUV7G2nM5uS/35LKg6Q85pHUXBl8DIU3AG7FO417OkWeOzpf7XHJ2cSftZ+yWb9L3hDi8AooIPAUR47RHuJFK3bkGLmqlIxKO6xHZdonvAqiMMcGvOx1OJUWOoe/NNWC/CDj/ysQgawT3nwQ6TK+6ZVgNo3eSa8rX0m2YLbgze+eI2iyRr856nNBDrcDAN7AOLrEYqPYK6iXFe67gwu61tKY0CJDCx4x9tK1K8fRpF6MkgDpN8MUg7B/xiHtlVTCNfzcpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=VUjWpCug; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=VUjWpCug;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffGYZ2rPYz2xQ1
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2026 12:58:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 82BAC43BA4;
	Mon, 23 Mar 2026 01:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDC1C19424;
	Mon, 23 Mar 2026 01:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774231135;
	bh=BnMGF1hF1WW6/Gtz51mz8K6u9S5YKJbEi/GgrCMRCcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VUjWpCugJPseIiCzojaappy2G56EwCcFlTk+RHuPMDdvwdR+EnL347w7LI3UCkvJb
	 p9PH86lqJGd5d9hIqvjbLcmg8iQU6feQ0ZVbWqW3VTot+FFLI/AX0mmwLJnk/ehCFb
	 exrnpKMx8yIqEq95ldNOVe4Nf90pZVklGv2yI3F8=
Date: Sun, 22 Mar 2026 18:58:53 -0700
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
 <dyoung@redhat.com>, <rdunlap@infradead.org>, <pmladek@suse.com>,
 <dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <paulmck@kernel.org>,
 <lirongqing@baidu.com>, <fvdl@google.com>, <rppt@kernel.org>,
 <ardb@kernel.org>, <leitao@debian.org>, <sourabhjain@linux.ibm.com>,
 <jbohac@suse.cz>, <cfsworks@gmail.com>, <osandov@fb.com>,
 <tangyouling@kylinos.cn>, <ritesh.list@gmail.com>,
 <hbathini@linux.ibm.com>, <eajames@linux.ibm.com>,
 <songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
 <samuel.holland@sifive.com>, <vishal.moola@gmail.com>,
 <junhui.liu@pigmoral.tech>, <coxu@redhat.com>, <liaoyuanhong@vivo.com>,
 <fuqiang.wang@easystack.cn>, <brgerst@gmail.com>, <x86@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
 <devicetree@vger.kernel.org>, <kexec@lists.infradead.org>
Subject: Re: [PATCH v8 0/5] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-Id: <20260322185853.e8e43c346ed98a0ef0544948@linux-foundation.org>
In-Reply-To: <ce99a024-f910-cd83-c60a-28e60db318d3@huawei.com>
References: <20260302035315.3892241-1-ruanjinjie@huawei.com>
	<ce99a024-f910-cd83-c60a-28e60db318d3@huawei.com>
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

On Mon, 23 Mar 2026 09:44:21 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> If there are no other review comments, I'd like to ask if this is ready
> to be merged.

This patchset predates the introduction of the Sashiko AI review, and
that thing is proving very good at finding issues.

So can you please update the changelog footers for thus-far-received
acks/reviews and then resend?

Thanks.


