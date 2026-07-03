Return-Path: <linuxppc-dev+bounces-23474-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABCBC43602
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 09:48:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs88m0XSsz2xPb;
	Fri, 03 Jul 2026 19:48:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783072135;
	cv=none; b=X+bxmpk3dIAol5TYjBID3op/6wpF3low1J1m9gLUOc8f9dBHn72v8E9Esxor93PLV1B+PNGhb7CeX/xtxPi+yochj2pxJRpR9CPrAbx6Mbnemv0XxBS3kzmxptDvnj3sSjsotljWqyVRYDFtVTVYq+H6evGvjDvO1NGMNuM0Dox8LjJ/3xFWcUK3lnkDf+XXICbaFEG5ECVYhra6k/pGv0aExoe1cGUQH4B4Q1mLWkNTWaAZgEMcySoVPd2O6rwqcMDCRW+6TShdz1oou1sK3z1o8ohr+McJpNQq9goIBvt2/4eyxVjbKV24ClQIWJYkqOxLur905BBhKS70N63CUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783072135; c=relaxed/relaxed;
	bh=GU2sQW+BHbRyl8stT+ES8Av3G6KBfsKpnc1VSiXAaH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l1awZ04EqgyHzx1Coco1S4k+60rR+p0rZ2DQYxsVMvWK8Q0gIGt/jXhCnsvPypmrPYjSxA1v3neOFup6BMag3d5UFWNmO6YvhpDagQdI5/JCsAR9XlKrG2Vt2+pp+EaHKCr11ekIfTeymvICcwQIsScvnDPoswQ3vGle3PdGFPoWbK6iPKBoUTB0s/UG27m2DQjkrj3FVc9Qjg3ZP40ayYIYxhj9cz7r2ry5ADrXwzGkFatpSb1U1w8RjJqR1Cu9v+w7sDBxJDGSr7r79ZJovcZ6yJZVxlbCbPDNdzJkH5W6FBrrCrqb3LStUgua8WzbBZHEOuqEVaNTu/kHs5EsEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTHi5+aa; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTHi5+aa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs88l0129z2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 19:48:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9E36743C4F;
	Fri,  3 Jul 2026 09:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F641F000E9;
	Fri,  3 Jul 2026 09:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783072132;
	bh=GU2sQW+BHbRyl8stT+ES8Av3G6KBfsKpnc1VSiXAaH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=kTHi5+aaAp/rX4HTakkhjR3bFvlbbboB2hx19Nen/OQCynsTw3x/WIdUXu+frxwFV
	 89SbG0+Shaxd2FOCH4dmgKGnOQNd95ufhEkEGXGpT/32v4K6RPBMgJaLR03++i0XQv
	 HLnWwMqbhfMA9VGMcYWioEN6EpIjQeekAAIeSA8n3p4PU3sGcDhY+SXTEkDi6qWsvN
	 N6ri66YT0BOjRUFOiXivtMgrlnMXxRLN30aljrlnw5thKW/fQEv2TszzuBrW0Uq2oE
	 Hw8BoXQe/baC4Oi3LETFSwEwu7qrQBQfRHShyZgwSnxBg2nijHTJWdtguxJWbMqGZ5
	 OSuwx+53eId9w==
From: Thomas Gleixner <tglx@kernel.org>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, Jinjie Ruan
 <ruanjinjie@huawei.com>
Cc: oleg@redhat.com, richard.henderson@linaro.org, mattst88@gmail.com,
 linmag7@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
 will@kernel.org, kees@kernel.org, guoren@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org,
 tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
 deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
 glaubitz@physik.fu-berlin.de, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 luto@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, chris@zankel.net,
 jcmvbkbc@gmail.com, peterz@infradead.org, wad@chromium.org,
 thuth@redhat.com, mark.rutland@arm.com, ada.coupriediaz@arm.com,
 kevin.brodsky@arm.com, linusw@kernel.org, yeoreum.yun@arm.com,
 song@kernel.org, james.morse@arm.com, anshuman.khandual@arm.com,
 broonie@kernel.org, liqiang01@kylinos.cn, pengcan@kylinos.cn,
 ryan.roberts@arm.com, yangtiezhu@loongson.cn, sshegde@linux.ibm.com,
 mchauras@linux.ibm.com, austin.kim@lge.com, jchrist@linux.ibm.com,
 arnd@arndb.de, thomas.weissschuh@linutronix.de, sohil.mehta@intel.com,
 andrew.cooper3@citrix.com, jgross@suse.com, kas@kernel.org,
 x86@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v16 01/18] seccomp: Convert __secure_computing() to
 return boolean
In-Reply-To: <akdp6GAu77-ipsXA@kunlun.suse.cz>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-2-ruanjinjie@huawei.com>
 <akdp6GAu77-ipsXA@kunlun.suse.cz>
Date: Fri, 03 Jul 2026 11:48:49 +0200
Message-ID: <87cxx4mmim.ffs@fw13>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 03 2026 at 09:51, Michal Such=C3=A1nek wrote:
> On Mon, Jun 29, 2026 at 09:05:59PM +0800, Jinjie Ruan wrote:
>> -	if (secure_computing())
>> +	if (!secure_computing())
>>  		return -1;
>
> Hello,
>
> I am not fond of this logic inversion. The boolean is meaningless in
> itself.
>
> Previously -1 was used to indicate that the syscall was filtered but you
> chose to invert the logic choosing true to mean syscall was not filtered.
>
> You could choose true to mean that syscall was fitered avoiding this
> inversion.

That's just wrong. Boolean logic makes more sense with having
(!condition()). Just because the old 0/-1 nonsense had it the other way
round does not mean it has to stay that way.

> Sashiko points out some places in existing code where it supposedly
> explodes which might or might not be true

The vsyscall one is correct, but that's a bug like any other one and should
be caught in review.

The blurb about bypass is AI halluzination nonsense.

> but any in-flight patches that use secure_computing would also be
> affected.

Maintainers know how to deal with collisions of that kind. Stop making
problems up.


