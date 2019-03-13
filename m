Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535E5C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 08:47:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6A12173C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 08:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6A12173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44K58D5LNFzDqJc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 19:47:56 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 44K56T3ZlGzDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 19:46:22 +1100 (AEDT)
Received: from player786.ha.ovh.net (unknown [10.109.143.72])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 5B682EB044
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 09:46:18 +0100 (CET)
Received: from kaod.org (lfbn-1-2226-17.w90-76.abo.wanadoo.fr [90.76.48.17])
 (Authenticated sender: clg@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id 6F7EC3B75037;
 Wed, 13 Mar 2019 08:46:09 +0000 (UTC)
Subject: Re: [PATCH v2 06/16] KVM: PPC: Book3S HV: XIVE: add controls for the
 EQ configuration
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-7-clg@kaod.org> <20190225023955.GJ7668@umbus.fritz.box>
 <9e732140-b2c0-dfb7-d753-ba0ec7f3b930@kaod.org>
 <20190313040327.GK9881@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <badcd1dc-2eef-590e-b362-0d3dfdf52d34@kaod.org>
Date: Wed, 13 Mar 2019 09:46:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190313040327.GK9881@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14076563587772222343
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrgeelgdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

On 3/13/19 5:03 AM, David Gibson wrote:
> On Tue, Mar 12, 2019 at 06:00:38PM +0100, Cédric Le Goater wrote:
>> On 2/25/19 3:39 AM, David Gibson wrote:
>>> On Fri, Feb 22, 2019 at 12:28:30PM +0100, Cédric Le Goater wrote:
>>>> These controls will be used by the H_INT_SET_QUEUE_CONFIG and
>>>> H_INT_GET_QUEUE_CONFIG hcalls from QEMU. They will also be used to
>>>> restore the configuration of the XIVE EQs in the KVM device and to
>>>> capture the internal runtime state of the EQs. Both 'get' and 'set'
>>>> rely on an OPAL call to access from the XIVE interrupt controller the
>>>> EQ toggle bit and EQ index which are updated by the HW when event
>>>> notifications are enqueued in the EQ.
>>>>
>>>> The value of the guest physical address of the event queue is saved in
>>>> the XIVE internal xive_q structure for later use. That is when
>>>> migration needs to mark the EQ pages dirty to capture a consistent
>>>> memory state of the VM.
>>>>
>>>> To be noted that H_INT_SET_QUEUE_CONFIG does not require the extra
>>>> OPAL call setting the EQ toggle bit and EQ index to configure the EQ,
>>>> but restoring the EQ state will.
>>
>> I think we need to add some kind of flags to differentiate the hcall
>> H_INT_SET_QUEUE_CONFIG from the restore of the EQ. The hcall does
>> not need OPAL support call and this could help in the code
>> transition.
> 
> Hrm.  What's the actual difference in the semantics between the two
> cases.  

None. 

But we don't need to set the EQ state in the case of the HCALL and it's 
(very) practical to run guests with XIVE enabled without the OPAL support. 
The latter is the main reason clearly.

Thinking of it, I could test the EQ toggle bit and index passed to KVM 
and skip the OPAL call which restores the EQ state if they are zero. 
This is because I know that the OPAL call configuring the EQ resets them. 

That will do. No need for a flag.

> The guest shouldn't have awareness of whether or not OPAL is involved.

yes.

Thanks,

C. 

