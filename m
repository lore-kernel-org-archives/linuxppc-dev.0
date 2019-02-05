Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189A6C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 13:41:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C7D20844
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 13:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C7D20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v5Mg36B5zDqHk
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 00:41:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.72.238; helo=9.mo177.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 9.mo177.mail-out.ovh.net (9.mo177.mail-out.ovh.net
 [46.105.72.238])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v5KX5jR0zDqD5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 00:39:43 +1100 (AEDT)
Received: from player728.ha.ovh.net (unknown [10.109.159.152])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 5AEC0DC746
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 14:39:39 +0100 (CET)
Received: from kaod.org (gbibp9ph1--yellowicen11.emea.ibm.com [195.212.29.58])
 (Authenticated sender: clg@kaod.org)
 by player728.ha.ovh.net (Postfix) with ESMTPSA id EA0B924CBF0C;
 Tue,  5 Feb 2019 13:39:29 +0000 (UTC)
Subject: Re: [PATCH 09/19] KVM: PPC: Book3S HV: add a SET_SOURCE control to
 the XIVE native device
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-10-clg@kaod.org> <20190204045751.GD1927@umbus.fritz.box>
 <40c8dc36-0d54-1e66-d766-5580c19ae8fd@kaod.org>
 <20190205053554.GI22661@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <62898e33-81fd-b01f-e578-c753a30070d0@kaod.org>
Date: Tue, 5 Feb 2019 14:39:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205053554.GI22661@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10528008556687690631
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrkeeigdehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/5/19 6:35 AM, David Gibson wrote:
> On Mon, Feb 04, 2019 at 08:07:20PM +0100, Cédric Le Goater wrote:
>> On 2/4/19 5:57 AM, David Gibson wrote:
>>> On Mon, Jan 07, 2019 at 07:43:21PM +0100, Cédric Le Goater wrote:
> [snip]
>>>> +		sb = kvmppc_xive_create_src_block(xive, irq);
>>>> +		if (!sb) {
>>>> +			pr_err("Failed to create block...\n");
>>>> +			return -ENOMEM;
>>>> +		}
>>>> +	}
>>>> +	state = &sb->irq_state[idx];
>>>> +
>>>> +	if (get_user(val, ubufp)) {
>>>> +		pr_err("fault getting user info !\n");
>>>> +		return -EFAULT;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * If the source doesn't already have an IPI, allocate
>>>> +	 * one and get the corresponding data
>>>> +	 */
>>>> +	if (!state->ipi_number) {
>>>> +		state->ipi_number = xive_native_alloc_irq();
>>>> +		if (state->ipi_number == 0) {
>>>> +			pr_err("Failed to allocate IRQ !\n");
>>>> +			return -ENOMEM;
>>>> +		}
>>>
>>> Am I right in thinking this is the point at which a specific guest irq
>>> number gets bound to a specific host irq number?
>>
>> yes. the XIVE IRQ state caches this information and 'state' should be 
>> protected before being assigned, indeed ... The XICS-over-XIVE device
>> also has the same race issue.
>>
>> It's not showing because where initializing the KVM device sequentially
>> from QEMU and only once.
> 
> Ok.
> 
> So, for the passthrough case, what's the point at which we know that a
> particular guest interrupt needs to be bound to a specific real
> hardware interrupt, rather than a generic IPI?

when the guest driver requests MSIs, VFIO requests a mapping of the 
HW irqs in the guest IRQ space. This is very briefly said as VFIO is 
a huge framework. 

Patch 18 adds some initial support to handle the ESB pages but this 
should be done at the QEMU level.

C. 
