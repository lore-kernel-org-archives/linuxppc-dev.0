Return-Path: <linuxppc-dev+bounces-27848-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A39C982E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:19:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHkN58gsz30WS;
	Mon, 21 Sep 2026 19:19:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789982396;
	cv=none; b=O4/MjmfQyrdChFqZBn3X9fgRCJtt9iDc1Ots3FiRN0/+ub0PATKnx+BS6Xo7vDSx8rT1G5iVWAfTy8kTdaDrHp8tJVlTY2Qrna4HbMa9sAlhUzpZgT0hj4Nn+ZCNmhUqeRhjphwwcoY4OlMk12BEEJBAUTSz8qla4H8CKwAW0UR4rJEojELrs3iG4Umkjg+K0uhJpX3TYfjN2VfUT2q/n5derGE+R+r3GW2JAnZ1jLqa8LMJKfm1nyqkkgpWRsajF7ML/hx4tAquSAbbhoWoppmd0XxoKOY82/tEEXV/FdoN0GEAWM9/RnfE2tzhlJCnYt5Erc+DVRFVHrei+fogzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789982396; c=relaxed/relaxed;
	bh=lYPW2EitrWksOeNywbT4ACddfE8LBXRuHuJ++AYnkVg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d2VSD2ddfJ99/eM8Rae8Chh2/EcbZcFgq3Q1+PT9PIhTMiA9GRBcWWYeM2UiDKruvqKh2tQU/7KLcnoCsKeoffronNQB6N6DvfHDQKYuZ0jMFTw7iurD6WOpl8bZqndcVzJ6jylOuPyDxLQDYV3YGUKEaXDc4vvu9SBO8dWYkQ4/+D/+odOHnMfLrN1yjUrfRTsmb1fdtqiOdbWbB6BTARRBLq9jA4u8LUiXMGlArXFE06oarvMCRNO5bb1vsU4GeagBIasuDjV2XwXIRAXx0aHKjsJoqiJcgs0Veo5SHQ61MnvE7rpxhcPKMDRztlhGnn+aKgyWaMJ+t62QdRWRdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgcUGeAD; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HgcUGeAD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHkN0ZnQz30WQ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:19:56 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2BCF8600C8;
	Mon, 21 Sep 2026 09:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE231F000FF;
	Mon, 21 Sep 2026 09:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982393;
	bh=lYPW2EitrWksOeNywbT4ACddfE8LBXRuHuJ++AYnkVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HgcUGeADs7/M03n4e2fM1RNJ+WDOaeSKU+QjIz/LtyFBUbeVb4L6/srXNM6s+yLNv
	 lemuTopLmR2RY1n46up1y6lfw2TMG+aXggHsOLTYpKvTSW+vgKxMx6SkvQeFQps3ws
	 LZmwqCnE+K8/UsHYTHgJgNTPjKAMTLM+s8evUKg2waXxzx3eq6dsntJvuKU8eTySRy
	 n36264uQDAJ9ioRxlPfRKtNGms4PwRu3OHjhXWjPEXx3gi/RjiBAl7Ew39lMayDC/6
	 xPzGfGJQuRTpNBCK4aGXsXkjg0/RZfLekSNvS3HBjltpptS1F1D56r968uAhWjn0Vv
	 hAK7VnVuwYw0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/14] crash: Normalize the kexec_load elfcorehdr at
 load time
Reply-To: sashiko-reviews@lists.linux.dev
To: zhangtianyang@loongson.cn, chleroy@kernel.org, eric.devolder@oracle.com, linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, dakr@kernel.org, guodongtai@kylinos.cn, hpa@zytor.com, kernel@xen0n.name, chao.gao@intel.com, pasha.tatashin@soleen.com, npiggin@gmail.com, coxu@redhat.com, liukexin@kylinos.cn, seanjc@google.com, bgwin@google.com, rppt@kernel.org, bp@alien8.de, kai.huang@intel.com, sshegde@linux.ibm.com, kees@kernel.org, mpe@ellerman.id.au, tglx@kernel.org, jbouron@amazon.com, yeoreum.yun@arm.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, maddy@linux.ibm.com, gregkh@linuxfoundation.org, will@kernel.org, pratyush@kernel.org, akpm@linux-foundation.org, robh@kernel.org, tangyouling@kylinos.cn, piliu@redhat.com, hbathini@linux.ibm.com, mark.rutland@arm.com, chenhuacai@kernel.org, me@linux.beauty, mclapinski@google.com, dave.hansen@linux.intel.com, ritesh.list@gmail.com, x86@kernel.org, linux-arm-kernel@lists.infradead.org, leitao@debian.org, palmer@rivosinc.com, maqianga@uniontech.com, james.morse@arm.com, takahiro.akashi@linaro.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, vishal.l.verma@intel.com, catalin.marinas@arm.com, graf@amazon.com, sourabhjain@linux.ibm.com, mingo@redhat.com, ruirui.yang@linux.dev, rafael@kernel.org, baoquan.he@linux.dev, thuth@redhat.com
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-13-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-13-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:19:51 +0000
Message-Id: <20260921091951.BDE231F000FF@smtp.kernel.org>
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

> For kexec_load() the kernel does not build the elfcorehdr, so it is only
> rewritten by the first crash hotplug event.  CPU hotplug events do not
> change the elfcorehdr, but they may run without device_hotplug_lock
> (e.g. CPU offlining during suspend), so they cannot perform that rewrite
> without racing with memory hotplug.
>=20
> Normalize the elfcorehdr once when the crash image is installed via
> crash_hotplug_prepare_elfcorehdr(), while device_hotplug_lock can still
> be taken safely, and let the hotplug paths skip CPU events entirely.
> Architectures that do not need the rewrite  (e.g. powerpc) treat
> KEXEC_CRASH_HP_NONE as a no-op.
>=20
> The x86 crash hotplug handler now skips CPU hotplug events
> unconditionally, so nothing reads image->elfcorehdr_updated anymore.
> Drop the field and the code that maintains it.
> [ ... ]
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Dave Young <ruirui.yang@linux.dev>
> Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D12


