Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF002C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 09:14:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 667F72086A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 09:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667F72086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444pgt3pLhzDqN3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 20:14:18 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444pds1pHtzDqMp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 20:12:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 444pdp1b8Nz9sBr;
 Thu, 21 Feb 2019 20:12:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Move page table dump files in a dedicated
 subdirectory
In-Reply-To: <0f371616-0ab6-fe96-852a-323159c58572@c-s.fr>
References: <913780421c7b73d731bbbe04c215e29667f7c938.1550492751.git.christophe.leroy@c-s.fr>
 <87d0nm7f8l.fsf@concordia.ellerman.id.au>
 <0f371616-0ab6-fe96-852a-323159c58572@c-s.fr>
Date: Thu, 21 Feb 2019 20:12:26 +1100
Message-ID: <87ef81wlmt.fsf@concordia.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 20/02/2019 =C3=A0 14:37, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>=20
>>> This patch moves the files related to page table dump in a
>>> dedicated subdirectory.
>>>
>>> The purpose is to clean a bit arch/powerpc/mm by regrouping
>>> multiple files handling a dedicated function.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>   arch/powerpc/Kconfig.debug                                   |  4 ----
>>>   arch/powerpc/mm/Makefile                                     | 10 +--=
-------
>>>   arch/powerpc/mm/ptdump/Makefile                              |  9 +++=
++++++
>>>   arch/powerpc/mm/{ =3D> ptdump}/dump_bats.c                     |  0
>>>   arch/powerpc/mm/{ =3D> ptdump}/dump_hashpagetable.c            |  0
>>>   arch/powerpc/mm/{ =3D> ptdump}/dump_linuxpagetables-8xx.c      |  0
>>>   arch/powerpc/mm/{ =3D> ptdump}/dump_linuxpagetables-book3s64.c |  0
>>>   arch/powerpc/mm/{ =3D> ptdump}/dump_linuxpagetables-generic.c  |  0
>>>   arch/powerpc/mm/{ =3D> ptdump}/dump_linuxpagetables.c          |  0
>>>   arch/powerpc/mm/{ =3D> ptdump}/dump_linuxpagetables.h          |  0
>>>   arch/powerpc/mm/{ =3D> ptdump}/dump_sr.c                       |  0
>>>   11 files changed, 10 insertions(+), 13 deletions(-)
>>>   create mode 100644 arch/powerpc/mm/ptdump/Makefile
>>>   rename arch/powerpc/mm/{ =3D> ptdump}/dump_bats.c (100%)
>>>   rename arch/powerpc/mm/{ =3D> ptdump}/dump_hashpagetable.c (100%)
>>>   rename arch/powerpc/mm/{ =3D> ptdump}/dump_linuxpagetables-8xx.c (100=
%)
>>>   rename arch/powerpc/mm/{ =3D> ptdump}/dump_linuxpagetables-book3s64.c=
 (100%)
>>>   rename arch/powerpc/mm/{ =3D> ptdump}/dump_linuxpagetables-generic.c =
(100%)
>>>   rename arch/powerpc/mm/{ =3D> ptdump}/dump_linuxpagetables.c (100%)
>>>   rename arch/powerpc/mm/{ =3D> ptdump}/dump_linuxpagetables.h (100%)
>>>   rename arch/powerpc/mm/{ =3D> ptdump}/dump_sr.c (100%)
>>=20
>> I'd like to shorten the file names as well, now that they're namespaced
>> in the ptdump directory, how about:
>>=20
>>   arch/powerpc/Kconfig.debug                                            =
 |  4 ----
>>   arch/powerpc/mm/Makefile                                              =
 | 10 +---------
>>   arch/powerpc/mm/{dump_linuxpagetables-8xx.c =3D> ptdump/8xx.c}        =
   |  2 +-
>>   arch/powerpc/mm/ptdump/Makefile                                       =
 |  9 +++++++++
>>   arch/powerpc/mm/{dump_bats.c =3D> ptdump/bats.c}                      =
   |  0
>>   arch/powerpc/mm/{dump_linuxpagetables-book3s64.c =3D> ptdump/book3s64.=
c} |  2 +-
>>   arch/powerpc/mm/{dump_hashpagetable.c =3D> ptdump/hashpagetable.c}    =
   |  0
>>   arch/powerpc/mm/{dump_linuxpagetables.c =3D> ptdump/ptdump.c}         =
   |  2 +-
>>   arch/powerpc/mm/{dump_linuxpagetables.h =3D> ptdump/ptdump.h}         =
   |  0
>>   arch/powerpc/mm/{dump_sr.c =3D> ptdump/segment_regs.c}                =
   |  0
>>   arch/powerpc/mm/{dump_linuxpagetables-generic.c =3D> ptdump/shared.c} =
   |  2 +-
>
> Yes good idea. Do you want a v2 or will you do it ?

I'll do it, thanks.

cheers
