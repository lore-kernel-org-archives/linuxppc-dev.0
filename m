Return-Path: <linuxppc-dev+bounces-20703-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D643BCD4840
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 12:32:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDfJK328Mz2xlh;
	Mon, 11 May 2026 22:32:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778502769;
	cv=none; b=RCQHFgDcPmxS5nZSJY+/hL6RrZ/VVVbyQzp5+GosFS1d2MHT6qF6GIsX2OSKkO277Q5+cP2RX6E9XKeNRvLtyoFU8gsxKs1p2pM1yj5OYTDxfqttx9kwGwYPyzr8J3TM3yYOaYrAIDX28jCnzYxmavMqkfVJRJI2BYavRUppqmO4juZVjjhpCU+2AEUi5YW7Nfqk6hO1UrxTU8c3sdyOpvdKYXPGlayPypbmk+QOb6xN+uxX0+EaxXxKX95krz58Jsz1SOB7j74fJjQTkP7RwOkAabk26T4xBfamDSNyOO0v7EunubiOYORLNefRUGM2mD6AUY8WVcM9k2pnjes4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778502769; c=relaxed/relaxed;
	bh=M8lmcQvjJ5LUpDA4EmGDDTnt8GNDhiFnrJNCJhkuZWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmfqbQTzmMCyf3BgxE5I4EPROdfoi4NUoitISlqL7EhUpbW05zqKof1yMgy/PTeO4pKRmq8man0twsFn+z4+oB5FDOUeRJh60dMm4BOmELf32TluQfDlTeh11ALAb9H7y9bxj2niFPrhHOYsusAW4z528ccYe17tHMErNgzZ+5fa9BDcnR4XovYP5hQaRnWfdgplP/wGfgTg4QBiexAQ43w9q6ZDlkx0Dv/WG0HeGMtn898YSok0S0JkcRksrCKBZMxMmOYK6QDcdv9srhJ4zSHe+8bUHA+zdgInFn14YP0ngccvU6s5tVggOibHvZ3ucK5pXayUML/E68WkNsL30A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org; dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=XmiFKakl; dkim-atps=neutral; spf=pass (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org) smtp.mailfrom=debian.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=XmiFKakl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=debian.org (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org)
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDfJJ1Y5mz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 22:32:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M8lmcQvjJ5LUpDA4EmGDDTnt8GNDhiFnrJNCJhkuZWM=; b=XmiFKaklZ3QQYtH8/ygJpRi6/c
	cJ9m6w27ps4ZkaQs+L3zmaULdxP92hxNU3mBsUHkvC5gV/Gr2OWyX7UNQwKGJQMGSIgDGnMR05nSr
	6Hz3vsI22lcNtQs/VMzI48fbeiQc3TW5qrsNxcffxftFa5xlDo5LQ3kJ7Q0m2F5+M5D8c3G+2BDUt
	Wr7OwYwQSZNfs/cIihoRG+30TDa9XqeX3dKysWM/Sidq9OVS27lVgnLamFYvGQfr7bsghipMWPyrI
	mYwBzzTjZXPAId0EF/iDyo+lUuvmMRF8iddzWl4iCApO3hINgAD4OJDf0mLBEMdj/gGrp5p3Xx6ka
	a7gITkwQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wMPmt-001bCJ-0c;
	Mon, 11 May 2026 12:31:07 +0000
