Return-Path: <linuxppc-dev+bounces-27724-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F803C982DC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:31:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmTSC5n8wz2ygK;
	Fri, 18 Sep 2026 20:31:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789727483;
	cv=none; b=e2Bksu4WaAngD+08tzKAYyvQ4AiJm7EOmafcNsRuV+TEiasOjZ/EC3R7xTo57mQa8amYWPNrPyAg9cJb4xVBQRcZG1UvDghA8wMWCZkbtEqpZbTgBeDg6L3qOH+OV3P39G38btMB2RzCsqIALU9BXLtIuEr9e9lYhxd03lZDUxfr0fe8g1EVJRPYAg4Q1whRhTZCccbRAKz7VypfDAzYHceNWpw4mq5Lrehrm2paXNIeccs8QQ32raMoRSNGeZjxHHYETe/FSRc8fVWq8+RHE7dudhF7xg3O13v3VTMD1NhWtitB1wjUreanzApr0hZmxypR8y87sViKYxQhMOQClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789727483; c=relaxed/relaxed;
	bh=WohlUBKAOnI1ycYrmAz9a4uYAu2BUt+wB1nDP7KO/ug=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bD54rZd4ZKiT9DNGMTxgligllXEgC0sR2+docyk+jdzx5lR7qC8akE2m80u2A7sxDsaDtr0SqdSpzT7/w0hqLNY8AupKjdTDQWCkAoj1RgfP1Q3EHMBmnSSqCNWCoj0fRKQYHUaBZcaZPC3FAYMdGo/WEznPRHRznu7NLN/p9hMgqzQ6CvW+yKVdysCRwuxne8pQEX4cEQgQ8w3UKBtJG2qeYaP5fQv/rs4XPMqQ7kZPhr8xZftY1PVinwpS9vrOSaD4rRBNLVU0e4KyMFaVRfboxH3RoI9tPsFiRr77bWrGB0U3xxHiLqY18BK2+tWirYcKEgUOoR7yrmpiQQgGsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4IsE2dE; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a4IsE2dE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmTSB4sLKz2yHD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:31:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C568542B79;
	Fri, 18 Sep 2026 10:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741621F000FF;
	Fri, 18 Sep 2026 10:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727480;
	bh=WohlUBKAOnI1ycYrmAz9a4uYAu2BUt+wB1nDP7KO/ug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a4IsE2dENzW5204Qi8D7Aq+qhe6TkI4pWZ4xDgTIhfw9ed/XtIK5tfxl8+yCcICC4
	 Dymcq8txAd0AjT2q3l8IwlI8B563zHCLB5HMuAOnTzfCQwWuCfkN9buTwRaFNBwk6J
	 wIlawl87RShg2Qmf/1CfzSShnRYNoMz7czRzo6x2/vHe6XlthNlrzUQIGAB8olUV6V
	 q4OjPaCfD4y0E/Hg+Tkq/aCRCfI4ubLfdpHPFhkUF9Z5NsCCbEGKRRutdxEoTkrrCa
	 9xFhLj4ygDBWKboxOoR1+RkSeIIqSN3RTLAchc9X/WWqsc7PKxOpDuDrnt7bmhriSG
	 McaM840XqhQ4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/17] crash: Introduce crash_extra_elfcorehdr_size()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: hpa@zytor.com, robh@kernel.org, leitao@debian.org, linuxppc-dev@lists.ozlabs.org, tglx@kernel.org, rafael@kernel.org, thuth@redhat.com, dakr@kernel.org, driver-core@lists.linux.dev, kas@kernel.org, coxu@redhat.com, linux-fsdevel@vger.kernel.org, ruirui.yang@linux.dev, dave.hansen@linux.intel.com, kees@kernel.org, tangyouling@kylinos.cn, yeoreum.yun@arm.com, linux-mm@kvack.org, rppt@kernel.org, will@kernel.org, eric.devolder@oracle.com, ardb@kernel.org, linux-kernel@vger.kernel.org, chao.gao@intel.com, sshegde@linux.ibm.com, x86@kernel.org, hbathini@linux.ibm.com, liukexin@kylinos.cn, mingo@redhat.com, mclapinski@google.com, bgwin@google.com, james.morse@arm.com, pratyush@kernel.org, pasha.tatashin@soleen.com, loongarch@lists.linux.dev, kernel@xen0n.name, adityag@linux.ibm.com, npiggin@gmail.com, vishal.l.verma@intel.com, akpm@linux-foundation.org, ruanjinjie@huawei.com, lizhengyu3@huawei.com, linux-arm-kernel@lists.infradead.org, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, blum@kernel.org, takahiro.akashi@linaro.org, palmer@rivosinc.com, gshan@redhat.com, maqianga@uniontech.com, mark.rutland@arm.com, baoquan.he@linux.dev, jbouron@amazon.com, zhangtianyang@loongson.cn, ritesh.list@gmail.com, me@linux.beauty, mpe@ellerman.id.au, chleroy@kernel.org, piliu@redhat.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, graf@amazon.com, bp@alien8.de, chenhuacai@kernel.org, sourabhjain@linux.ibm.com, seanjc@google.com, guodongtai@kylinos.cn, maddy@linux.ibm.com
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-16-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-16-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:31:16 +0000
Message-Id: <20260918103117.741621F000FF@smtp.kernel.org>
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

> Extract the elfcorehdr extra space calculation from powerpc into a
> generic helper crash_extra_elfcorehdr_size() for use by other
> architectures like arm64.
>=20
> Strengthen the original powerpc check: instead of only checking
> the loose CONFIG_CRASH_MAX_MEMORY_RANGES, the new helper enforces
> a strict compile-time BUILD_BUG_ON() to guarantee that the absolute
> maximum theoretical number of ELF Program Headers will never exceed
> the ELF physical limit of PN_XNUM. This ensures absolute safety across
> all architectures with zero runtime overhead.
>=20
> The helper also provides a zero-size stub when crash memory hotplug
> is disabled.
>=20
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Dave Young <ruirui.yang@linux.dev>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D15


