Return-Path: <linuxppc-dev+bounces-29020-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8904ECA5FFD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 03:34:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0bFT4FGCz2yWy;
	Thu, 08 Oct 2026 14:34:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::3e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791430445;
	cv=none; b=ZWKxbvfHTCV8VxNq0J5tgbj+eXcRw6+lHjgmLyJeitoS/ILrGl84riuTnZ9O3gWpmPCaYUhi3H2A+6JlpyKDunMUUhdsC/LIPZFdz4zHh/Vmv4mTvfAJXd+KXZNm65eKGgiEu24S8nJW3w0iuTxl8lPt72AwMrBlkmgI656+cbtK1Wd1BrIB85AdW/ejuMVWlUlSaprb8eYaukXaCHjHawpSVUuL89I5mZKbmuAes0gd516GnPyak2oJs9BdVzxs955CzImpKXijmuWAXX9QIVihpXpNuVS9UF5lVbinOP3RS2+6XUsCCfx94T1qZNaPcPdszRkx9IzG3QzrzMPH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791430445; c=relaxed/relaxed;
	bh=utCPSZvpjilWfg61MLNxidAF6z77XObpS8R/pvNjMCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEkYM1r1rvyzD0Gx9NFJQCDhXVFOyssb+7m7aLOwyCxsHhjObni2+XqA6FGnnBSOghXuF/GqjxWdiHWs52i2zjpms1lRPVZrp9HzVOmzn+GiTKg7SW76Z4c1EmUnIyRQkduGLTWogYLlvYvHP4SIHGfknSHnvgzVW/O/lJZKGnu5DuIQRxhKk37GKJR8yANVPTzPl2XboRsWRVtYufgSM5yEkkRyf74OknguXVPDhup/dp52DNoxaDG4jyTWtWjBpJlxB+JK6+n5eGFzYH7mimCe0fVJZFVhVkXMGv8NHECIXyRw02yqVGW8C4nP1gveBw1upiyXqr1+iejz2sr0/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MGfOmI3W; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::3e; helo=mta0.migadu.com; envelope-from=baoquan.he@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MGfOmI3W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::3e; helo=mta0.migadu.com; envelope-from=baoquan.he@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 319 seconds by postgrey-1.37 at boromir; Thu, 08 Oct 2026 14:34:00 AEDT
