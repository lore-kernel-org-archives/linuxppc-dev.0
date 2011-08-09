Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CF17DB70D1
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 02:46:42 +1000 (EST)
Message-ID: <4E41646C.1070500@suse.de>
Date: Tue, 09 Aug 2011 18:46:36 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 07/10] KVM: PPC: Add PAPR hypercall code for PR mode
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
	<1312907508-14599-8-git-send-email-agraf@suse.de>
	<4E416315.2080800@redhat.com>
In-Reply-To: <4E416315.2080800@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/09/2011 06:40 PM, Avi Kivity wrote:
> On 08/09/2011 07:31 PM, Alexander Graf wrote:
>> When running a PAPR guest, we need to handle a few hypercalls in 
>> kernel space,
>> most prominently the page table invalidation (to sync the shadows).
>>
>> So this patch adds handling for a few PAPR hypercalls to PR mode KVM. 
>> I tried
>> to share the code with HV mode, but it ended up being a lot easier 
>> this way
>> around, as the two differ too much in those details.
>>
>>
>> +++ b/arch/powerpc/kvm/book3s_pr_papr.c
>> @@ -0,0 +1,158 @@
>> +/*
>> + * Copyright (C) 2011. Freescale Inc. All rights reserved.
>> + *
>> + * Authors:
>> + *    Alexander Graf<agraf@suse.de>
>> + *    Paul Mackerras<paulus@samba.org>
>> + *
>> + * Description:
>> + *
>> + * Hypercall handling for running PAPR guests in PR KVM on Book 3S
>> + * processors.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License, version 2, as
>> + * published by the Free Software Foundation.
>> + */
>
> Copyright freescale, authors Paul and yourself?

Yeah, I'm reasonably clueless when it comes to legal stuff. This code is 
inspired by Paul's, but is mostly rewritten since it's so tied into the 
virtual MMU. What would the copyright be in that case?

>
>> +
>> +static unsigned long get_pteg_addr(struct kvm_vcpu *vcpu, long 
>> pte_index)
>> +{
>> +    struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
>> +    unsigned long pteg_addr;
>> +
>> +    pte_index<<= 4;
>> +    pte_index&= ((1<<  ((vcpu_book3s->sdr1&  0x1f) + 11)) - 1)<<  7 
>> | 0x70;
>> +        pteg_addr = vcpu_book3s->sdr1&  0xfffffffffffc0000ULL;
>> +    pteg_addr |= pte_index;
>> +
>> +    return pteg_addr;
>> +}
>
> Evil space crept in.


Oh noez! Fixed it :)


Alex
