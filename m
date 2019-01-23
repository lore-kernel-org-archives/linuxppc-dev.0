Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7EDC282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 16:59:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72EBB2184C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 16:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72EBB2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43lBN16Zq8zDqJt
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 03:59:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.251.53; helo=1.mo178.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 1.mo178.mail-out.ovh.net (1.mo178.mail-out.ovh.net
 [178.33.251.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43lBKw33HmzDqH4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 03:57:39 +1100 (AEDT)
Received: from player771.ha.ovh.net (unknown [10.109.160.46])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 376C344E20
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 17:48:26 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player771.ha.ovh.net (Postfix) with ESMTPSA id 6F0451F4F77D;
 Wed, 23 Jan 2019 16:48:18 +0000 (UTC)
Subject: Re: [PATCH 06/19] KVM: PPC: Book3S HV: add a GET_ESB_FD control to
 the XIVE native device
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-7-clg@kaod.org> <20190122050952.GD15124@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0659e143-d43d-75e8-4dbb-c8dea9a08369@kaod.org>
Date: Wed, 23 Jan 2019 17:48:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122050952.GD15124@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11157949554703240071
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledriedtgdelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 1/22/19 6:09 AM, Paul Mackerras wrote:
> On Mon, Jan 07, 2019 at 07:43:18PM +0100, Cédric Le Goater wrote:
>> This will let the guest create a memory mapping to expose the ESB MMIO
>> regions used to control the interrupt sources, to trigger events, to
>> EOI or to turn off the sources.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/include/uapi/asm/kvm.h   |  4 ++
>>  arch/powerpc/kvm/book3s_xive_native.c | 97 +++++++++++++++++++++++++++
>>  2 files changed, 101 insertions(+)
>>
>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
>> index 8c876c166ef2..6bb61ba141c2 100644
>> --- a/arch/powerpc/include/uapi/asm/kvm.h
>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
>> @@ -675,4 +675,8 @@ struct kvm_ppc_cpu_char {
>>  #define  KVM_XICS_PRESENTED		(1ULL << 43)
>>  #define  KVM_XICS_QUEUED		(1ULL << 44)
>>  
>> +/* POWER9 XIVE Native Interrupt Controller */
>> +#define KVM_DEV_XIVE_GRP_CTRL		1
>> +#define   KVM_DEV_XIVE_GET_ESB_FD	1
>> +
>>  #endif /* __LINUX_KVM_POWERPC_H */
>> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
>> index 115143e76c45..e20081f0c8d4 100644
>> --- a/arch/powerpc/kvm/book3s_xive_native.c
>> +++ b/arch/powerpc/kvm/book3s_xive_native.c
>> @@ -153,6 +153,85 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>>  	return rc;
>>  }
>>  
>> +static int xive_native_esb_fault(struct vm_fault *vmf)
>> +{
>> +	struct vm_area_struct *vma = vmf->vma;
>> +	struct kvmppc_xive *xive = vma->vm_file->private_data;
>> +	struct kvmppc_xive_src_block *sb;
>> +	struct kvmppc_xive_irq_state *state;
>> +	struct xive_irq_data *xd;
>> +	u32 hw_num;
>> +	u16 src;
>> +	u64 page;
>> +	unsigned long irq;
>> +
>> +	/*
>> +	 * Linux/KVM uses a two pages ESB setting, one for trigger and
>> +	 * one for EOI
>> +	 */
>> +	irq = vmf->pgoff / 2;
>> +
>> +	sb = kvmppc_xive_find_source(xive, irq, &src);
>> +	if (!sb) {
>> +		pr_err("%s: source %lx not found !\n", __func__, irq);
> 
> In general it's a bad idea to have a printk that userspace can trigger
> at will without any rate-limiting.  Is there a real reason why this
> printk is needed (and can't be pr_devel)?

yes. It should. The SIGBUS is enough to know what's going on. 

> 
>> +		return VM_FAULT_SIGBUS;
>> +	}
>> +
>> +	state = &sb->irq_state[src];
>> +	kvmppc_xive_select_irq(state, &hw_num, &xd);
>> +
>> +	arch_spin_lock(&sb->lock);
>> +
>> +	/*
>> +	 * first/even page is for trigger
>> +	 * second/odd page is for EOI and management.
>> +	 */
>> +	page = vmf->pgoff % 2 ? xd->eoi_page : xd->trig_page;
>> +	arch_spin_unlock(&sb->lock);
>> +
>> +	if (!page) {
>> +		pr_err("%s: acessing invalid ESB page for source %lx !\n",
>> +		       __func__, irq);
> 
> Does this represent a exceptional condition that userspace can't just
> trigger at will (i.e. it implies the presence of a kernel bug)?  If
> not then the same comment as above applies.

Not having an ESB page (trigger or EOI) implies that the xive_irq_data 
for the source is bogus. This probably deserves a WARN().

Thanks,

C. 

