Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A15C4167B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Nov 2023 03:17:18 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=LVO2fAkl;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Sg4Hw6QKbz3dBD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Nov 2023 14:17:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=LVO2fAkl;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Sg4H164PYz2xPc
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2023 14:16:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1701227789;
	bh=P6NMf+VvgB97nCVv666GoPJLTcDHDnUS3MQEtLq/VWI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LVO2fAklKbeuqG8H5zivTr1JhCjOjYm+wD23TrWTz0wfsBaqaOamDo+HhLGR4MyXt
	 zEMCI1RVHiRCF7RdxV7suzyvZHfm1Lz+HFDsdxY+HsJVJ1h9v6HmXLJsasvE3z1ct3
	 2tps9JRAzS78LODJf0vPrVKVUklukm0ZnWC8l0MlgGTqUGykx5rFDxcMiYtAd5H+89
	 DKbU0WVzPnOa1nLWWJlugLgqrnk590wrdgqvpl1kolRD+obStjlrhzufMUZOGHcLgD
	 e2JCS/xPN9HYUywhwltRxpqt0AtPn7oRxYkE3T7uqSyJuqeDdXxJtMbMn1BU+NpvWv
	 O2zkt5Ja2Msxg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sg4H14sMMz4wdD;
	Wed, 29 Nov 2023 14:16:29 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Lynch <nathanl@linux.ibm.com>, Nathan Lynch via B4 Relay
 <devnull+nathanl.linux.ibm.com@kernel.org>, Nicholas Piggin
 <npiggin@gmail.com>
Subject: Re: [PATCH v4 05/13] powerpc/rtas: Facilitate high-level call
 sequences
In-Reply-To: <87h6l51dzx.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
References: <20231117-papr-sys_rtas-vs-lockdown-v4-0-b794d8cb8502@linux.ibm.com>
 <20231117-papr-sys_rtas-vs-lockdown-v4-5-b794d8cb8502@linux.ibm.com>
 <87jzq12ts4.fsf@mail.lhotse>
 <87h6l51dzx.fsf@li-e15d104c-2135-11b2-a85c-d7ef17e56be6.ibm.com>
Date: Wed, 29 Nov 2023 14:16:29 +1100
Message-ID: <87edg92qr6.fsf@mail.lhotse>
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
Cc: tyreld@linux.ibm.com, Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org, gcwilson@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nathan Lynch <nathanl@linux.ibm.com> writes:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> Nathan Lynch via B4 Relay <devnull+nathanl.linux.ibm.com@kernel.org>
>> writes:
>>> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
>>> index 1fc0b3fffdd1..52f2242d0c28 100644
>>> --- a/arch/powerpc/kernel/rtas.c
>>> +++ b/arch/powerpc/kernel/rtas.c
>>> @@ -196,6 +224,12 @@ static struct rtas_function rtas_function_table[] =
__ro_after_init =3D {
>>>  			.buf_idx1 =3D 1, .size_idx1 =3D -1,
>>>  			.buf_idx2 =3D -1, .size_idx2 =3D -1,
>>>  		},
>>> +		/*
>>> +		 * PAPR+ R1=E2=80=937.3.19=E2=80=933 is explicit that the OS must not
>>
>> When you cite PAPR+ can you please include the version number?
>>
>> That's a general comment on this patch and in some other places in the
>> series too.
>
> OK. I assume v2.13 is fine even though most of the citations refer to
> passages that significantly predate that version.

Yeah whatever version you are referring to.

It just means if there's ever confusion about what's in the kernel
comments vs the then current version of PAPR, we can go back and refer
to the exact version you were using.

It also avoids confusion vs LoPAPR, which is simliar but has some
differently numbered chapters.

cheers
