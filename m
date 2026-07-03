Return-Path: <linuxppc-dev+bounces-23552-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4199FC44500
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 20:52:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsQtn6ymGz2yqw;
	Sat, 04 Jul 2026 06:52:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783111969;
	cv=none; b=Jo1crp76AuqTMRrCGr8UO3UDB/Ft8MDkhxzWjZ3E3sIEMEUgXGaO2HTbVNbLrV/DpQpquOxg8UA/7T4EYdvOpaUkFErap/taOjlfW3YFSzhaTIWZtyUf5K1/y6VzkOKLxTzcfVP3gvwu7k3J9vhRZcIt3WNJQp30AEYGCObyDq5Q3Wl/S6VtCgvweruhz7OuV/uwrRm6JplLsQI3uWCRz1oG/7Z65fyzn8vGD7YeQT1FKqAwK2Ljq44L0NnJZjyPWSQcjIQhZyP5/AG+EuY9dsY51E3W3FOt8NGcTIjXfaaeAP4GlAGs7SVVBwWr2dKyjxOMmLcw3Eb0NMvjmbCMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783111969; c=relaxed/relaxed;
	bh=qc6RQIMJ3TCgtwMlpFywp2lkPnh2VJAI6hIxptvIyMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z/bK9MlEXKb52SnGLUYwOvhPIRbMHP1czf42HlJYyVVnc2lNLJEayzteY4A0RR0KIBoAwwf7vZyIO8+SPqTzr75V1i8trfFZwjFSynnFahKBHX/X6xYGQ8Suw1iu8yr+u/czpZ35UfBGVD6HTM+RR4Ql4V0d63rgu5UkwfBqCpBx0MSQoueWq86ibRT2+hEIGfmicAxiz0X1PQnLyoqVR2epAnSRsnImUi4YAbTnJni6yzWlmA1C8H63w56nqtuCpAdQW0OYH7lztaTh2H5PjdY+Inab5wks0Nb+j7xoEF2ifb65VAAyj2WTZYt/klyxigkyfwjDg1snTn9oxELnYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m/AEFhD/; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m/AEFhD/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsQtn0vVnz2yqP
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jul 2026 06:52:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3A339600C8;
	Fri,  3 Jul 2026 20:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A6E1F00A3E;
	Fri,  3 Jul 2026 20:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783111965;
	bh=qc6RQIMJ3TCgtwMlpFywp2lkPnh2VJAI6hIxptvIyMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=m/AEFhD/QQMVr60LVSSrHBJhZzSHloaCLPk21mBJcgCOInHXk9skqaY/SzJJ84tEX
	 UmT6M2g7SmZe+Xfl7u66KmHjHFowNBAw9iuDKrQPpkA0d+AKOFoNGiI4ScRdGq9tzV
	 5Bw71e6tMbrrNqTc7h68y+P8wFXYypmrKhsg4IoUL3B2t/kFt2ZfrsDK6qF5Axq7m+
	 0X+YpoR5DWk7RItGPbLuh218SieWYIlmdker7qyk9wbsyvgoZgAjV4Uu3czl1MVLAt
	 DcAB4UvUtBhMMozkhoRv21B/k0znEvzlBngIXWCHw9H0yTbipW6aseVsPvTnj3WZDs
	 DRMEjZMu/EqhQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>, Mark Rutland <mark.rutland@arm.com>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, oleg@redhat.com,
 richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com,
 linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
 kees@kernel.org, guoren@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, geert@linux-m68k.org, tsbogend@alpha.franken.de,
 James.Bottomley@hansenpartnership.com, deller@gmx.de, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com,
 ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de,
 richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, luto@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 chris@zankel.net, jcmvbkbc@gmail.com, peterz@infradead.org,
 wad@chromium.org, thuth@redhat.com, ada.coupriediaz@arm.com,
 linusw@kernel.org, yeoreum.yun@arm.com, song@kernel.org,
 james.morse@arm.com, anshuman.khandual@arm.com, broonie@kernel.org,
 liqiang01@kylinos.cn, pengcan@kylinos.cn, ryan.roberts@arm.com,
 yangtiezhu@loongson.cn, sshegde@linux.ibm.com, mchauras@linux.ibm.com,
 austin.kim@lge.com, jchrist@linux.ibm.com, arnd@arndb.de,
 thomas.weissschuh@linutronix.de, sohil.mehta@intel.com,
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
In-Reply-To: <fa1f5b39-2703-40a1-81d6-3feba87e19b0@arm.com>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-2-ruanjinjie@huawei.com>
 <akdp6GAu77-ipsXA@kunlun.suse.cz> <87cxx4mmim.ffs@fw13>
 <akeIK5TRCjlKbzbp@J2N7QTR9R3> <akeOjqMy7HVgRRCr@kunlun.suse.cz>
 <fa1f5b39-2703-40a1-81d6-3feba87e19b0@arm.com>
Date: Fri, 03 Jul 2026 22:52:43 +0200
Message-ID: <87echjlrs4.ffs@fw13>
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

On Fri, Jul 03 2026 at 13:59, Kevin Brodsky wrote:
> On 03/07/2026 12:27, Michal Such=C3=A1nek wrote:
>>> If we're changing the return type, it might be worth renaming the
>>> function something like:
>>>
>>> 	seccomp_permits_syscall()
>> Then not only it is clear which way the boolean value should be
>> interpreted, it also pervents the accidental inversion of existing
>> calls. Overall great.
>
> Totally agreed, if we have the opportunity to rename a completely
> undescriptive function name like "secure_computing" we should take it.

Absolutely no objections from my side on that.

