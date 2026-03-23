Return-Path: <linuxppc-dev+bounces-18632-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FD8F483C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 16:44:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fffCf3J58z2yFb;
	Tue, 24 Mar 2026 03:44:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774284286;
	cv=none; b=BRehPAyrS2jrOsKVACY0J4lMcRFr3st8QKTeekyJOJaVSJZjX92mHsl+wg6MU2heDwD9CMauKAosMYogJ+77P4612KPQbWODJB47nHp7egHUV0xR8nK77xvlkugYQ4Z2msNM2OwGWSyhwpttwYvM7zobmRGaegIgJQbF0Ff/Vxu4SE1qF5uWzt6isQP9FxdDqbIXOj9HhSIA15mSWARjuvpnG9UEpUbgxbyPnKjBbH1joufonlil0fYslf3UdgvaJkwy+l6Winb9PM4hAAeRdwPOtmce4fkAVTREHqYtZXBvCG8Xx3uqHPtfaYq4+fgeNCPYxUBe4dUtX/GbkPJYog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774284286; c=relaxed/relaxed;
	bh=u646cOHMJ/zTHL9+VZ4W7Ux0q5cDJeWhhX/W1yOam3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEu+/jElhogpZZq976rcy5KER2wnSRgbu2phFSNUvOcno4y9j/ChCfr04Nd6jF88v9EYY81avF72RSiJonQB2YQ5fhYTS7adKDKRXO9yW4BJV1jJ4yUpICuO2eUzpWeBfF19Mc8BLLMNOwZeSzfyYvzfWhwxODV8CQrcXcRKZ00V1/YYmXNwoCehOxSUCicYeRX4aLCoNpRdiHLIgvZk1kUnTa3jD72HghWRCXCkTVEEfpmfVa80AiS3nni+4ClyYXnIwe1zaxi4z49trB5q0FgIV/6aBW/OwPp8QBClTH8+9Nt/4fIX0GVUZ+RnEWDdPhrNmA/rb/FD2W2ziwBMjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org; dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=dlZIzt5Y; dkim-atps=neutral; spf=none (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org) smtp.mailfrom=debian.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=dlZIzt5Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=debian.org (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org)
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fffCd1H9Hz2xs4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 03:44:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=u646cOHMJ/zTHL9+VZ4W7Ux0q5cDJeWhhX/W1yOam3I=; b=dlZIzt5YzevTl4QnSJxxDuhppU
	q2WiFtssembwHpot97e7p66yyqpF3dN8xA6eo3mU9Y5cs77fG/ib/E0pmR2yPSYUbOk1yB04ldCYA
	8ZSzKzhPXOJ2uxLAeNtLzVEnC72HyX/Da0COA18pwxZ18OR3/xTPzoczvd+eOfdbXU+oe4D6zXNln
	RL3AID6EDlGZkPD4dqQGcVL8hyyuo84fScfgh1+HpHr0th+N7IyqowEsgziGLLV0rZFhpAPGgdSUN
	uSgV3My9CRMDXuTe1oUCC4dNUN3U7nThOJTD+Dmv8QRP2jO2Jg1/VT/h7vj784PI985iF8yh77g2G
	eh4Qqoxg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w4iMe-007fRI-16; Mon, 23 Mar 2026 16:42:50 +0000
Date: Mon, 23 Mar 2026 09:42:38 -0700
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
	safinaskar@gmail.com, rppt@kernel.org, ardb@kernel.org, jbohac@suse.cz, 
	cfsworks@gmail.com, osandov@fb.com, tangyouling@kylinos.cn, 
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com, eajames@linux.ibm.com, 
	songshuaishuai@tinylab.org, kevin.brodsky@arm.com, samuel.holland@sifive.com, 
	vishal.moola@gmail.com, junhui.liu@pigmoral.tech, coxu@redhat.com, liaoyuanhong@vivo.com, 
	fuqiang.wang@easystack.cn, x86@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org
Subject: Re: [PATCH v9 4/5] arm64: kexec: Add support for crashkernel CMA
 reservation
Message-ID: <acFtMLyCWbYOyFZT@gmail.com>
References: <20260323072745.2481719-1-ruanjinjie@huawei.com>
 <20260323072745.2481719-5-ruanjinjie@huawei.com>
 <acETyW3FYaWCShUc@gmail.com>
 <a5694ee0-7a95-4c15-6775-990d70c8d77b@huawei.com>
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
In-Reply-To: <a5694ee0-7a95-4c15-6775-990d70c8d77b@huawei.com>
X-Debian-User: leitao

