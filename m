Return-Path: <SRS0=bLNb=WQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3A8C3A589
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Aug 2019 13:59:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E44322CF7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Aug 2019 13:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E44322CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46CXTQ0fcnzDqQc
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Aug 2019 23:59:06 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46CVnT3MGvzDqdb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2019 22:42:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46CVnP0JhKz9s3Z;
 Tue, 20 Aug 2019 22:42:48 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 1/2] powerpc/time: Only set
 CONFIG_ARCH_HAS_SCALED_CPUTIME on PPC64
In-Reply-To: <26969bb5-c01b-0674-5773-027f1851bd44@c-s.fr>
References: <d9ac8da98f53debb4758b98d0227979aca9196f7.1528292284.git.christophe.leroy@c-s.fr>
 <20180607114304.327c4ab5@roar.ozlabs.ibm.com>
 <26969bb5-c01b-0674-5773-027f1851bd44@c-s.fr>
Date: Tue, 20 Aug 2019 22:42:39 +1000
Message-ID: <87imqs57pc.fsf@concordia.ellerman.id.au>
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Hi Nick,
>
>
> Le 07/06/2018 =C3=A0 03:43, Nicholas Piggin a =C3=A9crit=C2=A0:
>> On Wed,  6 Jun 2018 14:21:08 +0000 (UTC)
>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>=20
>>> scaled cputime is only meaningfull when the processor has
>>> SPURR and/or PURR, which means only on PPC64.
>>>
>
> [...]
>
>>=20
>> I wonder if we could make this depend on PPC_PSERIES or even
>> PPC_SPLPAR as well? (That would be for a later patch)
>
> Can we go further on this ?
>
> Do we know exactly which configuration support scaled cputime, in=20
> extenso have SPRN_SPURR and/or SPRN_PURR ?

PURR is Power5/6/7/8/9 and PA6T (pasemi). SPURR is Power6/7/8/9.

So we could easily flip PPC64 for PPC_BOOK3S_64, which would mean 64-bit
Book3E CPUs don't get that overhead.

Beyond that is not so simple. We probably don't need that selected for
bare metal kernels (powernv). But in practice all the distros build a
multi platform kernel with powernv+pseries anyway.

We could turn it off on G5s (PPC970), by making it depend on POWERNV ||
PSERIES || PPC_PASEMI, but I'm not sure if it's worth the trouble.

cheers