Date: Mon, 11 May 2026 05:30:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	ruirui.yang@linux.dev, rdunlap@infradead.org, pmladek@suse.com, 
	dapeng1.mi@linux.intel.com, kees@kernel.org, elver@google.com, kuba@kernel.org, 
	ebiggers@kernel.org, lirongqing@baidu.com, paulmck@kernel.org, 
	sourabhjain@linux.ibm.com, coxu@redhat.com, jbohac@suse.cz, ryan.roberts@arm.com, 
	osandov@fb.com, cfsworks@gmail.com, tangyouling@kylinos.cn, 
	ritesh.list@gmail.com, adityag@linux.ibm.com, guoren@kernel.org, 
	songshuaishuai@tinylab.org, kevin.brodsky@arm.com, vishal.moola@gmail.com, 
	junhui.liu@pigmoral.tech, wangruikang@iscas.ac.cn, namcao@linutronix.de, 
	chao.gao@intel.com, seanjc@google.com, fuqiang.wang@easystack.cn, ardb@kernel.org, 
	chenjiahao16@huawei.com, hbathini@linux.ibm.com, takahiro.akashi@linaro.org, 
	james.morse@arm.com, lizhengyu3@huawei.com, x86@kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	kexec@lists.infradead.org
Subject: Re: [PATCH v13 04/15] arm64: kexec_file: Fix potential buffer
 overflow in prepare_elf_headers()
Message-ID: <agHL1zzC5bzgoCiJ@gmail.com>
References: <20260511030454.1730881-1-ruanjinjie@huawei.com>
 <20260511030454.1730881-5-ruanjinjie@huawei.com>
 <agGkvrg06KNDNfDi@gmail.com>
 <79c14bee-b1f5-4d70-8345-6582d6cf0128@huawei.com>
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
In-Reply-To: <79c14bee-b1f5-4d70-8345-6582d6cf0128@huawei.com>
X-Debian-User: leitao

On Mon, May 11, 2026 at 07:30:44PM +0800, Jinjie Ruan wrote:
> 
> 
> On 5/11/2026 5:46 PM, Breno Leitao wrote:
> > On Mon, May 11, 2026 at 11:04:43AM +0800, Jinjie Ruan wrote:
> >> There is a race condition between the kexec_load() system call
> >> (crash kernel loading path) and memory hotplug operations that can
> >> lead to buffer overflow and potential kernel crash.
> >>
> >> During prepare_elf_headers(), the following steps occur:
> >> 1. The first for_each_mem_range() queries current System RAM memory ranges
> >> 2. Allocates buffer based on queried count
> >> 3. The 2st for_each_mem_range() populates ranges from memblock
> >>
> >> If memory hotplug occurs between step 1 and step 3, the number of ranges
> >> can increase, causing out-of-bounds write when populating cmem->ranges[].
> >>
> >> This happens because kexec_load() uses kexec_trylock (atomic_t) while
> >> memory hotplug uses device_hotplug_lock (mutex), so they don't serialize
> >> with each other.
> >>
> >> Add the explicit bounds checking to prevent out-of-bounds access.
> > 
> > It seems you have a TOCTOU type of issue, and this seems to be shrinking
> > the window, but not fully solving it?
> 
> Hi Breno,
> 
> Thanks for your comments regarding the TOCTOU issue.
> 
> You are correct that the current bounds checking only "shrinks the
> window" and prevents a kernel crash, but doesn't fully guarantee header
> consistency if a race occurs.
> 
> In my local environment, this race is extremely difficult to reproduce,
> but it is theoretically possible.
> 
> To address this properly for arm64, I am considering two steps:
> 
> - For this patch: I will change the return value to -EAGAIN and keep the
> bounds check. This ensures that even if a race happens, the kernel
> remains safe (no OOB access), and user-space is notified to retry.
> 
> - Long-term solution: A better way to solve this is to implement ARM64
> CRASH_HOTPLUG support (similar to x86). With crash hotplug, the kernel
> will automatically re-generate the crash headers whenever a memory
> hotplug event occurs. This makes the TOCTOU during the initial
> kexec_load less critical, as any transient inconsistency will be
> immediately corrected by the subsequent hotplug handler.
> 
> Does it make sense to you to use this patch as a safety guard first, and
> then I (or someone else) follow up with the full CRASH_HOTPLUG support
> for arm64 as [1]?

It would be OK for me, but, make it explict that there is a TOCTOU
issue, that depends on CRASH_HOTPLUG.

