Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1134C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 22:49:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA3520821
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 22:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA3520821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tjZC1nfSzDqLM
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 09:49:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=87.98.174.144; helo=16.mo5.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 25200 seconds by postgrey-1.36 at bilbo;
 Tue, 05 Feb 2019 09:47:20 AEDT
Received: from 16.mo5.mail-out.ovh.net (16.mo5.mail-out.ovh.net
 [87.98.174.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tjWr1XBKzDqGt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 09:47:17 +1100 (AEDT)
Received: from player797.ha.ovh.net (unknown [10.109.160.143])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id D0AF8219DA4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 16:40:01 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player797.ha.ovh.net (Postfix) with ESMTPSA id AB9842777E9B;
 Mon,  4 Feb 2019 15:39:51 +0000 (UTC)
Subject: Re: [PATCH 13/19] KVM: PPC: Book3S HV: add a SYNC control for the
 XIVE native migration
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-14-clg@kaod.org> <20190204051739.GF1927@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c40bc738-f54c-fe1f-ea74-b47928fefe74@kaod.org>
Date: Mon, 4 Feb 2019 16:39:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190204051739.GF1927@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6688126922938551175
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

On 2/4/19 6:17 AM, David Gibson wrote:
> On Mon, Jan 07, 2019 at 07:43:25PM +0100, Cédric Le Goater wrote:
>> When migration of a VM is initiated, a first copy of the RAM is
>> transferred to the destination before the VM is stopped. At that time,
>> QEMU needs to perform a XIVE quiesce sequence to stop the flow of
>> event notifications and stabilize the EQs. The sources are masked and
>> the XIVE IC is synced with the KVM ioctl KVM_DEV_XIVE_GRP_SYNC.
>>
> 
> Don't you also need to make sure the guests queue pages are marked
> dirty here, in case they were already migrated?

I have added an extra KVM service to mark the EQ pages dirty. That 
might be overkill as it seems you are suggesting.

C. 
 
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/include/uapi/asm/kvm.h   |  1 +
>>  arch/powerpc/kvm/book3s_xive_native.c | 32 +++++++++++++++++++++++++++
>>  2 files changed, 33 insertions(+)
>>
>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
>> index 6fc9660c5aec..f3b859223b80 100644
>> --- a/arch/powerpc/include/uapi/asm/kvm.h
>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
>> @@ -681,6 +681,7 @@ struct kvm_ppc_cpu_char {
>>  #define   KVM_DEV_XIVE_GET_TIMA_FD	2
>>  #define   KVM_DEV_XIVE_VC_BASE		3
>>  #define KVM_DEV_XIVE_GRP_SOURCES	2	/* 64-bit source attributes */
>> +#define KVM_DEV_XIVE_GRP_SYNC		3	/* 64-bit source attributes */
>>  
>>  /* Layout of 64-bit XIVE source attribute values */
>>  #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
>> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
>> index 4ca75aade069..a8052867afc1 100644
>> --- a/arch/powerpc/kvm/book3s_xive_native.c
>> +++ b/arch/powerpc/kvm/book3s_xive_native.c
>> @@ -459,6 +459,35 @@ static int kvmppc_xive_native_set_source(struct kvmppc_xive *xive, long irq,
>>  	return 0;
>>  }
>>  
>> +static int kvmppc_xive_native_sync(struct kvmppc_xive *xive, long irq, u64 addr)
>> +{
>> +	struct kvmppc_xive_src_block *sb;
>> +	struct kvmppc_xive_irq_state *state;
>> +	struct xive_irq_data *xd;
>> +	u32 hw_num;
>> +	u16 src;
>> +
>> +	pr_devel("%s irq=0x%lx\n", __func__, irq);
>> +
>> +	sb = kvmppc_xive_find_source(xive, irq, &src);
>> +	if (!sb)
>> +		return -ENOENT;
>> +
>> +	state = &sb->irq_state[src];
>> +
>> +	if (!state->valid)
>> +		return -ENOENT;
>> +
>> +	arch_spin_lock(&sb->lock);
>> +
>> +	kvmppc_xive_select_irq(state, &hw_num, &xd);
>> +	xive_native_sync_source(hw_num);
>> +	xive_native_sync_queue(hw_num);
>> +
>> +	arch_spin_unlock(&sb->lock);
>> +	return 0;
>> +}
>> +
>>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>>  				       struct kvm_device_attr *attr)
>>  {
>> @@ -474,6 +503,8 @@ static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>>  	case KVM_DEV_XIVE_GRP_SOURCES:
>>  		return kvmppc_xive_native_set_source(xive, attr->attr,
>>  						     attr->addr);
>> +	case KVM_DEV_XIVE_GRP_SYNC:
>> +		return kvmppc_xive_native_sync(xive, attr->attr, attr->addr);
>>  	}
>>  	return -ENXIO;
>>  }
>> @@ -511,6 +542,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
>>  		}
>>  		break;
>>  	case KVM_DEV_XIVE_GRP_SOURCES:
>> +	case KVM_DEV_XIVE_GRP_SYNC:
>>  		if (attr->attr >= KVMPPC_XIVE_FIRST_IRQ &&
>>  		    attr->attr < KVMPPC_XIVE_NR_IRQS)
>>  			return 0;
> 

