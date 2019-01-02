Return-Path: <SRS0=1YdR=PK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8E3C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 11:14:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78672218A4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 11:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78672218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43V7jq1kKSzDqGb
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 22:14:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43V7gg10c6zDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jan 2019 22:12:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43V7gf67C4z9s7T; Wed,  2 Jan 2019 22:12:46 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43V7gf3XhNz9s4s;
 Wed,  2 Jan 2019 22:12:46 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 1/2] powerpc/4xx/ocm: Fix phys_addr_t printf warnings
In-Reply-To: <20190101175219.Horde.M9y96Jn9ywiZ5BbROIsFAg1@messagerie.si.c-s.fr>
References: <20190101175219.Horde.M9y96Jn9ywiZ5BbROIsFAg1@messagerie.si.c-s.fr>
Date: Wed, 02 Jan 2019 22:12:52 +1100
Message-ID: <87lg43xqh7.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, chunkeey@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

LEROY Christophe <christophe.leroy@c-s.fr> writes:

> Michael Ellerman <mpe@ellerman.id.au> a =C3=A9crit=C2=A0:
>
>> Currently the code produces several warnings, eg:
>>
>>   arch/powerpc/platforms/4xx/ocm.c:240:38: error: format '%llx'
>>   expects argument of type 'long long unsigned int', but argument 3
>>   has type 'phys_addr_t {aka unsigned int}'
>>      seq_printf(m, "PhysAddr     : 0x%llx\n", ocm->phys);
>>                                    ~~~^     ~~~~~~~~~
>>
>> Fix it by using the special %pa[p] format for printing phys_addr_t.
>> Note we need to pass the value by reference for the special specifier
>> to work.
>
> When I fixed the same problem in prom.c, you suggested to simply cast=20=
=20
> it to unsigned long long. Is this a better solution ?

Did I?

Oh you mean here:
  https://patchwork.ozlabs.org/patch/1012875/


Yeah I was just commenting on the ifdef, I didn't actually realise it
was a phys_addr_t that was the cause of the problem.

So yeah I guess it is preferable to use %pa[p] in prom.c as well.

cheers
