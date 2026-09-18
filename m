Return-Path: <linuxppc-dev+bounces-27712-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364C9C982D9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:16:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmT7C5KQkz2ypW;
	Fri, 18 Sep 2026 20:16:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789726599;
	cv=none; b=YW6cWn+0k3KeCx4KQuHQ13lAqz6NyhxWf2fKQIv+MAQAaqyXdDVAV6MZy7dF+8EndeV4QcDoDoL/YWKlOMacRywuxGryk9OSWIuae887X6eu/W99BPzetRASJVplMYesinfhDQdNeWPW/QA4DXKEMDvpNvr1CYbdSfB0p5YQB4x9ZKzeoaPNRJmCB/RrsAX6XgSesW9bI4SEXCK3h01m6A75qU/yqdCPSBIXnDK4IZBK/ddyXzbuzjwRkCrxNIgeNJhrNp6QTFhFqZ6zabm7Z7xuJGw4WJJ8fv9S8P+3876XV2O2/6+jE6dBOBLNCLU/bOM68G8Vp0Mc/V90+kVPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789726599; c=relaxed/relaxed;
	bh=IUDFRBGa2RG1qXFNOqbXn+eZ7VMhk9nNvTSQAVzvNNw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gj5mWG9/qMIkTysqVF7w+WzK9x1RPtwkbAmACc9UQ1JjrTzfrj9Ocw4jLpL11wjglFHHJk+cGLyWUTl/nh3Zl0+TA+jvON3OnoYhiLn7MkwDms8kPH08/tElWCmZvP3WvdxBRO3TLRmLlVk99+hKYzl1gijlQABIW5k4zSYyBa7+bz1ANsLMbbQHAtYc6MEoG3l9Wmk6ZJbALr5XCC56sYthX71X68ZomZcD8NFYQ1fnjdTl4B4y7xH2qhv9Q0fMjkVj37FrGQxkwMQ6NhroHDhiMlbWONxdDK7INK/SNtkhCPBDBo6oVTY5RoEI9KFDthCaIlEg1zB7WvrPUXe7/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPNSou3I; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cPNSou3I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmT7B56wZz2yhP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:16:38 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9722160A5F;
	Fri, 18 Sep 2026 10:16:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39531F000FF;
	Fri, 18 Sep 2026 10:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726596;
	bh=IUDFRBGa2RG1qXFNOqbXn+eZ7VMhk9nNvTSQAVzvNNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cPNSou3IuShNKs2wqjrBJbH6XQctu6cWqLaMc++I1FCOeysna31efy1k8r1o8USDO
	 2KqcArHiYXdTZ+TCjG/tGsBMKjgm0re02mhBVnEtqMPm6TY1HXd/oDObyk5RBwAemO
	 jATEzxTr7dl4SGEuYHCs0/sMh9/aDZWRxCUGgiAaKdBlebXVmL6UJvtC61NzE0id6H
	 jhaWLG2USeHwgB16NAE4AhrbRZEmLVBnc7w0vh5qLGmVn+sfh2LwhNAQzWtMCKSqyr
	 Mu6jRStNkeupLKN8zuiSxlhEUKsG9ytbHpOCM4iRwDSrdR9sKb4gq/5t73W9G3xoen
	 jXkRNjs+uULHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/17] x86/crash: Fix massive out-of-bounds write on
 32-bit Highmem
Reply-To: sashiko-reviews@lists.linux.dev
To: ruirui.yang@linux.dev, rppt@kernel.org, bp@alien8.de, vishal.l.verma@intel.com, linux-arm-kernel@lists.infradead.org, yeoreum.yun@arm.com, chao.gao@intel.com, kernel@xen0n.name, tglx@kernel.org, takahiro.akashi@linaro.org, ritesh.list@gmail.com, hpa@zytor.com, sshegde@linux.ibm.com, kees@kernel.org, tangyouling@kylinos.cn, will@kernel.org, piliu@redhat.com, me@linux.beauty, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, maqianga@uniontech.com, gregkh@linuxfoundation.org, pasha.tatashin@soleen.com, npiggin@gmail.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, thuth@redhat.com, maddy@linux.ibm.com, blum@kernel.org, chenhuacai@kernel.org, mpe@ellerman.id.au, sourabhjain@linux.ibm.com, zhangtianyang@loongson.cn, robh@kernel.org, graf@amazon.com, seanjc@google.com, hbathini@linux.ibm.com, guodongtai@kylinos.cn, rafael@kernel.org, adityag@linux.ibm.com, kas@kernel.org, gshan@redhat.com, coxu@redhat.com, jbouron@amazon.com, liukexin@kylinos.cn, driver-core@lists.linux.dev, mclapinski@google.com, eric.devolder@oracle.com, linuxppc-dev@lists.ozlabs.org, dakr@kernel.org, dave.hansen@linux.intel.com, mingo@redhat.com, ruanjinjie@huawei.com, akpm@linux-foundation.org, ardb@kernel.org, bgwin@google.com, linux-kernel@vger.kernel.org, james.morse@arm.com, lizhengyu3@huawei.com, baoquan.he@linux.dev, loongarch@lists.linux.dev, x86@kernel.org, palmer@rivosinc.com, pratyush@kernel.org, catalin.marinas@arm.com, leitao@debian.org, mark.rutland@arm.com, chleroy@kernel.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-10-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-10-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:16:33 +0000
Message-Id: <20260918101633.F39531F000FF@smtp.kernel.org>
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

> On 32-bit x86 systems with HIGHMEM, kmap_local_page() only maps a single
> 4KB page. However, the elfcorehdr segment can span several pages (up to
> hundreds of kilobytes).
>=20
> The original code blindly copies 'elfsz' bytes at once via
> memcpy_flushcache(), overwriting adjacent fixmap entries or critical
> virtual addresses.
>=20
> Fix this by copying the new elfcorehdr page by page.
>=20
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Chao Gao <chao.gao@intel.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Eric DeVolder <eric.devolder@oracle.com>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Cc: stable@vger.kernel.org
> Fixes: ea53ad9cf73b ("x86/crash: add x86 crash hotplug support")
> Link: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%4=
0huawei.com
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D9


