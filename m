Return-Path: <SRS0=6cb3=P7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7845EC282C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 16:26:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE0621726
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Jan 2019 16:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE0621726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43l9dX04PYzDqJf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Jan 2019 03:26:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.251.173; helo=1.mo69.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 1.mo69.mail-out.ovh.net (1.mo69.mail-out.ovh.net
 [178.33.251.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43l9bd6XvNzDqJf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jan 2019 03:24:27 +1100 (AEDT)
Received: from player786.ha.ovh.net (unknown [10.109.160.76])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id DA28B38C74
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jan 2019 17:24:23 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id E974720F6E5E;
 Wed, 23 Jan 2019 16:24:13 +0000 (UTC)
Subject: Re: [PATCH 03/19] KVM: PPC: Book3S HV: check the IRQ controller type
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-4-clg@kaod.org> <20190122045642.GB15124@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <29eab965-3e98-714c-7686-f6caa59f3672@kaod.org>
Date: Wed, 23 Jan 2019 17:24:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190122045642.GB15124@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10752062637088213895
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledriedtgdekkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
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

On 1/22/19 5:56 AM, Paul Mackerras wrote:
> On Mon, Jan 07, 2019 at 07:43:15PM +0100, Cédric Le Goater wrote:
>> We will have different KVM devices for interrupts, one for the
>> XICS-over-XIVE mode and one for the XIVE native exploitation
>> mode. Let's add some checks to make sure we are not mixing the
>> interfaces in KVM.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/kvm/book3s_xive.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
>> index f78d002f0fe0..8a4fa45f07f8 100644
>> --- a/arch/powerpc/kvm/book3s_xive.c
>> +++ b/arch/powerpc/kvm/book3s_xive.c
>> @@ -819,6 +819,9 @@ u64 kvmppc_xive_get_icp(struct kvm_vcpu *vcpu)
>>  {
>>  	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
>>  
>> +	if (!kvmppc_xics_enabled(vcpu))
>> +		return -EPERM;
>> +
>>  	if (!xc)
>>  		return 0;
>>  
>> @@ -835,6 +838,9 @@ int kvmppc_xive_set_icp(struct kvm_vcpu *vcpu, u64 icpval)
>>  	u8 cppr, mfrr;
>>  	u32 xisr;
>>  
>> +	if (!kvmppc_xics_enabled(vcpu))
>> +		return -EPERM;
>> +
>>  	if (!xc || !xive)
>>  		return -ENOENT;
> 
> I can't see how these new checks could ever trigger in the code as it
> stands.  Is there a way at present? 

It would require some custom QEMU doing silly things : create the XICS 
KVM device, and then call kvm_get_one_reg(KVM_REG_PPC_ICP_STATE) or 
kvm_set_one_reg(icp->cs, KVM_REG_PPC_ICP_STATE) without connecting the
vCPU to its presenter. 

Today, you get a ENOENT.

> Do following patches ever add a path where the new checks could trigger, 
> or is this just an excess of caution? 

With the following patches, QEMU could to do something even more silly,
which is to mix the interrupt mode interfaces : create a KVM XICS device    
and call KVM CPU ioctls of the KVM XIVE device, or the opposite.  

> (Your patch description should ideally have answered these questions > for me.)

Yes. I also think that I introduced this patch to early in the series.
It make more sense when the XICS and the XIVE KVM devices are available.  

Thanks,

C.
