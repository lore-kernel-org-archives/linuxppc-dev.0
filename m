Return-Path: <linuxppc-dev+bounces-27717-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681B1C982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:19:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmT9w55KRz30Tp;
	Fri, 18 Sep 2026 20:19:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789726740;
	cv=none; b=EzIkr8NjYIsFxvjwlyQyc6GGfUKz/R5B5hovmp02DdXZZOMR7JCI9VNhxrZc9DyBaviQjzg6EU/zrbKqWTeS9VPL0UrvH3tuNxgODHPk8mQCyaxokweqnSavh9JUmE230EsyrfH+rUEGYvB5sHVle4MSneohjEv81ewW4lkZk1zEEYZGYtyrDkw9InS1NeRPRDNYw30ce2amfWLlq9FymUAcA8wlYOy4VXgQikGYwwwWpcA7PLZsyEgtYARGNc+cXYdBwJVMo1b6TKq7yQVU8WDaIrL369S+PbMM2YyuB1uAgpWvdhW1WjJ+wa6Jo1URlP7ZYAOT0u8wNChfVfvgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789726740; c=relaxed/relaxed;
	bh=NK4q4bMTc4NtuqUZq2p2ouZ93CvhS6B9qDA0XHB+AQs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nUIN3ZW0xbuqRm4MIYqLWmcRkxcSTMPjnxMOhUKdk+KCe3GtLek/TqHN2O87eYb9NdN9SWnBWiw+UC1lHOvuUDlGblp56xoLylfk12fSFw2R5V8Ym0Rk3SNpTr6iUgUo+rDaJ8lKPk1QwDSg/4ZHyoqSkZv3t83feyGEmgGoEEbG19DUPZG4rE6hF5xXf/kUWFIAPcfeEPNiVl1VS+8tqX+/QvgH7RuX2Kcry0UTwjsB/t6vAdMmDlv0yCnFzTAsO5djw3m6+L+J/rupyUUVYVGBCnaJS9WxoBmKTO4cfMi7AlNYOPCoNqWuSKIKZMMhZOpnvCb+47tvEMsA3xcciw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nih+Cgdh; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nih+Cgdh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmT9w0Nmvz2ypW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:19:00 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 196A860A64;
	Fri, 18 Sep 2026 10:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A10E1F00898;
	Fri, 18 Sep 2026 10:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726737;
	bh=NK4q4bMTc4NtuqUZq2p2ouZ93CvhS6B9qDA0XHB+AQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nih+CgdhGnLO8TOeDlPBdKPirdBoHe0i3bMXikC3kG5yEMeDAdT/7gzT4yWuBpvZx
	 W7cUWDlxizNzUCQLwfXs94uynL6mjAM7ePcKxhgXkPT+1qBU4XiAVkZUxCID7DY2Jb
	 +goXUKIBVWZDUgSR4iPriXVvwYXN8d8X9H82/VSmmMSLI/OoaAUWelD4FsQaZZammh
	 eYyGUgPR2fj74PNv1XQ3/oKvNKleNUqhIx12OPwpZiHqNhqR9DXO1fQvv8HQ/XlO0M
	 vmZ3I07NIFGVT6o1Dcu0cuUd02YdMq7cV0HFTHOA46CJjQwBsUjh8NbSWls+LhVb5U
	 tjgTt00+qSZbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/17] LoongArch: kexec_file: Fix a modified_cmdline
 leak
Reply-To: sashiko-reviews@lists.linux.dev
To: rafael@kernel.org, mingo@redhat.com, leitao@debian.org, graf@amazon.com, ritesh.list@gmail.com, coxu@redhat.com, sshegde@linux.ibm.com, catalin.marinas@arm.com, bp@alien8.de, blum@kernel.org, chao.gao@intel.com, linuxppc-dev@lists.ozlabs.org, chenhuacai@kernel.org, jbouron@amazon.com, eric.devolder@oracle.com, palmer@rivosinc.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, hbathini@linux.ibm.com, rppt@kernel.org, james.morse@arm.com, will@kernel.org, maddy@linux.ibm.com, chleroy@kernel.org, dave.hansen@linux.intel.com, sourabhjain@linux.ibm.com, mpe@ellerman.id.au, baoquan.he@linux.dev, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, gshan@redhat.com, gregkh@linuxfoundation.org, lizhengyu3@huawei.com, adityag@linux.ibm.com, tglx@kernel.org, guodongtai@kylinos.cn, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, me@linux.beauty, hpa@zytor.com, x86@kernel.org, piliu@redhat.com, ardb@kernel.org, takahiro.akashi@linaro.org, npiggin@gmail.com, maqianga@uniontech.com, mclapinski@google.com, yeoreum.yun@arm.com, kernel@xen0n.name, vishal.l.verma@intel.com, bgwin@google.com, driver-core@lists.linux.dev, seanjc@google.com, kas@kernel.org, tangyouling@kylinos.cn, pasha.tatashin@soleen.com, zhangtianyang@loongson.cn, ruanjinjie@huawei.com, ruirui.yang@linux.dev, kees@kernel.org, thuth@redhat.com, linux-arm-kernel@lists.infradead.org, liukexin@kylinos.cn, dakr@kernel.org, pratyush@kernel.org, robh@kernel.org, mark.rutland@arm.com, loongarch@lists.linux.dev
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-9-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-9-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:18:54 +0000
Message-Id: <20260918101854.7A10E1F00898@smtp.kernel.org>
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

> load_other_segments() allocates modified_cmdline and stores it in
> image->arch.cmdline_ptr.  machine_kexec_prepare() then copies it to
> KEXEC_CMDLINE_ADDR and overwrites the pointer, so the heap buffer is
> leaked on every successful kexec_file_load().
>=20
> Free the buffer after the copy.
>=20
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: WANG Xuerui <kernel@xen0n.name>
> Cc: Kexin Liu <liukexin@kylinos.cn>
> Cc: Youling Tang <tangyouling@kylinos.cn>
> Cc: Qiang Ma <maqianga@uniontech.com>
> Cc: Tianyang Zhang <zhangtianyang@loongson.cn>
> Cc: George Guo <guodongtai@kylinos.cn>
> Cc: stable@vger.kernel.org
> Fixes: d162feec6b6e ("LoongArch: Add preparatory infrastructure for kexec=
_file")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D8


