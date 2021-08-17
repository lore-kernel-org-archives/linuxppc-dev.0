Return-Path: <SRS0=mX83=NI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE2DC4320A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 12:50:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8783460F41
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 12:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8783460F41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GprTk68dcz3cLg
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 22:50:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Okm274n1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Okm274n1; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GprT1260fz2ymS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Aug 2021 22:49:25 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GprSz4CfZz9sSs;
 Tue, 17 Aug 2021 22:49:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1629204564;
 bh=TSTAxhtCtdppesAv6FTLycAyK4ryy4vXUJm5VCnWWtU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Okm274n1QU8+i3Rtaj5p5cBT4UQcJ8PEHNEDvdcQSRVyl2IxrBOc3r75abEuOw5uv
 XqXmHkLnbgt6/nvxrDaFtwdKzcpe9hKMUcuW+yHO2AY5qGxWkvSYt0GFNlWOqjf9XM
 XW4N/S1nKflnvI3JUYnE3p7Py4yGppU3CLTUyrDlPODjgOK3S/fVfeirPpSoJ8jL7A
 kXlJGx9mjBc1mROnR/pCT0k7Jv9qVTrQQzKoGHq6PyTq9k3w0SNodBNpBy9l194Uxr
 BcUeP+4pdB2RKSr2Euxg9f+4D6pbJfPKbpGZrGVg058iSBtWybAgZsX9lKsQnHeKNK
 fgrzF9GzXyfyA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, kajoljain
 <kjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] powerpc/perf: Return regs->nip as instruction
 pointer value when SIAR is 0
In-Reply-To: <3a34c79d-b800-1a11-7a4b-1fb3babb9df1@csgroup.eu>
References: <20210813082450.429320-1-kjain@linux.ibm.com>
 <20210813082450.429320-2-kjain@linux.ibm.com>
 <c6110aa1-90e2-77aa-1ab5-355975037227@csgroup.eu>
 <871r6wmc16.fsf@mpe.ellerman.id.au>
 <0068dbc4-fa4b-ce98-9e89-3f02f939720d@linux.ibm.com>
 <3a34c79d-b800-1a11-7a4b-1fb3babb9df1@csgroup.eu>
Date: Tue, 17 Aug 2021 22:49:22 +1000
Message-ID: <871r6sgrsd.fsf@mpe.ellerman.id.au>
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
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 atrajeev@linux.vnet.ibm.com, maddy@linux.ibm.com, rnsastry@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 16/08/2021 =C3=A0 08:44, kajoljain a =C3=A9crit=C2=A0:
>> On 8/14/21 6:14 PM, Michael Ellerman wrote:
...
>>>
>>> eg.
>>>
>>> 	if (use_siar && siar_valid(regs) && siar)
>>> 		return siar + perf_ip_adjust(regs);
>>> 	else if (use_siar)
>>> 		return 0;		// no valid instruction pointer
>>> 	else
>>> 		return regs->nip;
>>>
>>>
>>> I'm also not sure why we have that return 0 case, I can't think of why
>>> we'd ever want to do that rather than using nip. So maybe we should do
>>> another patch to drop that case.
>>=20
>> Yeah make sense. I will remove return 0 case in my next version.
>
> This was added by commit=20
> https://github.com/linuxppc/linux/commit/e6878835ac4794f25385522d29c634b7=
bbb7cca9
>
> Are we sure it was an error to add it and it can be removed ?

I think so.

That commit added siar_valid(), and updated record_and_restart() to only
record if siar_valid() returned true.

  -                        record =3D 1;
  +                        record =3D siar_valid(regs);

It then also changed perf_instruction_pointer():

  -        if (use_siar)
  +        if (use_siar && siar_valid(regs))
                   return mfspr(SPRN_SIAR) + perf_ip_adjust(regs);
  +        else if (use_siar)
  +                return 0;                // no valid instruction pointer
           else
                   return regs->nip;


The first change means we would never even call
perf_instruction_pointer() if siar_valid() is false, so we could never
hit the use_siar && !siar_valid() case.

But even so it's always preferable to use regs->nip than 0, even if nip
is somewhat skewed due to interrupts being disabled etc.

cheers
