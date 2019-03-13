Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53973C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 11:04:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C0CA2177E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 11:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C0CA2177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44K89W6XF6zDqMX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 22:04:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.43.140; helo=5.mo179.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 5.mo179.mail-out.ovh.net (5.mo179.mail-out.ovh.net
 [46.105.43.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44K87Y3ZJyzDqC8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 22:02:32 +1100 (AEDT)
Received: from player687.ha.ovh.net (unknown [10.109.143.249])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id ECE8E11B26E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 09:35:04 +0100 (CET)
Received: from kaod.org (lfbn-1-2226-17.w90-76.abo.wanadoo.fr [90.76.48.17])
 (Authenticated sender: clg@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id D3D373959943;
 Wed, 13 Mar 2019 08:34:53 +0000 (UTC)
Subject: Re: [PATCH v2 03/16] KVM: PPC: Book3S HV: XIVE: introduce a new
 capability KVM_CAP_PPC_IRQ_XIVE
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-4-clg@kaod.org> <20190225043551.GA20501@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a736c1b9-6406-2afa-d126-d0073fcd096e@kaod.org>
Date: Wed, 13 Mar 2019 09:34:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225043551.GA20501@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13886849453406129031
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedutddrgeelgdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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

On 2/25/19 5:35 AM, Paul Mackerras wrote:
> On Fri, Feb 22, 2019 at 12:28:27PM +0100, Cédric Le Goater wrote:
>> The user interface exposes a new capability to let QEMU connect the
>> vCPU to the XIVE KVM device if required. The capability is only
>> advertised on a PowerNV Hypervisor as support for nested guests
>> (pseries KVM Hypervisor) is not yet available.
> 
> If a bisection happened to land on this commit, we would have KVM
> saying it had the ability to support guests using XIVE natively, but
> it wouldn't actually work since we don't have all the code that is in
> the following patches.

OK. I didn't think migration was a must-have for bisection. I will move
the enablement at end.

> Thus, in order to avoid breaking bisection, you should either add the
> capability now but have it always return false until the rest of the
> code is in place, or else defer the addition of the capability until
> the end of the patch series.

I will introduce the capability early in the patchset and return false
as you are proposing. It seems to be the best approach.

>> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
>> index 8c69af10f91d..a38a643a24dd 100644
>> --- a/arch/powerpc/kvm/powerpc.c
>> +++ b/arch/powerpc/kvm/powerpc.c
>> @@ -570,6 +570,12 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>>  	case KVM_CAP_PPC_GET_CPU_CHAR:
>>  		r = 1;
>>  		break;
>> +#ifdef CONFIG_KVM_XIVE
>> +	case KVM_CAP_PPC_IRQ_XIVE:
>> +		/* only for PowerNV */
>> +		r = !!cpu_has_feature(CPU_FTR_HVMODE);
> 
> Shouldn't this be r = xive_enabled() && !!cpu_has_feature(CPU_FTR_HVMODE)

yes. we need the '__xive_enabled' toggle to be set also :/ 

It can set to off with the "xive=off" on the command line and on old P9 
skiboot. That could be simplified one day.

> (or alternatively r = xics_on_xive(), though that would be confusing
> to the reader)?

This is correct. I didn't want to use the xics_on_xive() which is not
the capability we are activating. 

I will keep the open-coded version.

> As it stands this would report true on POWER8, unless I'm missing
> something.

Ah yes. I forgot this combination also. 

This should not be too complex to fix.

Thanks,

C.
