Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6339C282C5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 08:51:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F27420861
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 08:51:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F27420861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kzY46JSBzDqJg
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 19:51:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.61.98; helo=8.mo177.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 8.mo177.mail-out.ovh.net (8.mo177.mail-out.ovh.net
 [46.105.61.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kzTn5pD8zDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 19:48:43 +1100 (AEDT)
Received: from player729.ha.ovh.net (unknown [10.109.143.220])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 7EAA4DB1D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 09:48:39 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player729.ha.ovh.net (Postfix) with ESMTPSA id A2AD4217B697;
 Wed, 23 Jan 2019 08:48:31 +0000 (UTC)
Subject: Re: [PATCH 11/19] KVM: PPC: Book3S HV: add support for the XIVE
 native exploitation mode hcalls
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@ozlabs.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-12-clg@kaod.org> <20190122052346.GF15124@blackberry>
 <de777e750665d92509b1487a90acb79d70854cf3.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3ada7c25-c671-32d2-4c91-dd7e84c29e48@kaod.org>
Date: Wed, 23 Jan 2019 09:48:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <de777e750665d92509b1487a90acb79d70854cf3.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3055410872551836551
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrheelgdduvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/23/19 7:44 AM, Benjamin Herrenschmidt wrote:
> On Tue, 2019-01-22 at 16:23 +1100, Paul Mackerras wrote:
>>
>> Which ones of these could be implemented in QEMU?  Are there any that
>> can't possibly be implemented in QEMU because they need to do things
>> that require calling internal interfaces that userspace doesn't have
>> access to?
> 
> Implementing them in qemu doesn't make a lot of sense. Qemu doesn't
> have access to most of the XIVE HW state. There's a XIVE model for full
> emulation but when using the real thing, almost none of it is visible.
> A lot of those hcalls effectively turn into OPAL calls.
> 
>> How often do we expect each of these hypercalls to be called?
> 
> It depends, I can't tell for AIX. For Linux, not often with one
> exception: H_INT_ESB which will be used whenever you EOI an emulated
> LSI.

yes. This one is only doing loads and stores.

>  .../...
> 
>> Why do we need to provide real-mode versions of these hypercall
>> handlers?  I thought these hypercalls would only get called
>> infrequently, and in any case certainly much less frequently than once
>> per interrupt delivered.  If they are infrequent, then let's leave out
>> the real-mode version and just handle them in book3s_hv.c.
> 
> Agreed with the exception maybe of H_INT_ESB

ok. 

Some of these hcalls are really simple and only getting local info from 
the host (h_int_get_*). I thought handling the hcall ASAP was a preferred 
practice, even if the hcall is not called frequently. Isn't it ?

 
>>> @@ -5153,6 +5169,19 @@ static unsigned int default_hcall_list[] = {
>>>        H_IPOLL,
>>>        H_XIRR,
>>>        H_XIRR_X,
>>> +#endif
>>> +#ifdef CONFIG_KVM_XIVE
>>> +     H_INT_GET_SOURCE_INFO,
>>> +     H_INT_SET_SOURCE_CONFIG,
>>> +     H_INT_GET_SOURCE_CONFIG,
>>> +     H_INT_GET_QUEUE_INFO,
>>> +     H_INT_SET_QUEUE_CONFIG,
>>> +     H_INT_GET_QUEUE_CONFIG,
>>> +     H_INT_SET_OS_REPORTING_LINE,
>>> +     H_INT_GET_OS_REPORTING_LINE,
>>> +     H_INT_ESB,
>>> +     H_INT_SYNC,
>>> +     H_INT_RESET,
>>>   #endif
>>
>> The policy is not to add new hcalls to default_hcall_list[].  Is there
>> a strong reason for adding them here?

I don't remember. I will check for v2.

Thanks, 

C.

