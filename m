Return-Path: <SRS0=/Qvz=43=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA229C10DCE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2020 04:46:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5282465A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2020 04:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="I2gVuXao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5282465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48c2cN4jnkzDqZw
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2020 15:46:44 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48c2ZN0W8TzDqQm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2020 15:45:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 48c2ZM6Vykz9sRR; Tue, 10 Mar 2020 15:44:59 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 48c2ZJ2vhYz9sRN;
 Tue, 10 Mar 2020 15:44:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1583815499;
 bh=bEHwhhp+ToBBBkDedsqbBQ3oVlaBB0ehxgtaeFQLb/w=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=I2gVuXaoCwB1wqMe2cYAANxJaHB2Dopa3NKrNDz/fYGokfEaxlu0eMbsft5WhahFe
 Kjod3YYvrbG10z5j+tuSYhNOgb4QbSyv+OhdfMuZQLrLIrEnrlivEB18KlrOeoi8v9
 T126kYcwLn5dHm09Dh8BRYntsjNn2W2Mbt06Lx2kWvc4CLW+EVfbfzKz0dxQcP9ZVP
 VjGdxZQ8OLppPOzft9cGF/lrRPYIibmVrITBdp33xLO7jD7vY5cey7Cjkv0vyNzvaf
 A6/ipMx01/Y85PYD+ZmcUh/YRsLI3SJhEK2EFmhDKx8uuBVXqaoojjkoaaalti9N/2
 tV5Q8qaAB304A==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: ppc32 panic on boot on linux-next
In-Reply-To: <c084a429-9ea1-7126-f057-8647a2e0dfac@c-s.fr>
References: <CAKwvOdk=eFqRqN0KO1en9wH-NhcvwXbx_ntmUtf8h_xZSd-qKw@mail.gmail.com>
 <3702b680-a0fc-20dc-027b-518b880f9a41@c-s.fr>
 <c084a429-9ea1-7126-f057-8647a2e0dfac@c-s.fr>
Date: Tue, 10 Mar 2020 15:44:54 +1100
Message-ID: <875zfcked5.fsf@mpe.ellerman.id.au>
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
Cc: clang-built-linux <clang-built-linux@googlegroups.com>,
 linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 07/03/2020 =C3=A0 09:42, Christophe Leroy a =C3=A9crit=C2=A0:
>> Le 06/03/2020 =C3=A0 20:05, Nick Desaulniers a =C3=A9crit=C2=A0:
>>> As a heads up, our CI went red last night, seems like a panic from
>>> free_initmem?=C2=A0 Is this a known issue?
>>=20
>> Thanks for the heads up.
>>=20
>> No such issue with either 8xx or book3s/32.
>>=20
>> I've now been able to reproduce it with bamboo QEMU.
>>=20
>> Reverting 2efc7c085f05 makes it disappear. I'll investigate.
>>=20
>
> Ok, I found the problem. virt_to_kpte() lacks a NULL pmd check. I'll=20
> send a patch for that.
>
> However, if there is no PMD I guess this area is mapped through some=20
> kind of block mapping. Therefore it should bail out of the function throu=
gh:
>
> 	if (v_block_mapped(address))
> 		return 0;
>
>
> Can someone who knows BOOKE investigate that ?

Not sure we have anyone left?

cheers
