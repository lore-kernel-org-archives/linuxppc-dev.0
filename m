Return-Path: <linuxppc-dev+bounces-27710-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EC9C982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:11:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmT163Vybz2yqT;
	Fri, 18 Sep 2026 20:11:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789726282;
	cv=none; b=nvm8jPqEbr3yHU9/KK6OkOOV/PNyvh9i43qwjNQZFrneiLw9eptp0FrzHvkOfTjW3U9q6jgvQaRhdGGGv62bcl2qqcflgq4CGUr+enIX02+3tgXywRGsYForPnw7BcKbwFynoi3ZtLkpssgcLfYUKFlgsVvIAmELP+7Z+X52u2/JVZn1migJSgDqs0a4F7S87g5BAQlvCmQVGGgLMK1wKy0aMI6I0JPnVZ0YCr9aOhuqcpLf2k/Sh7iBhq2YSYzbY86SaQnP7b5ijsWZl8/1w5AjCWamxHVcZjVDSJlP//zAq7pcuLCZGq2q2LfWzgt2IrhuBbPbcT89pw/+Jko5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789726282; c=relaxed/relaxed;
	bh=EbvgUlDhMfv5xqDyq41yarwe4vF9IcejR9w9IshiD48=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lu4zaBHjNc+g58Xu7Q7lqBAcWToad9kJb8YD+s5+iugcS+RkmqdLMkU9xpYqTRTz19Mf5fL0ZgKPur7TQG/wX58XK5mXyL+y4Jm0dyc4GWEIS2rM7ng6TKhiOyEXUH0rpziaWgRoaGZTPTJh0Q78erG5jRLuH92XsAfbor7lPK9afP9uXEBEze0cvAEwvkjsWsiOGrjLrnJ4IBrNEkXzJC82DDgYrKmu49ZF6BjZazvYuJB7uRCkrZX+W/W5LofLJ/G4fPq+EgDUM3+OisN4PxKEOGggzlunLVo4wWUlQI/pzxQBL1obwemg0AStn6qRjsx49jShAujE3V3orYzePA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=llH/FkFI reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=llH/FkFI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmT1456pVz2yHD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:11:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D1BD860A5E;
	Fri, 18 Sep 2026 10:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCD41F000FF;
	Fri, 18 Sep 2026 10:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789726277;
	bh=EbvgUlDhMfv5xqDyq41yarwe4vF9IcejR9w9IshiD48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=llH/FkFITAB5xWYHwFUPLbdE2EaF3GC1eSoCiDjrZavq4ujmqfQALeKu52aFVVMuR
	 pBuHSv80cKI3j9Mho4y3xdPug+GfNG/zgAkh8wZ7OoahnhoGS7E5dhRdqhsQ+I51pr
	 f7NWcn+fOKRoo9iweVcxsXDWvRhgpceUNC6h8Ptlkps8SWZs2CmTh5980BC6sEHNlB
	 0CM2Rk/czy1YuvNhpd/QUpJNpu47BkJRGDZBlBtd4x1ODrJ76w2qvFvIEJ442SLha5
	 zUwFARxcYBBM4yGx2Endjllgko7Mxt/Jea4yXamZO8XPgdLllRtjg2f1JDx3w8mdGp
	 uPU0nMOTpRphQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/17] crash: Extract crash_get_memory_ranges()
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: maddy@linux.ibm.com, tglx@kernel.org, loongarch@lists.linux.dev,
	hbathini@linux.ibm.com, linux-kernel@vger.kernel.org,
	catalin.marinas@arm.com, guodongtai@kylinos.cn, jbouron@amazon.com,
	thuth@redhat.com, mark.rutland@arm.com,
	"Jinjie  Ruan" <ruanjinjie@huawei.com>, gshan@redhat.com,
	sourabhjain@linux.ibm.com, chao.gao@intel.com, piliu@redhat.com,
	eric.devolder@oracle.com, baoquan.he@linux.dev, pratyush@kernel.org,
	ruirui.yang@linux.dev, bgwin@google.com, chenhuacai@kernel.org,
	linux-arm-kernel@lists.infradead.org, maqianga@uniontech.com,
	bp@alien8.de, tangyouling@kylinos.cn, mingo@redhat.com,
	driver-core@lists.linux.dev, blum@kernel.org,
	takahiro.akashi@linaro.org, coxu@redhat.com, linux-mm@kvack.org,
	palmer@rivosinc.com, akpm@linux-foundation.org,
	ruanjinjie@huawei.com, vishal.l.verma@intel.com, npiggin@gmail.com,
	dave.hansen@linux.intel.com, liukexin@kylinos.cn, hpa@zytor.com,
	chleroy@kernel.org, sshegde@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, robh@kernel.org,
	lizhengyu3@huawei.com, leitao@debian.org, yeoreum.yun@arm.com,
	kees@kernel.org, linux-fsdevel@vger.kernel.org,
	mclapinski@google.com, james.morse@arm.com,
	pasha.tatashin@soleen.com, dakr@kernel.org, will@kernel.org,
	zhangtianyang@loongson.cn, me@lin, ux.beauty@lists.ozlabs.org,
	ritesh.list@gmail.com, gregkh@linuxfoundation.org, kernel@xen0n.name,
	seanjc@google.com, x86@kernel.org, rppt@kernel.org,
	rafael@kernel.org, graf@amazon.com, adityag@linux.ibm.com,
	mpe@ellerman.id.au, ardb@kernel.org, kas@kernel.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-11-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-11-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:11:14 +0000
Message-Id: <20260918101115.1FCD41F000FF@smtp.kernel.org>
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

> Factor out the crash memory range collection logic from
> crash_prepare_headers() into a separate function. This allows
> the memory hotplug path to obtain and modify the range list
> (e.g. remove offlined memory) before generating the elfcorehdr.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <baoquan.he@linux.dev>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Dave Young <ruirui.yang@linux.dev>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D10


