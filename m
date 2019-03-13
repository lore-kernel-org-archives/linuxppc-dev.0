Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24015C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 09:58:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 478292087C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 09:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 478292087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44K6k352JSzDqLB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 20:58:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=87.98.173.157; helo=11.mo7.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 598 seconds by postgrey-1.36 at bilbo;
 Wed, 13 Mar 2019 20:57:17 AEDT
Received: from 11.mo7.mail-out.ovh.net (11.mo7.mail-out.ovh.net
 [87.98.173.157])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44K6hF5W0fzDqHZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 20:57:14 +1100 (AEDT)
Received: from player714.ha.ovh.net (unknown [10.109.143.145])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id BC63E109017
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 10:40:30 +0100 (CET)
Received: from kaod.org (lfbn-1-2226-17.w90-76.abo.wanadoo.fr [90.76.48.17])
 (Authenticated sender: clg@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id 1964A38DDCC7;
 Wed, 13 Mar 2019 09:40:19 +0000 (UTC)
Subject: Re: [PATCH v2 06/16] KVM: PPC: Book3S HV: XIVE: add controls for the
 EQ configuration
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-7-clg@kaod.org> <20190226052429.GC28015@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <33aeb002-39b2-1015-9923-613781c08fd6@kaod.org>
Date: Wed, 13 Mar 2019 10:40:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190226052429.GC28015@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14991920211918031751
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrhedtgddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/26/19 6:24 AM, Paul Mackerras wrote:
> On Fri, Feb 22, 2019 at 12:28:30PM +0100, Cédric Le Goater wrote:
>> These controls will be used by the H_INT_SET_QUEUE_CONFIG and
>> H_INT_GET_QUEUE_CONFIG hcalls from QEMU. They will also be used to
>> restore the configuration of the XIVE EQs in the KVM device and to
>> capture the internal runtime state of the EQs. Both 'get' and 'set'
>> rely on an OPAL call to access from the XIVE interrupt controller the
>> EQ toggle bit and EQ index which are updated by the HW when event
>> notifications are enqueued in the EQ.
>>
>> The value of the guest physical address of the event queue is saved in
>> the XIVE internal xive_q structure for later use. That is when
>> migration needs to mark the EQ pages dirty to capture a consistent
>> memory state of the VM.
>>
>> To be noted that H_INT_SET_QUEUE_CONFIG does not require the extra
>> OPAL call setting the EQ toggle bit and EQ index to configure the EQ,
>> but restoring the EQ state will.
> 
> [snip]
> 
>> +/* Layout of 64-bit eq attribute */
>> +#define KVM_XIVE_EQ_PRIORITY_SHIFT	0
>> +#define KVM_XIVE_EQ_PRIORITY_MASK	0x7
>> +#define KVM_XIVE_EQ_SERVER_SHIFT	3
>> +#define KVM_XIVE_EQ_SERVER_MASK		0xfffffff8ULL
>> +
>> +/* Layout of 64-bit eq attribute values */
>> +struct kvm_ppc_xive_eq {
>> +	__u32 flags;
>> +	__u32 qsize;
>> +	__u64 qpage;
>> +	__u32 qtoggle;
>> +	__u32 qindex;
>> +	__u8  pad[40];
>> +};
> 
> This is confusing.  What's the difference between an "eq attribute"
> and an "eq attribute value"?  Is the first actually a queue index or
> a queue identifier?

The "attribute" qualifier comes from the {get,set,has}_addr methods 
of the KVM device. But it is not a well chosen name for the group 
KVM_DEV_XIVE_GRP_EQ_CONFIG.

I should be using "eq identifier" and "eq values" or "eq state". 

> Also, the kvm_ppc_xive_eq is not 64 bits, so the comment above it is
> wrong.  Maybe you meant "64-byte"?

That was a bad copy paste. I have padded the structure to twice the size
of the XIVE END (the XIVE EQ descriptor in HW) which size is 32 bytes. 
I thought that one extra u64 was not enough room for future.

> 
> [snip]
> 
>> +	page = gfn_to_page(kvm, gpa_to_gfn(kvm_eq.qpage));
>> +	if (is_error_page(page)) {
>> +		pr_warn("Couldn't get guest page for %llx!\n", kvm_eq.qpage);
>> +		return -ENOMEM;
>> +	}
>> +	qaddr = page_to_virt(page) + (kvm_eq.qpage & ~PAGE_MASK);
> 
> Isn't this assuming that we can map the whole queue with a single
> gfn_to_page?  That would only be true if kvm_eq.qsize <= PAGE_SHIFT.
> What happens if kvm_eq.qsize > PAGE_SHIFT?

Ah yes. Theoretically, it should not happen because we only advertise
64K in the DT for the moment. I should at least add a check. So I will 
change the helper xive_native_validate_queue_size() to return -EINVAL
for other page sizes.

Do you think it would be complex to support XIVE EQs using a page larger 
than the default one on the guest ? 

Thanks,

C.

> 
> Paul.
> 

