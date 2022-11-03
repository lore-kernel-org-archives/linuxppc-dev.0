Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E011C4332F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Nov 2022 00:03:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4N2kVD61fwz3gLK
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Nov 2022 11:03:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=EJ9I671/;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4N2kT93xssz3gJl
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2022 11:02:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=EJ9I671/;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4N2kT32cJYz4xG6;
	Thu,  3 Nov 2022 11:01:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1667433722;
	bh=31iurRyfa4zXHGbVOXuCKxTdBrIQn+fBDXQE7fkQ3YQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EJ9I671/xYV8EKoDea0eoD7YmsLG9C3ul8CcFANkB+8jLL9nzmRtDAtj9tkXCMKGh
	 23stO8K6u/R7J335Roodwtx93MgJ5oRkJdN0VQ3+q3pkfoQ34S0NRy5kFiNArjXpoW
	 xAoRaBfRLHTDWzRa3NhqFukc0G/5Mu7kTuLurKlD9uoouUu/Vd2xCghz81s3g0iGNR
	 pzq38D52XsDfvxPUfkNph3Bo92gDajz7E5dJKflPpGh2EfOqFDZIjgSZwaTKAF+L54
	 RiPtP5YFtCC73UFFPCQ+uNOJnTce62Qc78+mHqIeRxHwkn1FDl7JOleRLJ4DTcAEuB
	 E5jTCzUQ+wKdg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Sathvika Vasireddy
 <sv@linux.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v5 02/16] powerpc: Override __ALIGN and __ALIGN_STR macros
In-Reply-To: <327c371a-a8f4-1676-3da8-f454612b5c58@csgroup.eu>
References: <20221028143346.183569-1-sv@linux.ibm.com>
 <20221028143346.183569-3-sv@linux.ibm.com>
 <327c371a-a8f4-1676-3da8-f454612b5c58@csgroup.eu>
Date: Thu, 03 Nov 2022 11:01:54 +1100
Message-ID: <87tu3gsy6l.fsf@mpe.ellerman.id.au>
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
Cc: "peterz@infradead.org" <peterz@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "aik@ozlabs.ru" <aik@ozlabs.ru>, "mingo@redhat.com" <mingo@redhat.com>, "npiggin@gmail.com" <npiggin@gmail.com>, "jpoimboe@redhat.com" <jpoimboe@redhat.com>, "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>, "mbenes@suse.cz" <mbenes@suse.cz>, "chenzhongjin@huawei.com" <chenzhongjin@huawei.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 28/10/2022 =C3=A0 16:33, Sathvika Vasireddy a =C3=A9crit=C2=A0:
>> In a subsequent patch, we would want to annotate powerpc assembly functi=
ons
>> with SYM_FUNC_START_LOCAL macro. This macro depends on __ALIGN macro.
>>=20
>> The default expansion of __ALIGN macro is:
>>          #define __ALIGN      .align 4,0x90
>>=20
>> So, override __ALIGN and __ALIGN_STR macros to use the same alignment as
>> that of the existing _GLOBAL macro. Also, do not pad with 0x90, because
>> repeated 0x90s are not a nop or trap on powerpc.
>
> By the way, do we know what the instruction 0x90909090 is on powerpc ?=20
> Is that something valid or not ?

According to objdump it's:

stw     r4,-28528(r16)

cheers
