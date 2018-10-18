Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0007C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 13:18:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 695932145D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 13:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 695932145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bV3s0XJFzF3FB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 00:18:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bV1f1wqqzF38P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 00:16:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42bV1f13vdz9s9J; Fri, 19 Oct 2018 00:16:38 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42bV1d4QGhz9s8T;
 Fri, 19 Oct 2018 00:16:37 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Don't print kernel instructions in
 show_user_instructions()
In-Reply-To: <6b3b54e5-cbe3-c693-23ea-26928e7597c8@c-s.fr>
References: <20181005132123.6038-1-mpe@ellerman.id.au>
 <6b3b54e5-cbe3-c693-23ea-26928e7597c8@c-s.fr>
Date: Fri, 19 Oct 2018 00:16:33 +1100
Message-ID: <87o9br5r9q.fsf@concordia.ellerman.id.au>
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
>> around the NIP when a user space process dies with an unhandled
>> signal. This was modelled on the x86 code, and we even went so far as
>> to implement the exact same bug, namely that if the user process
>> crashed with its NIP pointing into the kernel we will dump kernel text
>> to dmesg. eg:
>>=20
>>    bad-bctr[2996]: segfault (11) at c000000000010000 nip c00000000001000=
0 lr 12d0b0894 code 1
>>    bad-bctr[2996]: code: fbe10068 7cbe2b78 7c7f1b78 fb610048 38a10028 38=
810020 fb810050 7f8802a6
>>    bad-bctr[2996]: code: 3860001c f8010080 48242371 60000000 <7c7b1b79> =
4082002c e8010080 eb610048
>>=20
>> This was discovered on x86 by Jann Horn and fixed in commit
>> 342db04ae712 ("x86/dumpstack: Don't dump kernel memory based on usermode=
 RIP").
>>=20
>> Fix it by checking the adjusted NIP value (pc) and number of
>> instructions against USER_DS, and bail if we fail the check, eg:
>>=20
>>    bad-bctr[2969]: segfault (11) at c000000000010000 nip c00000000001000=
0 lr 107930894 code 1
>>    bad-bctr[2969]: Bad NIP, not dumping instructions.
>>=20
>> Fixes: 88b0fe175735 ("powerpc: Add show_user_instructions()")
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>   arch/powerpc/kernel/process.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>=20
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
> Is there any reason for not using access_ok() here ?

I wanted to check against USER_DS explicitly. But maybe that was
over-paranoid of me.

cheers
