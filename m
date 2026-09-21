Return-Path: <linuxppc-dev+bounces-27843-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A67C982E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:17:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHgs3fXDz2yVd;
	Mon, 21 Sep 2026 19:17:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789982265;
	cv=none; b=kPEBQACYnzNYwo36dOlSI5so8y7rZ1wkf1asR8snkHDt4fa9JykqYTtarRF2jsnwMWOHuHzJ2fXG7qMuOJBa7D5lIbgdOcM0pF6N4CJg0EdzD4/vnwG4AzSthcZgs/VplSDhmUnnbIj64NY5KNvrvcSJfXJsgj4oGe8ZGjrTRti2bZjzfy+qkH8ujqRkCZs9SwYE3xakA58Zq0q52nvCBc422WIgjoLQ2Mm7e87NwSU6hT0rNngIRIpUiB4CP/LNSprpo3QHYJ3EfSDdSUqjO2MnnqrxHTnKst+ZsS4Wl02yeh99fdqesfaXM+Mpz3H9kfDcPPz/f8FJ0OlDoIqM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789982265; c=relaxed/relaxed;
	bh=zf/aQsXCzB2e/77wVQGKOahnDXi6wvJ7QdslTWDQRvM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CZLO4eVaHk3OyAuHMcg1g2My9dNlidsjzfReQG+EHiVZdApG7rC0225tix/l8xDljEEvBM4Kn/8LCxaNbIONXu2j2fKUIjnkxPD1tiRC37UUYptwmJziIDLLgwtdbjPAaD6tz66YDXurED2eX8uHWTSwQhp7HhVFFXNvSALRwppXwQmZdAn2bOk1FKTMEBz9Im+NmJgL3WIWvTmPZ9qatgRwowsZQQ0CT32NGfWJOqzTPEmfQkXVsVXzLpYE+hnFhTiO1tj/n36P/alaSxzL+4Sz8bzMl1U+yJ6patR3njo49fcg3S3LTkNETZ23Ca6KYpNj7Hhmu3GMuM21XNLl1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFlwMSx4; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFlwMSx4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHgr3yFbz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:17:44 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 863E041E49;
	Mon, 21 Sep 2026 09:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910851F000FF;
	Mon, 21 Sep 2026 09:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982262;
	bh=zf/aQsXCzB2e/77wVQGKOahnDXi6wvJ7QdslTWDQRvM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fFlwMSx4XeKM/6ODRT6JIAmtyQ4iEB13D+VkG7AENmXdbJad/d+MVzmnISIIvek0M
	 f+CHwALM7JHKTxEDD43GtZjOUgeokyAc9m/HG5veIoAOJnardr+uvolW59fEQBZ7OU
	 I+vkPy+6giY6egbg8LMvh/SdU7D+6/ePY6zyRKrlMCbvKsfKsmvv2GxY3etcV07GF6
	 /VjWuDWk6CJbQVZ8ECqpM7BX3LYQ+rc3uhPtMWw5iTdlZLsTFvMC8UBtOzw7FW3trh
	 Pm8gM7D9e5FWg2yIhbkwsqxRdTXs4ftgrC4VptFd7h8AmD6MVY6etE1HFkZZJnfZKd
	 R60b4F6ylFMOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/14] crash: Factor out crash_find_elfcorehdr()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: dave.hansen@linux.intel.com, chao.gao@intel.com, driver-core@lists.linux.dev, tglx@kernel.org, leitao@debian.org, chenhuacai@kernel.org, piliu@redhat.com, seanjc@google.com, chleroy@kernel.org, gregkh@linuxfoundation.org, kees@kernel.org, zhangtianyang@loongson.cn, mclapinski@google.com, will@kernel.org, kai.huang@intel.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, eric.devolder@oracle.com, akpm@linux-foundation.org, pratyush@kernel.org, loongarch@lists.linux.dev, x86@kernel.org, mpe@ellerman.id.au, robh@kernel.org, rafael@kernel.org, pasha.tatashin@soleen.com, ruirui.yang@linux.dev, jbouron@amazon.com, tangyouling@kylinos.cn, vishal.l.verma@intel.com, npiggin@gmail.com, yeoreum.yun@arm.com, mark.rutland@arm.com, takahiro.akashi@linaro.org, mingo@redhat.com, liukexin@kylinos.cn, kernel@xen0n.name, maqianga@uniontech.com, sourabhjain@linux.ibm.com, linux-kernel@vger.kernel.org, sshegde@linux.ibm.com, james.morse@arm.com, linuxppc-dev@lists.ozlabs.org, hpa@zytor.com, hbathini@linux.ibm.com, linux-arm-kernel@lists.infradead.org, thuth@redhat.com, graf@amazon.com, dakr@kernel.org, bgwin@google.com, me@linux.beauty, guodongtai@kylinos.cn, palmer@rivosinc.com, bp@alien8.de, catalin.marinas@arm.com, coxu@redhat.com, rppt@kernel.org, maddy@linux.ibm.com, baoquan.he@linux.dev, ritesh.list@gmail.com
Cc: ruanjinjie@huawei.com, kexec@lists.infradead.org
In-Reply-To: <20260921090450.807575-12-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-12-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:17:39 +0000
Message-Id: <20260921091739.910851F000FF@smtp.kernel.org>
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

> The elfcorehdr segment is located by scanning the segments for
> the ELF magic. Factor that scan out into a new helper function,
> crash_find_elfcorehdr(), to clean up crash_handle_hotplug_event()
> and prepare for its reuse in crash hotplug code.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Dave Young <ruirui.yang@linux.dev>
> Cc: Breno Leitao <leitao@debian.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D11


