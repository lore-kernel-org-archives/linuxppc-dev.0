Return-Path: <SRS0=ruO2=NF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA56C4338F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Aug 2021 12:25:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AA876024A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Aug 2021 12:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0AA876024A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gn05J40Y4z3bX8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 14 Aug 2021 22:25:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=LIT3i5GR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=LIT3i5GR; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gn04X4D2Wz309j
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Aug 2021 22:25:15 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gn04R6yfHz9sX3;
 Sat, 14 Aug 2021 22:25:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1628943913;
 bh=oT9VHAFIQ9Ewgzt1NcvYnGTygwcF2uGCYNxqTKWoE/A=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=LIT3i5GR/rxsfm6KbGCbVC8ou53MEL/azMbHlCo6suhDsKMtQGbbQHjns3vKtY5EW
 qCVmFBZeq+0UXyzfETgIJRPbTUtJlgEWdmwFtODpHmrgKh6xnsbgYkPMrE5Pb+pCEU
 KzN13mNbOQPSFL3jXTFvqMjk5RQpcRPkSzXhzQSt7WjNNiFUoRL8hLytANgXOgFTb9
 LFCIqV9B/BCl9Sas2N/Eq3oHuxkjpS+wqdMVINmgorLNnic1pR/ZG1V3L4NhZde/vm
 MqGRiPGDbmsK8mliN2UnP5ZaGgJirwKR9RtACO/VuCI+hIZMbopetdnTIycawI357N
 cy4de2YHeRNCQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Kajol Jain
 <kjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] powerpc/perf: Return regs->nip as instruction
 pointer value when SIAR is 0
In-Reply-To: <95fc0f78-51d0-82f6-c9d6-de101fec445c@csgroup.eu>
References: <20210813082450.429320-1-kjain@linux.ibm.com>
 <20210813082450.429320-2-kjain@linux.ibm.com>
 <95fc0f78-51d0-82f6-c9d6-de101fec445c@csgroup.eu>
Date: Sat, 14 Aug 2021 22:25:10 +1000
Message-ID: <877dgomcwp.fsf@mpe.ellerman.id.au>
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
Cc: atrajeev@linux.vnet.ibm.com, maddy@linux.ibm.com, rnsastry@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 13/08/2021 =C3=A0 10:24, Kajol Jain a =C3=A9crit=C2=A0:
>> Incase of random sampling, there can be scenarios where SIAR is not
>> latching sample address and results in 0 value. Since current code
>> directly returning the siar value, we could see multiple instruction
>> pointer values as 0 in perf report.
>> Patch resolves this issue by adding a ternary condition to return
>> regs->nip incase SIAR is 0.
>>=20
>> Fixes: 75382aa72f06 ("powerpc/perf: Move code to select SIAR or pt_regs
>> into perf_read_regs")
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> ---
>>   arch/powerpc/perf/core-book3s.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-bo=
ok3s.c
>> index 1b464aad29c4..aeecaaf6810f 100644
>> --- a/arch/powerpc/perf/core-book3s.c
>> +++ b/arch/powerpc/perf/core-book3s.c
>> @@ -2260,7 +2260,7 @@ unsigned long perf_instruction_pointer(struct pt_r=
egs *regs)
>>   		else
>>   			return regs->nip;
>>   	} else if (use_siar && siar_valid(regs))
>> -		return siar + perf_ip_adjust(regs);
>> +		return siar ? siar + perf_ip_adjust(regs) : regs->nip;
>
> Why bother about returning SIAR at all if regs->nip is ok ? Why not just =
return regs->nip all the time ?

Same answer as last time :)

https://lore.kernel.org/linuxppc-dev/87r1prxd9e.fsf@mpe.ellerman.id.au/

ie. SIAR can point into interrupts-off code, whereas regs->nip will
point to where we re-enabled interrupts.

cheers
