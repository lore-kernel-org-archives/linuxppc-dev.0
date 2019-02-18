Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDEFC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 02:35:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A523218DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 02:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A523218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 442nyl5RFVzDqLG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 13:35:11 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 442nx230R3zDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 13:33:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 442nx16v39z9s3l;
 Mon, 18 Feb 2019 13:33:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: export timebase register sample in
 lparcfg
In-Reply-To: <f47fe713-9c83-554c-9409-265e10389c5c@linux.vnet.ibm.com>
References: <1544312907-17555-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <f47fe713-9c83-554c-9409-265e10389c5c@linux.vnet.ibm.com>
Date: Mon, 18 Feb 2019 13:33:41 +1100
Message-ID: <87ftslrfju.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 puvichakravarthy@in.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
> Ping? Any objections to this patch? A fix is already upstream in powerpc-utils
> to utilize the timebase value if available.

I'm slightly wary of adding things to lparcfg as it's world-readable and
hard to remove things once they're added (because tools rely on it).

But I guess this is fine.

If we ever want to restrict mftb access then we need to remember to also
lock down this file, or reduce the precision it returns.

cheers

> On 12/08/2018 03:48 PM, Tyrel Datwyler wrote:
>> The Processor Utilzation of Resource Registers (PURR) provide an estimate of
>> resources used by a cpu thread. Section 7.6 in Book III of the ISA outlines
>> how to calculate the percentage of shared resources for threads using the
>> ratio of the PURR delta and Timebase Register delta for a sampled period.
>> 
>> This calculation is currently done erroneously by the lparstat tool from the
>> powerpc-utils package. This patch exports the current timebase value after
>> we sample the PURRs and exposes it to userspace accounting tools via
>> /proc/ppc64/lparcfg.
>> 
>> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/lparcfg.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
>> index 7944873..1ea73ec 100644
>> --- a/arch/powerpc/platforms/pseries/lparcfg.c
>> +++ b/arch/powerpc/platforms/pseries/lparcfg.c
>> @@ -475,6 +475,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void *v)
>>  		splpar_dispatch_data(m);
>> 
>>  		seq_printf(m, "purr=%ld\n", get_purr());
>> +        seq_printf(m, "tbr=%ld\n", mftb());
>>  	} else {		/* non SPLPAR case */
>> 
>>  		seq_printf(m, "system_active_processors=%d\n",
>> 
