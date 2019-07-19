Return-Path: <SRS0=ugCm=VQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3896C76188
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 14:08:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4882121849
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 14:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4882121849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45qtCQ4JyxzDqpL
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Jul 2019 00:08:50 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45qt8j1gDSzDqvY
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jul 2019 00:06:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45qt8f5BxCz9s3Z;
 Sat, 20 Jul 2019 00:06:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sven Schnelle <svens@stackframe.org>
Subject: Re: [PATCH v3 5/7] kexec_elf: remove elf_addr_to_cpu macro
In-Reply-To: <20190715072417.GA25659@t470p.stackframe.org>
References: <20190710142944.2774-1-svens@stackframe.org>
 <20190710142944.2774-6-svens@stackframe.org>
 <49206784-009c-391b-5f9a-11e9b1de930b@c-s.fr>
 <20190710180518.GA6343@t470p.stackframe.org>
 <871rywhlq4.fsf@concordia.ellerman.id.au>
 <20190715072417.GA25659@t470p.stackframe.org>
Date: Sat, 20 Jul 2019 00:06:21 +1000
Message-ID: <87tvbi6rvm.fsf@concordia.ellerman.id.au>
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
Cc: kexec@lists.infradead.org, deller@gmx.de, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sven Schnelle <svens@stackframe.org> writes:
> Hi Michael,
>
> On Thu, Jul 11, 2019 at 09:08:51PM +1000, Michael Ellerman wrote:
>> Sven Schnelle <svens@stackframe.org> writes:
>> > On Wed, Jul 10, 2019 at 05:09:29PM +0200, Christophe Leroy wrote:
>> >> Le 10/07/2019 =C3=A0 16:29, Sven Schnelle a =C3=A9crit=C2=A0:
>> >> > It had only one definition, so just use the function directly.
>> >>=20
>> >> It had only one definition because it was for ppc64 only.
>> >> But as far as I understand (at least from the name of the new file), =
you
>> >> want it to be generic, don't you ? Therefore I get on 32 bits it woul=
d be
>> >> elf32_to_cpu().
>> >
>> > That brings up the question whether we need those endianess conversion=
s. I would
>> > assume that the ELF file has always the same endianess as the running =
kernel. So
>> > i think we could just drop them. What do you think?
>>=20
>> We should be able to kexec from big to little endian or vice versa, so
>> they are necessary.
>
> I'll update the patch to check for a needed 32/64 bit conversion during r=
untime,
> so we can also kexec from 32 to 64 bit kernels and vice versa. Don't know
> whether that's possible on powerpc, but at least on parisc it is.

On some of the Freescale (NXP) machines that should actually be
possible, the hardware can run a 64 or 32-bit kernel, but I'm not sure
if anyone has actually tested kexec'ing from one to the other.

cheers
