Return-Path: <SRS0=CZBu=FE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF92C64E7B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 01:44:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B58420757
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 01:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="cwT9HXeo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B58420757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ckp1m0VWnzDqQL
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 12:44:28 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cknzr18ttzDqPb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2020 12:42:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=cwT9HXeo; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Cknzq3lhlz9sTc;
 Mon, 30 Nov 2020 12:42:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1606700567;
 bh=nTmvkAgp/a6j6G1JPow/zeZXjJMv2DMIhVNr42sxwHY=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=cwT9HXeoVCHV+1SUO9aUOUPmgvSBo7QGgAdixyFZtWqNwk2RUb3Ftn2/y67vfSgVv
 UzQHx6k/FuDtXTj4Nv1Z1EJnjyxYBeX8Zb2mTOsTExul24clzTRycmYJ/1ufgh/WJX
 yXgnilg9gHUN4rfdR+mN5z7lZqrNaQrVx2r5e6ANPi/IWSAQDsFgjvjwxopyobwPue
 n8x2Oemxz9TNzt869KGJm3n+/r+V64n4O7XIxg2UpyeVXHV2EwyNpDSzXYDx9fp+Mj
 n3M0yGSksDhu2PVWkML++5dqC5HfTIDVP5W8UIfvdoV6Tf0NLY1zZqsfwFH4LPuW9l
 Ov2CihOEHrx0A==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jordan Niethe <jniethe5@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Allow relative pointers in bug table entries
In-Reply-To: <5c997bc4-c859-0db6-f167-37ca37819059@csgroup.eu>
References: <20201127030238.763-1-jniethe5@gmail.com>
 <5c997bc4-c859-0db6-f167-37ca37819059@csgroup.eu>
Date: Mon, 30 Nov 2020 12:42:46 +1100
Message-ID: <874kl7y609.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 27/11/2020 =C3=A0 04:02, Jordan Niethe a =C3=A9crit=C2=A0:
>> This enables GENERIC_BUG_RELATIVE_POINTERS on Power so that 32-bit
>> offsets are stored in the bug entries rather than 64-bit pointers.
>>=20
>> Signed-off-by: Jordan Niethe <jniethe5@gmail.com>
>> ---
>>   arch/powerpc/Kconfig           |  4 ++++
>>   arch/powerpc/include/asm/bug.h | 37 ++++++++++++++++++++++++++++++++--
>>   arch/powerpc/xmon/xmon.c       | 17 ++++++++++++++--
>>   3 files changed, 54 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index e9f13fe08492..294108e0e5c6 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -311,6 +311,10 @@ config GENERIC_BUG
>>   	default y
>>   	depends on BUG
>>=20=20=20
>> +config GENERIC_BUG_RELATIVE_POINTERS
>> +	def_bool y
>> +	depends on GENERIC_BUG
>> +
>>   config SYS_SUPPORTS_APM_EMULATION
>>   	default y if PMAC_APM_EMU
>>   	bool
>> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/b=
ug.h
>> index 338f36cd9934..d03d834042a1 100644
>> --- a/arch/powerpc/include/asm/bug.h
>> +++ b/arch/powerpc/include/asm/bug.h
>> @@ -12,7 +12,11 @@
>>   #ifdef CONFIG_DEBUG_BUGVERBOSE
>>   .macro EMIT_BUG_ENTRY addr,file,line,flags
>>   	 .section __bug_table,"aw"
>> +#ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
>
> As far as I understand, as soon as CONFIG_BUG is selected, GENERIC_BUG is=
 automatically selected so=20
> GENERIC_BUG_RELATIVE_POINTERS is selected as well. Therefore this #ifndef=
 is never possible.

Yeah.

There is one place in the generic code that has an ifndef CONFIG_GENERIC_BU=
G_RELATIVE_POINTERS
but that's because it has to support arches that don't select it.

In the arch code we know that it's enabled, so there should be no need
for any ifdefs.

cheers
