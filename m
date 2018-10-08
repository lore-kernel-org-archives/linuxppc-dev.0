Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C1AC00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 08:14:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9CA2087C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 08:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9CA2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TCnC4k2HzF3Bw
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 19:14:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TCkz0gC6zF37c
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 19:12:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42TCkz0773z9s5c; Mon,  8 Oct 2018 19:12:11 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42TCky4nlzz9s3C;
 Mon,  8 Oct 2018 19:12:10 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Don't print kernel instructions in
 show_user_instructions()
In-Reply-To: <73301bba-c675-a930-83d6-5b258c07c26e@c-s.fr>
References: <20181005132123.6038-1-mpe@ellerman.id.au>
 <73301bba-c675-a930-83d6-5b258c07c26e@c-s.fr>
Date: Mon, 08 Oct 2018 19:12:07 +1100
Message-ID: <871s903lig.fsf@concordia.ellerman.id.au>
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
Cc: jannh@google.com, muriloo@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe LEROY <christophe.leroy@c-s.fr> writes:
> Le 05/10/2018 =C3=A0 15:21, Michael Ellerman a =C3=A9crit=C2=A0:
>> Recently we implemented show_user_instructions() which dumps the code
...
>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process=
.c
>> index 913c5725cdb2..bb6ac471a784 100644
>> --- a/arch/powerpc/kernel/process.c
>> +++ b/arch/powerpc/kernel/process.c
>> @@ -1306,6 +1306,16 @@ void show_user_instructions(struct pt_regs *regs)
>>=20=20=20
>>   	pc =3D regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
>>=20=20=20
>> +	/*
>> +	 * Make sure the NIP points at userspace, not kernel text/data or
>> +	 * elsewhere.
>> +	 */
>> +	if (!__access_ok(pc, instructions_to_print * sizeof(int), USER_DS)) {
>> +		pr_info("%s[%d]: Bad NIP, not dumping instructions.\n",
>> +			current->comm, current->pid);
>> +		return;
>> +	}
>> +
>
> This will conflict with my serie=20
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D64611=20
> which changes instructions_to_print to a constant. Will you merge it or=20
> do you expect me to rebase my serie ?

I can fix it up.

But I see you've already rebased it and resent, you're too quick for me :)

cheers
