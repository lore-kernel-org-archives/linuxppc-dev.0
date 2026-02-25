Return-Path: <linuxppc-dev+bounces-17195-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F295FD3769
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Feb 2026 15:51:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fLfFj4WwLz3f57;
	Thu, 26 Feb 2026 02:51:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772034665;
	cv=none; b=LavDt+zCRRsDgoPtShMwMOa+b2QcSC03NCwb3mCZQmQS+kFhIMTDuaq+S85azkX5oNssZYbGJKbBdgdtRq/cmLAsWlHmvl2jt8o9Vfd2FuDiIgcwLSwYATfkqc2+1IzLjOX0kYhl87jCJda6ucQ5HEShjVITVR3UoNKpjUGjg1mJJikbqiU0nUEyBqZtBC+s/tSKRqblILdU27jFdtlgbQMLP+ExXnI2F6Ow1hNu+v+t/DWeApW8ZSs75UrW2+HOb2r4h+cZ33M9/xMYtBYgT3dkJycFWBi/TSzuUL5fhHE6kWROTXFgJSgOHvgpUL5nyOe1gutCcE4QJp1quSM12A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772034665; c=relaxed/relaxed;
	bh=B+KvzGktl0ZDAEDtD8V6fB+I7vhLmiBdZuB2qUwdvR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHBdJDV5UWQlX4NeKv+kqc5uZCMW7UJ2I7lzw4zaHAYTXpMqfN7uzMDsxJTYkZ3VqZ8o5XUI2YEmSL60X1Ays1c8fPjg4gKSkljMBHdsD3q1ddskz/ZQfS3UyG+6Y6igAs9InHvT41Q8FkEQ4AhNO3NCYjw0EEF+haG5w+hzqB27vxACEw+Eq9VHJDoqkFNHVgjG1g/lClldGrZmq4WaD5eJl9DUImZgSQC8lh6iBACKtHkN4NrHqYAyGb0j3GWgSjB9rlMtaiJ3Nkbw0qjFZieS8X/BTR/vh5C0fI9EytrGrTr4xtNpyqiTtey3QLEhZ1WVZ7o99abMfq2O50YQcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N8o8c6fx; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N8o8c6fx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fLfFh5r3vz3f4W
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 02:51:04 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4ABB04327E;
	Wed, 25 Feb 2026 15:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187F0C116D0;
	Wed, 25 Feb 2026 15:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772034663;
	bh=X8g+EKJL0vZnYgJbnZJBCkMj0KCIXHLnrvIicphTvcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8o8c6fx7S2iXqLGrOBHQYvcEjWQG5022FEv9UcaDkP34xHM0E5ber/YhVZZJ7TDJ
	 CmonH3kI+u7XPVDT6HakxUNk6XaTfLiUErrtz15xA+amKw+aR7DLJxX5crqo3Vj23y
	 ha8ymHj5xiUMc7OdnyEepYVJrN8Xo9CXha27eWqxeexBZWgLI8h5Se7XX6MsM3qOYC
	 PueqjmhMJa59WDVNHonUx88k63SjrdKBN71BGuIPR/BImGSF37PiacUkuArAzcg6zs
	 7txFnlhhrz7LlIGf8EGIHyQZ/UYqfI6d9lioag4Y/n6KbkRjxo5SIKImiSdoeutd6u
	 yWRrawVpZN9Sw==
Date: Wed, 25 Feb 2026 17:50:45 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, akpm@linux-foundation.org, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org,
	pmladek@suse.com, dapeng1.mi@linux.intel.com, kees@kernel.org,
	paulmck@kernel.org, lirongqing@baidu.com, arnd@arndb.de,
	ardb@kernel.org, leitao@debian.org, cfsworks@gmail.com,
	ryan.roberts@arm.com, sourabhjain@linux.ibm.com,
	tangyouling@kylinos.cn, eajames@linux.ibm.com,
	hbathini@linux.ibm.com, ritesh.list@gmail.com,
	songshuaishuai@tinylab.org, samuel.holland@sifive.com,
	kevin.brodsky@arm.com, vishal.moola@gmail.com,
	junhui.liu@pigmoral.tech, coxu@redhat.com, liaoyuanhong@vivo.com,
	fuqiang.wang@easystack.cn, jbohac@suse.cz, brgerst@gmail.com,
	x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, kexec@lists.infradead.org
Subject: Re: [PATCH v6 0/5] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-ID: <aZ8aVU8qIHue-khK@kernel.org>
References: <20260224085342.387996-1-ruanjinjie@huawei.com>
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
In-Reply-To: <20260224085342.387996-1-ruanjinjie@huawei.com>

On Tue, Feb 24, 2026 at 04:53:37PM +0800, Jinjie Ruan wrote:
> The crash memory allocation, and the exclude of crashk_res, crashk_low_res
> and crashk_cma memory are almost identical across different architectures,
> This patch set handle them in crash core in a general way, which eliminate
> a lot of duplication code.
> 
> And add support for crashkernel CMA reservation for arm64 and riscv.
> 
> Rebased on v7.0-rc1.
> 
> Basic test were performed on QEMU platforms for x86, ARM64, and RISC-V
> architectures with the following parameters:
> 
> 	"cma=256M crashkernel=256M crashkernel=64M,cma"
> 
> Changes in v6:
> - Update the crash core exclude code as Mike suggested.
> - Rebased on v7.0-rc1.
> - Add acked-by.
> - Link to v5: https://lore.kernel.org/all/20260212101001.343158-1-ruanjinjie@huawei.com/
> 
> Changes in v5:
> - Fix the kernel test robot build warnings.
> - Sort crash memory ranges before preparing elfcorehdr for powerpc
> - Link to v4: https://lore.kernel.org/all/20260209095931.2813152-1-ruanjinjie@huawei.com/
> 
> Changes in v4:
> - Move the size calculation (and the realloc if needed) into the
>   generic crash.
> - Link to v3: https://lore.kernel.org/all/20260204093728.1447527-1-ruanjinjie@huawei.com/
> 
> Changs in v3:
> - Exclude crash kernel memory in crash core as Mike suggested.
> - Add acked-by.
> 
> Jinjie Ruan (4):
>   crash: Exclude crash kernel memory in crash core
>   crash: Use crash_exclude_core_ranges() on powerpc
>   arm64: kexec: Add support for crashkernel CMA reservation
>   riscv: kexec: Add support for crashkernel CMA reservation
> 
> Sourabh Jain (1):
>   powerpc/crash: sort crash memory ranges before preparing elfcorehdr

Overall LGTM, I had a comment about arm64 and riscv patches, but other than
that

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

