Return-Path: <linuxppc-dev+bounces-27721-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52748C982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 10:26:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmTLx630Gz2ygK;
	Fri, 18 Sep 2026 20:26:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789727209;
	cv=none; b=g2mZP9XmiCjK2Sjv0X013BR78MO6PqT0WB4gdOAFd5xkwRT1W+46FKPfNzOw5otLZO1j94aT+g+8cJza4nhoybsQLlXeMtS72nDPmSkyLKmkEs/MC47OBpM6n//7zhLhLEm3AHDvtKjxahl0iWhezsnLX/ridnB8DUclGDCpwe/WLWsdDNQvmwfMWxkviB1xEBRBQEla30Y//5friCDRonrRuxyp3GsVd/4Yn068lT7zgDksuX74YAh97/cLUBHTnM8Ur8Bv0b9IEbNJMwTyEcZYOTJXqPjzPB8IX4jEEZ3AK23jEufs4S1JpI/XzPqWD2rGEGibT8tfLs11OvTCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789727209; c=relaxed/relaxed;
	bh=5+RK1cJzE7vYEJNH4KMTogSsel/5JlapcOCdBl4VlP4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FBRyZkN12TZStvLAlWMxRGUqaSiuToU4dej4vGKwivfd9xz4WTcOsGjy0rO4UTktO35fH1497vUlpUT14ui4ohyqCFO3hDLvT0i+HpDkxxcikYzV/hg5gPguvITzlx/rh6HrMJr3hlrjkvbO7Nobt2TntojQb/iRsnmHiX3nUWHC7NZuV0IFr4rxEJt1Txk5rwm8WADY/ng1gafiESPiHLYM4Uw6ViF+evDN1vsOKLk80WrznMXIrx4Z4Y7OrGqwxjN4ePnjBnMQFY2XUt6Vy9jvEqmSUhYeb8SjYccAPE3Kx9DQqVJPPN6ZHKmHMXraWfOdPkWatxsbEg97dn+rAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=fail (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eupBYsTA reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eupBYsTA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmTLx1mwVz2yHD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 20:26:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 95B0B439F7;
	Fri, 18 Sep 2026 10:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5197B1F000FF;
	Fri, 18 Sep 2026 10:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727207;
	bh=5+RK1cJzE7vYEJNH4KMTogSsel/5JlapcOCdBl4VlP4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eupBYsTA6h+6JQa2ShdpohTKsfpx+UdpDggKnPH+KXXFxsygHGJ3gVN7254T/GPMe
	 CCJuO2D+n0H9tMNb5k6YwM/32ifMNPqfHtQSFOCBaZj6dRWQ1vzKk3XpZyXdNfGkx7
	 B0Js2Z4P3IKPLnB+2SOz682eQuD+4qtrx8oYjMSHCPVu5RKdrncN8SQoPWtTZHGmte
	 Q4tbyvx8n9a4FX/eeC0AihF8aWsPxSvZDHDagwVODDYyAxhyaTW+yVRyV2j2QDDIoa
	 SpZ4/7ywTZa0GyrUoyi/T60ERtnAj0Y2RgtK2FOpO+4su/jwnsmyzw4AjMeXvnu3vY
	 TSIYXJPdwk56A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/17] crash: Assert device_hotplug_lock in
 crash_get_memory_ranges_nolock()
Reply-To: sashiko-reviews@lists.linux.dev
To: akpm@linux-foundation.org, me@linux.beauty, takahiro.akashi@linaro.org, linuxppc-dev@lists.ozlabs.org, driver-core@lists.linux.dev, maddy@linux.ibm.com, hpa@zytor.com, yeoreum.yun@arm.com, lizhengyu3@huawei.com, loongarch@lists.linux.dev, mark.rutland@arm.com, blum@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, kas@kernel.org, pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org, chenhuacai@kernel.org, palmer@rivosinc.com, robh@kernel.org, ardb@kernel.org, linux-arm-kernel@lists.infradead.org, seanjc@google.com, tglx@kernel.org, thuth@redhat.com, tangyouling@kylinos.cn, adityag@linux.ibm.com, x86@kernel.org, pratyush@kernel.org, kernel@xen0n.name, liukexin@kylinos.cn, bgwin@google.com, ritesh.list@gmail.com, will@kernel.org, dakr@kernel.org, chao.gao@intel.com, sshegde@linux.ibm.com, ruirui.yang@linux.dev, zhangtianyang@loongson.cn, hbathini@linux.ibm.com, jbouron@amazon.com, sourabhjain@linux.ibm.com, kees@kernel.org, gshan@redhat.com, mclapinski@google.com, rppt@
 kernel.org, guodongtai@kylinos.cn, coxu@redhat.com, piliu@redhat.com, ruanjinjie@huawei.com, maqianga@uniontech.com, mingo@redhat.com, linux-mm@kvack.org, mpe@ellerman.id.au, chleroy@kernel.org, graf@amazon.com, linux-fsdevel@vger.kernel.org, bp@alien8.de, eric.devolder@oracle.com, vishal.l.verma@intel.com, james.morse@arm.com, catalin.marinas@arm.com, npiggin@gmail.com, baoquan.he@linux.dev, "Jinjie
 Ruan" <ruanjinjie@huawei.com>, dave.hansen@linux.intel.com, leitao@debian.org
Cc: kexec@lists.infradead.org
In-Reply-To: <20260918100442.3841135-14-ruanjinjie@huawei.com>
References: <20260918100442.3841135-1-ruanjinjie@huawei.com>
 <20260918100442.3841135-14-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 10:26:43 +0000
Message-Id: <20260918102644.5197B1F000FF@smtp.kernel.org>
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

> crash_get_memory_ranges_nolock() walks memblock, which memory hotplug
> modifies under device_hotplug_lock.  A caller that does not hold the lock
> can race with memblock_double_array() and iterate a freed regions array.
>=20
> Add device_hotplug_lock_assert_held() and call it at the top of the
> function so that such callers are caught by lockdep.
>=20
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918100442.3841=
135-1-ruanjinjie@huawei.com?part=3D13


