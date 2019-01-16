Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71E0C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 05:10:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2EA120840
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 05:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2EA120840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fZz41nl9zDqTG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 16:10:24 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fZxQ1cF1zDqLR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 16:08:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43fZxP4Rh0z9s3l;
 Wed, 16 Jan 2019 16:08:55 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Mathieu Malaterre <malat@debian.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: gcc 6.3 vs 8.2 Re: [RFC PATCH] powerpc: Enable kcov
In-Reply-To: <ea8a051c-481d-ef97-7d1d-8621f194e41e@c-s.fr>
References: <20190115042017.13342-1-andrew.donnellan@au1.ibm.com>
 <CA+7wUsy5xbp_t4fiEUw9C0HKQ8GohcBJZkj8qZnna5990Gm1-w@mail.gmail.com>
 <ea8a051c-481d-ef97-7d1d-8621f194e41e@c-s.fr>
Date: Wed, 16 Jan 2019 16:08:55 +1100
Message-ID: <87tvi9xk7s.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 15/01/2019 =C3=A0 08:26, Mathieu Malaterre a =C3=A9crit=C2=A0:
...
>>=20
>> I did check that `custom_defconfig` is the minimal defconfig generated
>> by `savedefconfig` in both cases.
>>=20
>> Hints or comments welcome, thanks much.
>
> I think you should do:
>
> make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-gnu- custom_defconfig
> make ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc-linux-gnu-

Yep, you definitely need to use the same compiler for configuring and
building.

cheers
