Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375A7C432BE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Aug 2021 14:24:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E48360F58
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Aug 2021 14:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E48360F58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GwQ8c17LYz305X
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 00:24:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=ivwJiyNZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=ivwJiyNZ; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GwQ7v1jGzz2xXd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Aug 2021 00:23:54 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GwQ7s5c2Dz9t0Y;
 Fri, 27 Aug 2021 00:23:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1629987834;
 bh=Kidxo4mwWYy4+7GRSVUf/lCwKVAYXQpR3vIsfSCHXQ0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ivwJiyNZlM0QCLT2P4Mm1o2CrWM7WuhKR1NizdLC13W8XeCISEP5oI5PG8P4a/eDh
 r7y7B7pviQsTE7Vz7Ci9nYPTi6xFcLtTNsvifkZsHwlGgn27C/uYfEQbrpjg4030oN
 W+Tczyn0hygqp9ahVu+7869oxHFjP09wMJT1KUEAHFFPm21zm2pp+k9kcyr80S1iZm
 IXrSzMey1cIU5mjG27fxvnbUtvZuXyQZwzgTtubt6JaS/DIOAGoUqRvHpSRyZ6zOYt
 QxkfkNWl3ttMOgwP576j9xCj7SUSuGXKQ8yvMx0HwC+KLdnXU6PkeXkXSu3sYktlCA
 QEWp0dzyURGbQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Make set_endian() return EINVAL when not
 supporting little endian
In-Reply-To: <df2e9b65-9303-070e-b803-c64e20e2620d@csgroup.eu>
References: <b29c29d205737a833262df38e01c07139f1c3dec.1629899011.git.christophe.leroy@csgroup.eu>
 <87bl5kc1os.fsf@mpe.ellerman.id.au>
 <df2e9b65-9303-070e-b803-c64e20e2620d@csgroup.eu>
Date: Fri, 27 Aug 2021 00:23:50 +1000
Message-ID: <871r6gb7yh.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 26/08/2021 =C3=A0 05:41, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> There is no point in modifying MSR_LE bit on CPUs not supporting
>>> little endian.
>>=20
>> Isn't that an ABI break?
>
> Or an ABI fix ? I don't know.

It could break existing applications, even if the new semantics make
more sense. So that's a break IMHO :)

> My first thought was that all other 32 bits architectures were returning =
-EINVAL, but looking at the=20
> man page of prctl, it is explicit that this is powerpc only.

It could be generic, but yeah seems we're the only arch that implements
it.

>> set_endian(PR_ENDIAN_BIG) should work on a big endian CPU, even if it
>> does nothing useful.
>
> Fair enough. But shouldn't in that case get_endian() return PR_ENDIAN_BIG=
 instead of returning EINVAL ?

> We can do one or the other, but I think it should at least be consistant =
between them, shouldn't it ?

It should be consistent, but it isn't, and if we change it now we
potentially break existing userspace, which is bad.

I don't think it's widely used, and the risk of breakage would be
minimal, but it's not zero.

So I'm not sure it's worth changing it just for the sake of consistency.

cheers
