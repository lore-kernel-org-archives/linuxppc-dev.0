Return-Path: <linuxppc-dev+bounces-20233-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BDBFF885D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Apr 2026 10:53:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g4cjF1dGjz2xlt;
	Tue, 28 Apr 2026 20:53:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777373585;
	cv=none; b=OkfkGueAAUHYestE1M/iWdctA+Zt314p0mM7mWeIhihEXQ2vvIJYAOSyCoHWu8kVPp9aSzLg5Mt70vFAswLrSG+TE0qxBV4hnLRng6PO9dKhRG/U75xoeqFxXHaDBnSCcFNPdHqq619WdLacpKaAuinpbVBrLfKwj3l1EL+DIVcbyh5uQSbQV83FUOhld0mIPsFnFsGPghah3fX73uw37/2mcoifHx5qobhxuMvMK8t1JD1FyPpJa5RSSkN+bb9COJtCnJdNTekRZX+DOLE/uTlmR90xiiovz3b4fjBswosxkggnvFJj6Ybiiv1f8CClfN/n9PuynNzRQcdr7UrNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777373585; c=relaxed/relaxed;
	bh=/kcAa+eYw+w8N+t1zkqKB0Re/K/IdRQcrTEU3juInUg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SlOL8cPmn60xQ9QxwGRSqTfYjC64idZkIWeo9gMF2vqSQe6Y3+7sLF4XLdqnbErUGvpX+SmpabzfmUL0v07EgqvEM7vgIwPq9KSHiYFTyPuVBF6qWFIkD1VvKb+9MUC65Fd34Z/YsIG5B/IDknyuPBC67kdRk0deKRJbaiFPNpL/0spkdpC+3DZ4eROkI+7dwMqGPjvkYavHueXPoU+y5YIj+wlHXp41i600YaHdSYZ1l6LZCkyM/4E8XvK0qIbTsxXNpcsv0KErk7ooEiUjDUEhFdvbe5LlYHRYqnNbT9irlYnne8ijTljLfVz2rCgY2LF9TGoozudCyoye9rpFjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Qsqv6r1l; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Qsqv6r1l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g4cjC1JPcz2xld
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2026 20:53:02 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6A3D860141;
	Tue, 28 Apr 2026 10:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEE5C2BCAF;
	Tue, 28 Apr 2026 10:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777373579;
	bh=FAkK0ftN7gWUbuk+HZ/TnP99n+RR4S9QM3ioJ/hUWvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qsqv6r1lJZq/c7ZPtIt0sZl/DuaHenFFdJWV+kUZfKy9lze4sbNHOT4ldBEvZsMcI
	 IzA4ewciHKUUGkWs11knSBEVXzjvVrxdGd/P9JBd6VWThd9m0HhwDsNHUrAT8OtKfZ
	 vkIpz9kt+ca77YyWoiGiskB7TOq8ICE0RWcWLVHM=
Date: Tue, 28 Apr 2026 03:52:56 -0700
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
 <pawan.kumar.gupta@linux.intel.com>, <feng.tang@linux.alibaba.com>,
 <dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
 <paulmck@kernel.org>, <lirongqing@baidu.com>, <rppt@kernel.org>,
 <leitao@debian.org>, <ardb@kernel.org>, <jbohac@suse.cz>,
 <cfsworks@gmail.com>, <tangyouling@kylinos.cn>,
 <sourabhjain@linux.ibm.com>, <ritesh.list@gmail.com>,
 <hbathini@linux.ibm.com>, <eajames@linux.ibm.com>, <guoren@kernel.org>,
 <songshuaishuai@tinylab.org>, <kevin.brodsky@arm.com>,
 <vishal.moola@gmail.com>, <junhui.liu@pigmoral.tech>, <coxu@redhat.com>,
 <fuqiang.wang@easystack.cn>, <liaoyuanhong@vivo.com>,
 <takahiro.akashi@linaro.org>, <james.morse@arm.com>,
 <lizhengyu3@huawei.com>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <kexec@lists.infradead.org>
Subject: Re: [PATCH v12 00/15] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-Id: <20260428035256.cbb3ac77c4bbb89bb7efcc19@linux-foundation.org>
In-Reply-To: <dfa24c4b-a423-4c80-9a8f-28c577c9ec11@huawei.com>
References: <20260402072701.628293-1-ruanjinjie@huawei.com>
	<dfa24c4b-a423-4c80-9a8f-28c577c9ec11@huawei.com>
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

On Tue, 28 Apr 2026 11:30:13 +0800 Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> It seems the patches for crash core rework, powerpc, riscv, and arm64
> are mostly ready to be merged. Could any maintainer help pick these up,
> or should I rebase the entire series against v7.1-rc1?

April 2 is prehistoric ;)

Yes, refresh, retest, resend.  Note that there have been maintainership
shuffles in this area.  

KDUMP
M:	Andrew Morton <akpm@linux-foundation.org>
M:	Baoquan He <bhe@redhat.com>
M:	Mike Rapoport <rppt@kernel.org>
M:	Pasha Tatashin <pasha.tatashin@soleen.com>
M:	Pratyush Yadav <pratyush@kernel.org>
R:	Dave Young <ruirui.yang@linux.dev>
L:	kexec@lists.infradead.org
S:	Maintained
F:	Documentation/admin-guide/kdump/
F:	fs/proc/vmcore.c
F:	include/linux/crash_core.h
F:	include/linux/crash_dump.h
F:	include/uapi/linux/vmcore.h
F:	kernel/crash_*.c

I believe that Pasha/Mike/Pratyush are setting up a git tree, but there
isn't one listed here?


