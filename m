Return-Path: <linuxppc-dev+bounces-18822-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A61910A1E65
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 10:54:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhLJP0nPcz2yd7;
	Thu, 26 Mar 2026 21:54:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774522485;
	cv=none; b=eZ8FPdvt64kkUzovRLEeQ9nzlIfYZlER7SUvYbJ/eRP41xtLcIb6+Hb7ByO/EOQecYO1TIPVGlhDOqeZHjvouiN91uXJcpz3i124nwoTXGJLUuNREnDeyRcWvEe3E42DxeK52iBQfCzZ43P8dvotpojJQeNea0nzWB3zf8JsnwJE7qGk1bnQQvzZOIvWt1NsNd2gyfUzoxRymF8QwiFdeh/Gq0sOwdBflbIx9cq0bNIVTlUfoHpbfV7Rw9OXa7WFpNSmSJhJqhTqNV+5PLOG5HfNa1nsA2WVbHJ2IcvuR1ZMIcVW2LZM84UAqfb7OsVPbxtGSEyOC2N/+bEY+hJz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774522485; c=relaxed/relaxed;
	bh=cafOVGJhVpKtrDApJntdDFDO00PImuG+jp56XDPXWNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJq9/bEbXqUaFyANNL1UIKjyYK63GMHMKGr3wiQyKKW6S0ensQJQpKCzBjKXz5XadY67bkX+0/dQlbz5syYOhCeQopMnGK1D9n/1ItZ1e0GzMzNn5daGC1TXJaAxwubnbf7d7IKBnUoSHzGw/rj7jPPxcU0XW8KvNADzRgoKdU89RWNw+q3rMiLOVnh9BWt9b8/eAg38a26PDpyi9IM5If1/AldT3z+NaoWXhcUdgHN7pPknb4/9i0tWRgSxdkze6l6/roJ/cgdSqaf7leqV5NBOBGD0xlfxymOxa1fGQCkBY83jjcAO1DwKop2C89HxedfA3Cx0f24bVoREjPkmYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YVuxS70w; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YVuxS70w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=catalin.marinas@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhLJM6Hn5z2yS4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 21:54:43 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9240222F8;
	Thu, 26 Mar 2026 03:54:06 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E50D13FB90;
	Thu, 26 Mar 2026 03:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1774522452; bh=8IXmdtIFEytfMHYy2/zN6eUVEhDW6CUJvZu3Mba6/Z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YVuxS70wtA+CNyc+9Yfuu8kLdwGx0hAOW4qIgVCCdqd3eWV81ySjZ1drGGhP2OXoL
	 +ZNCcv/2wvx0wEMhP2Dp3UCFRMfOF2SBHpPH29ZkEJibdsvI0zy0/8alDG7Ivbi7i4
	 oE7duHHNhvv6uUVGYqsXoDVURWRztrpZN8osSmlg=
Date: Thu, 26 Mar 2026 10:54:01 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, will@kernel.org,
	chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org,
	saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org,
	peterz@infradead.org, pawan.kumar.gupta@linux.intel.com,
	feng.tang@linux.alibaba.com, dapeng1.mi@linux.intel.com,
	kees@kernel.org, elver@google.com, paulmck@kernel.org,
	lirongqing@baidu.com, rppt@kernel.org, ardb@kernel.org,
	leitao@debian.org, osandov@fb.com, cfsworks@gmail.com,
	tangyouling@kylinos.cn, sourabhjain@linux.ibm.com,
	ritesh.list@gmail.com, eajames@linux.ibm.com,
	songshuaishuai@tinylab.org, kevin.brodsky@arm.com,
	samuel.holland@sifive.com, vishal.moola@gmail.com,
	junhui.liu@pigmoral.tech, coxu@redhat.com, liaoyuanhong@vivo.com,
	jbohac@suse.cz, fuqiang.wang@easystack.cn, guoren@kernel.org,
	chenjiahao16@huawei.com, hbathini@linux.ibm.com,
	james.morse@arm.com, takahiro.akashi@linaro.org,
	lizhengyu3@huawei.com, x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v10 6/8] arm64: kexec: Add support for crashkernel CMA
 reservation
Message-ID: <acUQSSNgxCCK5LnI@arm.com>
References: <20260325025904.2811960-1-ruanjinjie@huawei.com>
 <20260325025904.2811960-7-ruanjinjie@huawei.com>
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
In-Reply-To: <20260325025904.2811960-7-ruanjinjie@huawei.com>

On Wed, Mar 25, 2026 at 10:59:02AM +0800, Jinjie Ruan wrote:
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
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Baoquan He <bhe@redhat.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