Received: from mta0.migadu.com (out-62.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0bFN6wZVz2y8p
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 14:34:00 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=gmfp3ivCG1+n0TaJLGaQX1ngoAFvegNr6FLCt8R7HoA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791430422; v=1; x=1792035222;
 b=MGfOmI3WmEbNSUsTqOa0vLovFzYnv0fiL0kPHO4J8rWCjm4H8s8uAGqxbG9oEg7gWIvZpR9/
 s+GPZydnKHZOa7Voigek0wYZdKlHtWUCk7ukD0svH8/lQA1rXxhhu96wqsnYg46O/iZX6KknOUC
 3QgeLB8Rs+wwdeqjFJ53aSs8=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta12.migadu.com with ESMTPS id 94fa78c7ea5d33cd;
	Thu, 08 Oct 2026 03:26:54 +0000
X-Mizu-Trace-ID: 94fa78c7ea5d33cd
X-Migadu-Flow: FLOW_OUT
Date: Thu, 8 Oct 2026 11:26:46 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	ritesh.list@gmail.com, sshegde@linux.ibm.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org, akpm@linux-foundation.org, rppt@kernel.org,
	pasha.tatashin@soleen.com, pratyush@kernel.org,
	ruirui.yang@linux.dev, leitao@debian.org, yeoreum.yun@arm.com,
	sourabhjain@linux.ibm.com, robh@kernel.org, coxu@redhat.com,
	kees@kernel.org, tangyouling@kylinos.cn, liukexin@kylinos.cn,
	zhangtianyang@loongson.cn, guodongtai@kylinos.cn,
	maqianga@uniontech.com, chao.gao@intel.com, kai.huang@intel.com,
	vishal.l.verma@intel.com, seanjc@google.com, piliu@redhat.com,
	thuth@redhat.com, jbouron@amazon.com, me@linux.beauty,
	mclapinski@google.com, graf@amazon.com, bgwin@google.com,
	hbathini@linux.ibm.com, eric.devolder@oracle.com,
	takahiro.akashi@linaro.org, james.morse@arm.com,
	palmer@rivosinc.com, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	driver-core@lists.linux.dev, kexec@lists.infradead.org
Subject: Re: [PATCH v6 00/14] crash: Fix several bugs
Message-ID: <ascNduTeakZBflVS@fedora>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <f4ba3a6b-537d-4328-b0c1-c0e5aa61924f@huawei.com>
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
In-Reply-To: <f4ba3a6b-537d-4328-b0c1-c0e5aa61924f@huawei.com>

On 10/08/26 at 09:57am, Jinjie Ruan wrote:
> 
> 
> 在 2026/9/21 17:04, Jinjie Ruan 写道:
> > As Baoquan and Catalin suggested, this patch set fixes
> > several pre-existing code issues found by Sashiko AI [1][2][3].
> > 
> > The major improvements and fixes included in this series are:
> > - Fix several memory leaks for arm64, and similar issues on LoongArch.
> > - Fix out-of-bounds write on 32-bit Highmem for x86.
> > - Fix TOCTOU race in crash memory range collection.
> 
> Hi all,
> 
> Gentle ping.
> 
> Could anyone take a look or let me know if there's anything
> else needed? I can rebase/resend if required.

They may need reviewing and ack from different arch. E.g patch 1,
even though it's changed in kernel/kexec_core.c, the arm64 specific
handling need be checked and confirmed by arm64 expert.

I can review changes in generic code and arch I am familiar with, while
those part I am unfamiliar with need be reviewed by experts of specific
area.

> 
> > 
> > This patch set is rebased on v7.3-rc3. Compared to the previous version,
> > split out arm64 crash hotplug patches as Breno suggested, which are based
> > on these bugfix patches and will be resubmitted after this patch series
> > is merged.
> > 
> > Slightly tested on x86_64 and arm64 qemu with:
> > - kexec_load (--kexec-syscall --hotplug)
> > - kexec_load (--kexec-file-syscall)
> > 
> > All boot successfully into the second kernel.
> > 
> > [1]: https://lore.kernel.org/all/20260601094805.2928614-1-ruanjinjie@huawei.com/
> > [2]: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%40huawei.com
> > [3]: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%40huawei.com
> > 
> > Changes in v6:
> > - Split out arm64 crash hotplug patches as Breno suggested.
> > - Remove unused elfcorehdr_updated [4].
> > - Make the patch split more clear.
> > - Link to v5: https://lore.kernel.org/all/20260918100442.3841135-1-ruanjinjie@huawei.com/
> > 
> > [4]: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%40huawei.com
> > 
> > Changs in v5:
> > - Rebased on v7.3-rc3.
> > - Fix several pre-existing code issues reported by Sashiko AI review. [3]
> > - Add an extra slot for memory hot-unplug.
> > - Add device_hotplug_lock_assert_held() helper.
> > - Rework to let the hotplug paths to skip CPU events entirely, which avoid
> >   the TOCTOU race of memory hotplug events and internal CPU offline path
> >   without holding device_hotplug_lock.
> > - Link to v4: https://lore.kernel.org/all/20260907125404.922123-1-ruanjinjie@huawei.com/
> > 
> > Changes in v4:
> > - Rebased on v7.3-rc1.
> > - Update the kexec_core code as Mike suggested.
> > - Update the LoongArch subject as Huacai suggested.
> > - Drop crash_dump_dm_crypt patch which will be fixed by Coiby in [4] as
> >   Sourabh suggested.
> > - Drop x86 related patches because of branch conflict, which will
> >   be done later.
> > - Drop the incorrect CRASH_MAX_MEMORY_RANGES patch.
> > - Handle elfcorehdr_index in arm64 arch code.
> > - Link to v3: https://lore.kernel.org/all/20260826092541.3905933-1-ruanjinjie@huawei.com/
> > 
> > [4] https://lore.kernel.org/all/20260828084900.1496839-2-coiby.xu@gmail.com/
> > 
> > Changes in v3:
> > - Handle "KEXEC_CRASH_HP_REMOVE_MEMORY" action.
> > - Fix several pre-existing code issues reported by Sashiko AI review [3].
> > - Introduce crash_extra_elfcorehdr_size() and elf64_phdr_size() helper.
> > - Rework related crash and arch code.
> > - Add test method.
> > - v2: https://lore.kernel.org/all/20260729031235.2840255-1-ruanjinjie@huawei.com/
> > 
> > Changes in v2:
> > - Split out Powerpc bugfix patch as Mike suggested.
> > - Use phys_to_virt() instead of __va() in update_crash_elfcorehdr().
> > - Convert pnum_hdr_sz() to a function.
> > - Only assign elfcorehdr_index after kexec_add_buffer succeeds, considering
> >   crash_handle_hotplug_event() already performs validity check on
> >   elfcorehdr_index:
> >   - We can safely remove the check for CPU hotplug
> >     in arch_crash_handle_hotplug_event().
> >   - The elfcorehdr_index's segment mem will be valid in
> >     update_crash_elfcorehdr(), so we can safely remove the NULL check.
> > - Simplify the commit message.
> > - v1: https://lore.kernel.org/all/20260723131242.1537633-1-ruanjinjie@huawei.com/#t
> > 
> > Jinjie Ruan (14):
> >   kexec: Fix CMA segment address translation with non-zero text_offset
> >   kexec: Record allocated CMA pages to fix release size mismatch
> >   kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
> >   arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
> >   arm64: kexec_file: Fix elf_headers memory leak in retry loop
> >   LoongArch: kexec_file: Fix CMA page leaks in segment placement retry
> >     loops
> >   LoongArch: kexec_file: Fix elf_headers memory leak in retry loop
> >   LoongArch: kexec_file: Fix a modified_cmdline leak
> >   x86/crash: Fix massive out-of-bounds write on 32-bit Highmem
> >   crash: Extract crash_get_memory_ranges() helper
> >   crash: Factor out crash_find_elfcorehdr() helper
> >   crash: Normalize the kexec_load elfcorehdr at load time
> >   driver core: Add device_hotplug_lock_assert_held() helper
> >   crash: Fix TOCTOU race in crash memory range collection
> > 
> >  arch/arm64/kernel/kexec_image.c            |   1 +
> >  arch/arm64/kernel/machine_kexec_file.c     |   9 +-
> >  arch/loongarch/kernel/kexec_efi.c          |   1 +
> >  arch/loongarch/kernel/machine_kexec.c      |   2 +
> >  arch/loongarch/kernel/machine_kexec_file.c |  10 +-
> >  arch/powerpc/kexec/crash.c                 |   1 +
> >  arch/x86/kernel/crash.c                    |  40 +++++---
> >  drivers/base/core.c                        |   5 +
> >  include/linux/crash_core.h                 |   2 +
> >  include/linux/device.h                     |   1 +
> >  include/linux/kexec.h                      |   4 +-
> >  kernel/crash_core.c                        | 114 +++++++++++++++++----
> >  kernel/kexec.c                             |   4 +
> >  kernel/kexec_core.c                        |  43 +++++---
> >  kernel/kexec_file.c                        |  13 ++-
> >  15 files changed, 192 insertions(+), 58 deletions(-)
> > 
> 
> -- 
> Best regards,
> Jinjie
> 

