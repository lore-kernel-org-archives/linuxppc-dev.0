Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60562C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 16:14:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E63120815
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 16:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E63120815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tXq21ysVzDqKM
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 03:14:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=87.98.171.146; helo=9.mo6.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 1803 seconds by postgrey-1.36 at bilbo;
 Tue, 05 Feb 2019 03:13:24 AEDT
Received: from 9.mo6.mail-out.ovh.net (9.mo6.mail-out.ovh.net [87.98.171.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tXnJ36HLzDqDd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 03:13:23 +1100 (AEDT)
Received: from player157.ha.ovh.net (unknown [10.109.146.137])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 47EEA1AD306
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 16:37:46 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 8BCA62485E16;
 Mon,  4 Feb 2019 15:37:38 +0000 (UTC)
Subject: Re: [PATCH 12/19] KVM: PPC: Book3S HV: record guest queue page address
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-13-clg@kaod.org> <20190204051548.GE1927@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <68a7d46b-bbfb-f3c6-70de-88b81c4291b9@kaod.org>
Date: Mon, 4 Feb 2019 16:37:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204051548.GE1927@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6650127802159369095
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrkeeggdejlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 2/4/19 6:15 AM, David Gibson wrote:
> On Mon, Jan 07, 2019 at 07:43:24PM +0100, Cédric Le Goater wrote:
>> The guest physical address of the event queue will be part of the
>> state to transfer in the migration. Cache its value when the queue is
>> configured, it will save us an OPAL call.
> 
> That doesn't sound like a very compelling case - migration is already
> a hundreds of milliseconds type operation, I wouldn't expect a few
> extra OPAL calls to be an issue.

OK. I don't think this is much a problem anyhow. Let's call OPAL.

C. 

 
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/include/asm/xive.h       | 2 ++
>>  arch/powerpc/kvm/book3s_xive_native.c | 4 ++++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
>> index 7a7aa22d8258..e90c3c5d9533 100644
>> --- a/arch/powerpc/include/asm/xive.h
>> +++ b/arch/powerpc/include/asm/xive.h
>> @@ -74,6 +74,8 @@ struct xive_q {
>>  	u32			esc_irq;
>>  	atomic_t		count;
>>  	atomic_t		pending_count;
>> +	u64			guest_qpage;
>> +	u32			guest_qsize;
>>  };
>>  
>>  /* Global enable flags for the XIVE support */
>> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
>> index 35d806740c3a..4ca75aade069 100644
>> --- a/arch/powerpc/kvm/book3s_xive_native.c
>> +++ b/arch/powerpc/kvm/book3s_xive_native.c
>> @@ -708,6 +708,10 @@ static int kvmppc_h_int_set_queue_config(struct kvm_vcpu *vcpu,
>>  	}
>>  	qaddr = page_to_virt(page) + (qpage & ~PAGE_MASK);
>>  
>> +	/* Backup queue page address and size for migration */
>> +	q->guest_qpage = qpage;
>> +	q->guest_qsize = qsize;
>> +
>>  	rc = xive_native_configure_queue(xc->vp_id, q, priority,
>>  					 (__be32 *) qaddr, qsize, true);
>>  	if (rc) {
> 

