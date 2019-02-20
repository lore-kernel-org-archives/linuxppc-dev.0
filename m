Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEDCC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 13:27:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BAC720C01
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 13:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAC720C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444JLn70xZzDqJK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 00:27:45 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444JFY2XDVzDqGT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 00:23:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 444JFX0zLHz9s1B;
 Thu, 21 Feb 2019 00:23:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Jonathan =?utf-8?Q?Neusch?=
 =?utf-8?Q?=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH v2 00/15] powerpc/32s: Use BATs/LTLBs for STRICT_KERNEL_RWX
In-Reply-To: <8b072209-c845-20f5-8ff1-27ecd67b5c72@c-s.fr>
References: <cover.1547132681.git.christophe.leroy@c-s.fr>
 <20190113181621.GA22334@latitude>
 <714e78ba-1e92-a856-3dd6-a1fb96ad3785@c-s.fr>
 <20190113210227.GB22334@latitude>
 <334b1b02-b652-499c-904e-09e6f7164b8c@c-s.fr>
 <20190115003353.GD22334@latitude>
 <b37e3635-9c69-0cfc-1283-25459b394033@c-s.fr>
 <87fttuz0d3.fsf@concordia.ellerman.id.au>
 <8b072209-c845-20f5-8ff1-27ecd67b5c72@c-s.fr>
Date: Thu, 21 Feb 2019 00:23:09 +1100
Message-ID: <87ftsi7fwi.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Le 15/01/2019 =C3=A0 11:22, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> Le 15/01/2019 =C3=A0 01:33, Jonathan Neusch=C3=A4fer a =C3=A9crit=C2=A0:
>> ...
>>>>
>>>> - patches 7 to 11 fail to build with this error (really a warning, but
>>>>     arch/powerpc doesn't allow warnings by default):
>>>>
>>>> 	  CC      arch/powerpc/mm/ppc_mmu_32.o
>>>> 	../arch/powerpc/mm/ppc_mmu_32.c:133:13: error: =E2=80=98clearibat=E2=
=80=99 defined but not used [-Werror=3Dunused-function]
>>>> 	 static void clearibat(int index)
>>>> 		     ^~~~~~~~~
>>>> 	../arch/powerpc/mm/ppc_mmu_32.c:115:13: error: =E2=80=98setibat=E2=80=
=99 defined but not used [-Werror=3Dunused-function]
>>>> 	 static void setibat(int index, unsigned long virt, phys_addr_t phys,
>>>> 		     ^~~~~~~
>>>> 	cc1: all warnings being treated as errors
>>>
>>> Argh ! I have to squash the patch bringing the new functions with the
>>> one using them (patch 12). The result is a big messy patch which is more
>>> difficult to review but that's life.
>>=20
>> You don't *have* to squash them.
>>=20
>> We like to preserve bisectability, but it's not a 100% hard requirement.
>>=20
>> Someone trying to bisect through those patches can always turn off
>> -Werror with PPC_DISABLE_WERROR. But they probably can just skip them
>> because they just add new code that's not called yet.
>
> Ok thanks for the note.
>
>>=20
>> So I won't object if you send them as-is.
>
> Good to know. Anyway I think I will at least re-order so that the patch=20
> using the new functions immediatly follows the one adding the functions.
=20
Based on that I'm expecting a v3 of this series, right?

cheers
