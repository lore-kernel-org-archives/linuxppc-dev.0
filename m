Return-Path: <linuxppc-dev+bounces-27849-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F266CC982E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:25:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHrt4X8Kz2yfs;
	Mon, 21 Sep 2026 19:25:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789982734;
	cv=none; b=FknuiUIaL059vwLP+e8K2d9nKUOU+IeQaU7o2bqeC8XkEOgOLVbTLsug2KzxtlpUkRrsYElLwhINOk1fub5x1j5roJM/WCXWAuQWQkRcqZi7xcSLOYXEMZXPsWKo+PGq16HQxV+xuZOI+l5FWNei0inSnk+56oZt8YjEwqs4OHxKbZ42U31eizoKY+ru5LkoRPkXwHAUwrdYtOdjUAHc/ymYq/PminqPSgyIfSJQoPH2jPXx5hFnpqlmnsOMoeNEZNHX+mas5fFy98GEhENwSHw15sN9/YELKDC0HdRY3c+mmnDsMJvR3KaVfVxc5uXff2J8++9QoPk6/3leQz9lGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789982734; c=relaxed/relaxed;
	bh=h0lbirbiRFTe0nqD7sNgdCQWa98rjE9GNM+G7wxNPPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QVIGJcOpLmu3ZKt+369szMUj8GYe66718LmIjdoeZ6dVqK3yH9ZWD3smQ5nTKfdkT2IcemMmWzF7I3Bhzrc3/hsPqsE4mqXF7Lr7DYzQH5/iPJRdXuSdTWwF4dQkzCsIm4ZKUwGQhjxmTR3HhNwl0DhWt7pFdGGDiPye2weMgzyf2M62xvPa7qALCli5EkCh+kNrVoQtGVI7N1Sxtp3Y/RQfBbZAC952/2Hg+fAxBo5TN0wt4d2TcQDJvjLbOKA/8Bw4QMVeR0IEqwUWNR3eRVUftYwye6jutDlArE+9z1ghkHidBwucVNGpJbIQrekSdt0AS4Q8mdEJSatASHHGaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9GTjN96 reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G9GTjN96;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHrs556lz2yfH
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:25:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1734D4145D;
	Mon, 21 Sep 2026 09:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C231F000FF;
	Mon, 21 Sep 2026 09:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982731;
	bh=h0lbirbiRFTe0nqD7sNgdCQWa98rjE9GNM+G7wxNPPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G9GTjN96ydiq83Dx6AwgaeAwNufeqfgnbprIBt6+exthvcfj6KvKHWSrXRQ1G+fIO
	 CR0L87npQ6Ea0jPOMswGc8AY9HnXr6SzLE6hm3nroxAsiTUCFONF1AjBiWKiNkLCdo
	 HfU9pb7exOZunuj/m975SoxT+oZ9pYI08PLbHjYu/fAt6wyUupuuHzXfSz6mCT/nIk
	 r3IcK0eAwtFOVdNOuyV1xOecJJtozZWu9l2Zr6l995o+kAO6IhF78/0PcvtX2Ru4hP
	 wNiuRs4Yr9agDz8f6d2dNNu6+5doMmiXjWlo0apEAt26WEd6BL0MZpD5VMrlz6qyli
	 Z4DPAU2m60XSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/14] crash: Fix TOCTOU race in crash memory range
 collection
Reply-To: sashiko-reviews@lists.linux.dev
To: kees@kernel.org, piliu@redhat.com, npiggin@gmail.com,
	mpe@ellerman.id.au, me@linux.beauty, bgwin@google.com,
	mingo@redhat.com, x86@kernel.org, baoquan.he@linux.dev,
	guodongtai@kylinos.cn, leitao@debian.org,
	driver-core@lists.linux.dev, coxu@redhat.com, pratyush@kernel.org,
	"Jinjie  Ruan" <ruanjinjie@huawei.com>, will@kernel.org,
	dakr@kernel.org, sourabhjain@linux.ibm.com, maqianga@uniontech.com,
	gregkh@linuxfoundation.org, sshegde@linux.ibm.com,
	liukexin@kylinos.cn, kernel@xen0n.name, thuth@redhat.com,
	hbathini@linux.ibm.com, linux-kernel@vger.kernel.org,
	mclapinski@google.com, tglx@kernel.org, kai.huang@intel.com,
	linuxppc-dev@lists.ozlabs.org, robh@kernel.org, seanjc@google.com,
	james.morse@arm.com, palmer@rivosinc.com, chleroy@kernel.org,
	yeoreum.yun@arm.com, loongarch@lists.linux.dev, jbouron@amazon.com,
	catalin.marinas@arm.com, ritesh.list@gmail.com,
	akpm@linux-foundation.org, rppt@kernel.org, eric.devolder@oracle.com,
	chenhuacai@kernel.org, vishal.l.verma@intel.com,
	dave.hansen@linux.intel.com, chao.gao@intel.com,
	pasha.tatashin@soleen.com, bp@alien8.de, mark.rutland@arm.com,
	takahiro.akashi@linaro.org, zhangtianyang@loongson.cn,
	rafael@kernel.org, tangyouling@kylinos.cn, graf@amazon.com,
	ruirui.yang@linux.dev, hpa@zytor.com, linux-arm-kernel@lists.infra,
	dead.org@lists.ozlabs.org, maddy@linux.ibm.com
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-15-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-15-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:25:27 +0000
Message-Id: <20260921092528.17C231F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D14


