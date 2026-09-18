Return-Path: <linuxppc-dev+bounces-27725-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01804C982DC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:34:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmTWY2Qgnz2yhP;
	Fri, 18 Sep 2026 20:34:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789727657;
	cv=none; b=UVcgG3y8TnLlQ0lF2JUkd+Krzs3kcUvBdWwsoKuTeiH58TLX8cDBDC3i524AfNl72ClSroN7BvL3XflRfgrwDgzbj4MDc7PuFo2MNJwfLQJvIy8MgaSpP6DIE9Q/xFf9xPXjqj+30KoodYgRXOgaalB9PueczERERQuIHgsZPoxN6MM+hPaftJ6AneuwehwMTrzuWu/80pQWiCtlT++fH6UNfSYqBLTtQmw0LrMpdVfQ666DPbylK4omty686426K68EskS6rkwcpsRroIAuom64X5KbV6XFsb0sS6OvvL7yNT3zYE0/gFvxSiB1HEACxh+58ThEyQ4BFgJwqQJEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789727657; c=relaxed/relaxed;
	bh=71jFtym32R/pNn5C3yPgZDDzaq5qZS8JIIHmgqqBkfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hDR/Ydd9+OsbXq7HHNTknMl/fLiRtjUtCJSuV/NP7+SmO0jKw4Cnme23HAFCh6F+YdBzo7Z5QGSecX5yeYHd6xGfSDQPrJMD6LOX9PueYOr4xP0NPwNfJEfvUHHksCRXAZxz6CcyR4nN3Zkwy65tqdUGakSm5SqqdYb/YAQ569/DxZbYdSBlo66BfBZDjqGky0YeDUlwJ4F2NfwAzUjgZzDmWADPO8eH9Vdz6+yrKyjgt1MxRw5E6QzalTzV8+UqxnyInY/vF8kZmKXzAfCjNBaMm9Nyxos3ssU0H7v/3TPGdTpHElMx28ioXkOdZTMGscFjGe2Aw4Fm25nVAhwOpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQiwVwcr; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQiwVwcr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmTWX1vShz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:34:16 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A1DB840524;
	Fri, 18 Sep 2026 10:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8601F000FF;
	Fri, 18 Sep 2026 10:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727654;
	bh=71jFtym32R/pNn5C3yPgZDDzaq5qZS8JIIHmgqqBkfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UQiwVwcrQYLLOMOj+NzO2JrLYChumnio/fc/mR5O1sf+FXz56jqfp8xu3Zrn/AQ+s
	 UPQyFX9daLLzA6NyhjGsoN+Am67E0Plu3Mfyd5MMPIetvbNA9eZOvvUVUwHG4KkIpd
	 Hm/jAvYbKzwaavhWLnLyf8e6cQcV9SfiClrlMIomraUmmkXu7tWNmkMAxTVqQ1kGvu
	 3PA8y2MCJUX2uWkWgRxGYr4d1uKTFqRc5E5X8XQb4BwZPPMAW4GtRKnetdW/5jxo5v
	 HIf7SrFWALwipQXYaKiwGiTgnED/7M//LvvFLI5CfiI/ADJfkSN8KaNbw2mngKa4Vn
	 EsC+2NfERzkuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/17] crash: Fix TOCTOU race in crash memory range
 collection
Reply-To: sashiko-reviews@lists.linux.dev
To: vishal.l.verma@intel.com, linux-fsdevel@vger.kernel.org, jbouron@amazon.com, linux-mm@kvack.org, sshegde@linux.ibm.com, bp@alien8.de, maqianga@uniontech.com, mpe@ellerman.id.au, kas@kernel.org, gregkh@linuxfoundation.org, chao.gao@intel.com, mingo@redhat.com, kernel@xen0n.name, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, chenhuacai@kernel.org, seanjc@google.com, ritesh.list@gmail.com, pratyush@kernel.org, tglx@kernel.org, pasha.tatashin@soleen.com, yeoreum.yun@arm.com, gshan@redhat.com, chleroy@kernel.org, liukexin@kylinos.cn, thuth@redhat.com, eric.devolder@oracle.com, linux-kernel@vger.kernel.org, kees@kernel.org, dakr@kernel.org, mark.rutland@arm.com, x86@kernel.org, leitao@debian.org, blum@kernel.org, catalin.marinas@arm.com, zhangtianyang@loongson.cn, me@linux.beauty, mclapinski@google.com, palmer@rivosinc.com, loongarch@lists.linux.dev, ruanjinjie@huawei.com, rafael@kernel.org, will@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com, rppt@kernel.org, hpa@zytor.com, james.morse@arm.com, tangyouling@kylinos.cn, linuxppc-dev@lists.ozlabs.org, takahiro.akashi@linaro.org, baoquan.he@linux.dev, lizhengyu3@huawei.com, maddy@linux.ibm.com, coxu@redhat.com, linux-arm-kernel@lists.infradead.org, guodongtai@kylinos.cn, hbathini@linux.ibm.com, ruirui.yang@linux.dev, 
 adityag@linux.ibm.com, graf@amazon.com, akpm@linux-foundation.org, sourabhjain@linux.ibm.com, driver-core@lists.linux.dev, piliu@redhat.com, ardb@kernel.org, robh@kernel.org, bgwin@google.com
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-13-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-13-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:34:10 +0000
Message-Id: <20260918103411.5E8601F000FF@smtp.kernel.org>
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

> The crash kernel ELF core header construction counts system memory
> ranges via `arch_get_system_nr_ranges()`, allocates the crash_mem
> buffer, and then populates it via `arch_crash_populate_cmem()`.
> This sequence has a time-of-check-to-time-of-use (TOCTOU) race with
> memory hotplug: a concurrent hotplug event between the count
> and populate steps can increase the number of ranges beyond the allocated
> capacity, causing an out-of-bounds write. If the event triggers
> memblock_double_array(), the memblock array can be freed and reallocated
> during iteration, leading to a use-after-free.
>=20
> Protect the entire range collection with device_hotplug_lock. Since
> the hotplug notification path already holds that lock, add a lockless
> helper, crash_get_memory_ranges_nolock(), for use there. The regular
> crash_get_memory_ranges() acquires the lock and calls the helper.
>=20
> [ ... ]
> Fixes: 3751e728cef2 ("arm64: kexec_file: add crash dump support")
> Fixes: 8acea455fafa ("RISC-V: Support for kexec_file on panic")
> Fixes: 1bcca8620a91 ("LoongArch: Add crash dump support for kexec_file")
> Link: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%=
40huawei.com
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D12