On Mon, Mar 23, 2026 at 07:17:21PM +0800, Jinjie Ruan wrote:
> 
> 
> On 2026/3/23 18:20, Breno Leitao wrote:
> > On Mon, Mar 23, 2026 at 03:27:44PM +0800, Jinjie Ruan wrote:
> >> Commit 35c18f2933c5 ("Add a new optional ",cma" suffix to the
> >> crashkernel= command line option") and commit ab475510e042 ("kdump:
> >> implement reserve_crashkernel_cma") added CMA support for kdump
> >> crashkernel reservation.
> >>
> >> Crash kernel memory reservation wastes production resources if too
> >> large, risks kdump failure if too small, and faces allocation difficulties
> >> on fragmented systems due to contiguous block constraints. The new
> >> CMA-based crashkernel reservation scheme splits the "large fixed
> >> reservation" into a "small fixed region + large CMA dynamic region": the
> >> CMA memory is available to userspace during normal operation to avoid
> >> waste, and is reclaimed for kdump upon crash—saving memory while
> >> improving reliability.
> >>
> >> So extend crashkernel CMA reservation support to arm64. The following
> >> changes are made to enable CMA reservation:
> >>
> >> - Parse and obtain the CMA reservation size along with other crashkernel
> >>   parameters.
> >> - Call reserve_crashkernel_cma() to allocate the CMA region for kdump.
> >> - Include the CMA-reserved ranges for kdump kernel to use.
> >> - Exclude the CMA-reserved ranges from the crash kernel memory to
> >>   prevent them from being exported through /proc/vmcore, which is already
> >>   done in the crash core.
> >>
> >> Update kernel-parameters.txt to document CMA support for crashkernel on
> >> arm64 architecture.
> >>
> >> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> >> Acked-by: Baoquan He <bhe@redhat.com>
> >> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> >> ---
> >> v7:
> >> - Correct the inclusion of CMA-reserved ranges for kdump
> >>   kernel in of/kexec.
> >> v3:
> >> - Add Acked-by.
> >> v2:
> >> - Free cmem in prepare_elf_headers()
> >> - Add the mtivation.
> >> ---
> >>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
> >>  arch/arm64/kernel/machine_kexec_file.c          | 2 +-
> >>  arch/arm64/mm/init.c                            | 5 +++--
> >>  drivers/of/fdt.c                                | 9 +++++----
> >>  drivers/of/kexec.c                              | 9 +++++++++
> >>  5 files changed, 19 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >> index cb850e5290c2..afb3112510f7 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -1121,7 +1121,7 @@ Kernel parameters
> >>  			It will be ignored when crashkernel=X,high is not used
> >>  			or memory reserved is below 4G.
> >>  	crashkernel=size[KMG],cma
> >> -			[KNL, X86, ppc] Reserve additional crash kernel memory from
> >> +			[KNL, X86, ARM64, PPC] Reserve additional crash kernel memory from
> >>  			CMA. This reservation is usable by the first system's
> >>  			userspace memory and kernel movable allocations (memory
> >>  			balloon, zswap). Pages allocated from this memory range
> >> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> >> index c338506a580b..cc577d77df00 100644
> >> --- a/arch/arm64/kernel/machine_kexec_file.c
> >> +++ b/arch/arm64/kernel/machine_kexec_file.c
> >> @@ -42,7 +42,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
> >>  #ifdef CONFIG_CRASH_DUMP
> >>  unsigned int arch_get_system_nr_ranges(void)
> >>  {
> >> -	unsigned int nr_ranges = 2; /* for exclusion of crashkernel region */
> >> +	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* for exclusion of crashkernel region */
> > 
> > You update arch_get_system_nr_ranges() to account for CMA ranges, but
> > prepare_elf_headers() in the same file (line 51) still has the
> > hardcoded:
> > 
> >         nr_ranges = 2; /* for exclusion of crashkernel region */
> 
> I don't see any logic related to prepare_elf_headers() or hardcoded
> nr_ranges = 2 in the arm64 implementation.

Just ignore me here, I've mis applied the patch, and then I got
arch_get_system_nr_ranges() and prepare_elf_headers(), but, they are the
same thing at in here.

> > 
> > and does not exclude CMA ranges from cmem. If the generic crash core
> > handles CMA exclusion from vmcore, then shouldn't
> > arch_get_system_nr_ranges() also not need this change?
> > 

