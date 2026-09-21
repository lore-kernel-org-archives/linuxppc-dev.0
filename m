Return-Path: <linuxppc-dev+bounces-27845-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCDFC982E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:18:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHhs6K5Pz30Lw;
	Mon, 21 Sep 2026 19:18:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789982317;
	cv=none; b=U0YLkuaYVqA6E/McT9ihmFL08MEr9TyXrLqG2NEIYCGETkJhEfZv//xeXvg6XohAabNvjAvV/XGrjLThAJ+8eUPAE9Y3RxVcRogN0a6AM9P0TmHdtx9N4ywmjbxyDIRI2eEKmyRq5sG6zcW+Ac0XuNYHx3u2LzP58bncud7j/NMyirVPinRU8CfWXQlJ026yYqivZiw8dKdaKEnlLKh+FtBytHlHZYz+OYab7fUYjigSdUvdjBeOLcxCiCthgre6k0sj6Yf3GcMIX7uq6+C+PFOlPk8veX5vu0TTnWmStDKcZaiAqvIX3WxslclfVJIdeZhzwn4RKOGvXNUSJlH18w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789982317; c=relaxed/relaxed;
	bh=tsIzCklxA1OR0ZhVy9j+cyd5RWzkJaDGyF6RmABKvFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RMPTcFca2MqCplTLWPUig2iyEgwl7yMcLs4fycVzZUi9QFkEqIhHJF6645sxQlh3Fz4OVF26hueT31EiLwV2rEzs8uI3iJC1wv0u5ZE0A/SLL/4dGNoFI44wpiOV707JIABf4pkYtBY3JROfXtBOMUUw8ICMaoi+yV+Zqq1U//2KHOBjGDkiPY8ijEhrwvLqLI1UfL6zYctF8lTXn6Ggnit0vxgDdtIa44EKLbx788p/O3cI96rpZyZlVt5WB52blYO4+fy+4xBitycM9KZdyCbNMEnxdj87dPaKpOjAtKOWCIAp1ZdGvWMXJ1Uq2M9/zmvaEiVIceNlwhmPpgBorQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SMHnycOP; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SMHnycOP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHhs1kCpz2yqw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:18:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5D23841384;
	Mon, 21 Sep 2026 09:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871BC1F000FF;
	Mon, 21 Sep 2026 09:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982315;
	bh=tsIzCklxA1OR0ZhVy9j+cyd5RWzkJaDGyF6RmABKvFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SMHnycOPKN9qTyZjIdzxqiQkBqe8TEOAyTaK79u+kYwBW/Wh9tJJF65/tlUGFl4Zf
	 /CqPGAac9B4NZ2mlNpo2Fzu6pZDo2D9yK2HdgqtYrF+HkXbYXVMGPmbxP9R+RhwJwV
	 YZblf79v1O7TYxdtcDmF9HQtIR5mdoqv1EBbRHqzkrJ+LRMsP/aSjLZPWJcdPQyyqH
	 gnzTMi9Nzgn9EW3vJs1OebGdTg8vKLmD+pLEukdRRqYj8nLU1eaknVh6FuPZNOWNPU
	 aAMOJXknMuq+uxAGd3fkvo0bi8Zm+cXxSIHwqVlhF5LsIdoWEUJtStC+zBb4hAAl8t
	 Ai37eNFY5eUnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/14] driver core: Add
 device_hotplug_lock_assert_held() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: bp@alien8.de, kernel@xen0n.name, graf@amazon.com, npiggin@gmail.com, hpa@zytor.com, rafael@kernel.org, hbathini@linux.ibm.com, leitao@debian.org, takahiro.akashi@linaro.org, palmer@rivosinc.com, akpm@linux-foundation.org, me@linux.beauty, sshegde@linux.ibm.com, sourabhjain@linux.ibm.com, kai.huang@intel.com, x86@kernel.org, ritesh.list@gmail.com, pasha.tatashin@soleen.com, coxu@redhat.com, linuxppc-dev@lists.ozlabs.org, baoquan.he@linux.dev, mark.rutland@arm.com, linux-kernel@vger.kernel.org, piliu@redhat.com, zhangtianyang@loongson.cn, will@kernel.org, chleroy@kernel.org, chao.gao@intel.com, loongarch@lists.linux.dev, yeoreum.yun@arm.com, tangyouling@kylinos.cn, pratyush@kernel.org, rppt@kernel.org, mingo@redhat.com, seanjc@google.com, bgwin@google.com, catalin.marinas@arm.com, liukexin@kylinos.cn, driver-core@lists.linux.dev, guodongtai@kylinos.cn, mclapinski@google.com, james.morse@arm.com, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, robh@kernel.org, vishal.l.verma@intel.com, kees@kernel.org, linux-arm-kernel@lists.infradead.org, dave.hansen@linux.intel.com, jbouron@amazon.com, thuth@redhat.com, chenhuacai@kernel.org, tglx@kernel.org, maddy@linux.ibm.com, dakr@kernel.org, ruirui.yang@linux.dev, eric.devolder@oracle.com, maqianga@uniontech.com, gregkh@linuxfoundation.org, mpe@ellerman.id.au
Cc: kexec@lists.infradead.org, ruanjinjie@huawei.com
In-Reply-To: <20260921090450.807575-14-ruanjinjie@huawei.com>
References: <20260921090450.807575-1-ruanjinjie@huawei.com>
 <20260921090450.807575-14-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 09:18:31 +0000
Message-Id: <20260921091831.871BC1F000FF@smtp.kernel.org>
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

> crash_get_memory_ranges() walks memblock, which memory hotplug
> modifies under device_hotplug_lock.  A caller that does not hold
> the lock can race with memblock_double_array() and iterate a freed
> regions array.
>=20
> Add device_hotplug_lock_assert_held() so that crash code can
> use it to catch such unsafe callers via lockdep.
>=20
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921090450.8075=
75-1-ruanjinjie@huawei.com?part=3D13


