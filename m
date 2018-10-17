Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E46C5ACCC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 00:49:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A816214C3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 00:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A816214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZYVP1Ft1zF3VM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 11:49:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZYSR6vlHzF3VB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 11:48:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42ZYSR3svrz9s9h;
 Wed, 17 Oct 2018 11:48:07 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v06 3/5] migration/memory: Add hotplug READD_MULTIPLE
In-Reply-To: <8fa9d2c2-97a9-69ac-1e3b-cdf867e225e2@linux.vnet.ibm.com>
References: <20181015194738.5705.88953.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <f38687fe-7d46-830b-e4bb-ef78a7f99a65@linux.vnet.ibm.com>
 <87sh16lo72.fsf@concordia.ellerman.id.au>
 <80494db2-6a01-059f-890c-df7c410714f7@linux.vnet.ibm.com>
 <8fa9d2c2-97a9-69ac-1e3b-cdf867e225e2@linux.vnet.ibm.com>
Date: Wed, 17 Oct 2018 11:48:07 +1100
Message-ID: <871s8pl7p4.fsf@concordia.ellerman.id.au>
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
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, Juliet Kim <minkim@us.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
> On 10/16/2018 02:57 PM, Tyrel Datwyler wrote:
>> On 10/15/2018 05:39 PM, Michael Ellerman wrote:
>>> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>>>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
>>>> index 2b796da..9c76345 100644
>>>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>>>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>>>> @@ -541,6 +549,23 @@ static int dlpar_memory_readd_by_index(u32 drc_index)
>>>>  	return rc;
>>>>  }
>>>>
>>>> +static int dlpar_memory_readd_multiple(void)
>>>> +{
>>>> +	struct drmem_lmb *lmb;
>>>> +	int rc;
>>>> +
>>>> +	pr_info("Attempting to update multiple LMBs\n");
>>>> +
>>>> +	for_each_drmem_lmb(lmb) {
>>>> +		if (drmem_lmb_update(lmb)) {
>>>> +			rc = dlpar_memory_readd_helper(lmb);
>>>> +			drmem_remove_lmb_update(lmb);
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return rc;
>>>> +}
>>>
>>> This leaves rc potentially uninitialised.
>>>
>>> What should the result be in that case, -EINVAL ?
>> 
>> On another note if there are multiple LMBs to update the value of rc only reflects the final dlpar_memory_readd_helper() call.
>
> Correct.  But that is what happens when we compress common code
> between two disparate uses i.e. updating memory association after
> a migration event with no reporting mechanism other than the console
> log, vs re-adding a single LMB by index for the purposes of DLPAR / drmgr.
>
> I could discard the return value from dlpar_memory_readd_helper entirely
> in this function and just return 0, but in my experience, once errors start
> to occur in memory dlpar ops, they tend to keep on occurring, so I was
> returning the last one.  We could also make the code smart enough to
> capture and return the first/last non-zero return code.  I didn't believe
> that the frequency of errors for this operation warranted the overhead.

The actual error value is probably not very relevant.

But dropping errors entirely is almost always a bad idea.

So I think you should at least return an error if any error occurred,
that way at least an error will be returned up to the caller(s).

Something like:

	int rc;

	rc = 0;
	for_each_drmem_lmb(lmb) {
		if (drmem_lmb_update(lmb)) {
			rc |= dlpar_memory_readd_helper(lmb);
			drmem_remove_lmb_update(lmb);
		}
	}

	if (rc)
		return -EIO;


cheers
