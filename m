Return-Path: <linuxppc-dev+bounces-23502-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732ECC43602
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 12:00:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsC4N6nmWz2yZ6;
	Fri, 03 Jul 2026 22:00:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783080020;
	cv=none; b=kOjwCZb3VMM17uCFX7QIZQTVvbZM4HLV5QIi0A4aV1j/1B2U7/fPUWvRdDiZX4Baa2V2fn48j3ai1P/o48PbymnwgCVnno3amH60AUJSLKd+bcfIlf34KzsYAuRc5XlK2Te84ojTNpC0AV0w+j6xLN3XPwZXyyy56LEFfxXXrCDs56SDDFMp4Hy90JWbsuDFjXOnCTbC5B12H9HvCO4AgB8tvlVxB0L0sv4fG6j7s6esUKoxrO1QMmz9jalS5jfW/zyCg68mIJEGgixnvN5gr1llNed/A/aAbkK2X0kI/cmbghJAd+Qfq4YBWN+x7asjHNXJ3uWLssdmKSqyLV0Z9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783080020; c=relaxed/relaxed;
	bh=nIRicYWAN7eALFj2WeVf3MGLGNgyyZRX21hN1DuKhnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4FsOVAMDiu3dh/1lISLfxyA4daur4F93x50x6XYKMkRy+IxAJpyyBQX8vTCIKPatGtmWHLay9GO3UTOmFrQ4dilZmuCAQKPVv37og2gpPP1PICXuOPCKkIxY6W/hO+k4RTggONLZPgk4eTxK5/2GA7f1LaUZehXPxkhUMDCDNTQ5+prkpkPYedthrUF4Rv3BGiSidlFxkr11vGo/IdTadfjBeZmqHsYGPmoyeaqsB+3BCf2q4Vbu6kKWBYgTLcNnsctArZaYwbAo5fRCmMH4MS9NNCs8qGFaWcbLgTqCMo6OZJJ7Hli7qTTUckWzH3Z9/YpRUrnlkSaFUpdxggieQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BzvOXcJ3; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BzvOXcJ3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsC4M4Br1z2yf9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 22:00:18 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB43D4637;
	Fri,  3 Jul 2026 04:59:42 -0700 (PDT)
Received: from [10.57.81.24] (unknown [10.57.81.24])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 990933F673;
	Fri,  3 Jul 2026 04:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783079987; bh=CtML3PEXn1LHht7AQdQyqLzB0Qb9Ae10yAgK67397Zw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BzvOXcJ33pukFW1hsXEQNbx9QPLsxIFvrmHevHBsOp8nnm06vLzF5mha44X2sHHDU
	 SHr/Zn3XgMMxalHNhRBDOI53sw4fZs97H12agiXgP0ix1sp+Z6e44T3eAOSbucjLm7
	 PcWgBN9O+acHfIv6mNNUdNha0fe7PMafRvzBoqR4=
Message-ID: <fa1f5b39-2703-40a1-81d6-3feba87e19b0@arm.com>
Date: Fri, 3 Jul 2026 13:59:21 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/18] seccomp: Convert __secure_computing() to return
 boolean
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
 oleg@redhat.com, richard.henderson@linaro.org, mattst88@gmail.com,
 linmag7@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
 will@kernel.org, kees@kernel.org, guoren@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, geert@linux-m68k.org, tsbogend@alpha.franken.de,
 James.Bottomley@hansenpartnership.com, deller@gmx.de, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
 glaubitz@physik.fu-berlin.de, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, luto@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 chris@zankel.net, jcmvbkbc@gmail.com, peterz@infradead.org,
 wad@chromium.org, thuth@redhat.com, ada.coupriediaz@arm.com,
 linusw@kernel.org, yeoreum.yun@arm.com, song@kernel.org,
 james.morse@arm.com, anshuman.khandual@arm.com, broonie@kernel.org,
 liqiang01@kylinos.cn, pengcan@kylinos.cn, ryan.roberts@arm.com,
 yangtiezhu@loongson.cn, sshegde@linux.ibm.com, mchauras@linux.ibm.com,
 austin.kim@lge.com, jchrist@linux.ibm.com, arnd@arndb.de,
 thomas.weissschuh@linutronix.de, sohil.mehta@intel.com,
 andrew.cooper3@citrix.com, jgross@suse.com, kas@kernel.org, x86@kernel.org,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
 <20260629130616.642022-2-ruanjinjie@huawei.com>
 <akdp6GAu77-ipsXA@kunlun.suse.cz> <87cxx4mmim.ffs@fw13>
 <akeIK5TRCjlKbzbp@J2N7QTR9R3> <akeOjqMy7HVgRRCr@kunlun.suse.cz>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <akeOjqMy7HVgRRCr@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/07/2026 12:27, Michal Suchánek wrote:
> On Fri, Jul 03, 2026 at 11:00:11AM +0100, Mark Rutland wrote:
>> On Fri, Jul 03, 2026 at 11:48:49AM +0200, Thomas Gleixner wrote:
>>> On Fri, Jul 03 2026 at 09:51, Michal Suchánek wrote:
>>>> On Mon, Jun 29, 2026 at 09:05:59PM +0800, Jinjie Ruan wrote:
>>>>> -	if (secure_computing())
>>>>> +	if (!secure_computing())
>>>>>  		return -1;
>>>> Hello,
>>>>
>>>> I am not fond of this logic inversion. The boolean is meaningless in
>>>> itself.
>>>>
>>>> Previously -1 was used to indicate that the syscall was filtered but you
>>>> chose to invert the logic choosing true to mean syscall was not filtered.
>>>>
>>>> You could choose true to mean that syscall was fitered avoiding this
>>>> inversion.
>>> That's just wrong. Boolean logic makes more sense with having
>>> (!condition()). Just because the old 0/-1 nonsense had it the other way
>>> round does not mean it has to stay that way.
>> 100% agreed!
>>
>> Bikeshedding below; sorry.
>>
>> I think the bigger problem is just that secure_computing() is a terrible
>> name that does not express the intended semantic -- it's not clear
>> whether "secure computing" means "seccomp permit the syscall" or
>> "seccomp is enabled and some special rules now apply" or something else
>> entirely.
>>
>> If we're changing the return type, it might be worth renaming the
>> function something like:
>>
>> 	seccomp_permits_syscall()
> Then not only it is clear which way the boolean value should be
> interpreted, it also pervents the accidental inversion of existing
> calls. Overall great.

Totally agreed, if we have the opportunity to rename a completely
undescriptive function name like "secure_computing" we should take it.

- Kevin

