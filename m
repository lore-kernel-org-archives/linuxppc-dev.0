Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D026F1402C9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 00:51:12 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 6 May 2014 00:51:12 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9E6942BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 00:51:09 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s45EostK7471612
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 00:50:54 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s45Ep9l2005893
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 May 2014 00:51:09 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH V4] POWERPC: BOOK3S: KVM: Use the saved dar value and
 generic make_dsisr
In-Reply-To: <5367A39D.9080709@suse.de>
References: <1399224075-18041-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <536773C2.1070502@suse.de> <87tx949u9d.fsf@linux.vnet.ibm.com>
 <5367A39D.9080709@suse.de>
Date: Mon, 05 May 2014 20:20:58 +0530
Message-ID: <87fvko9t4d.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 paulus@samba.org, olofj@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 05/05/2014 04:26 PM, Aneesh Kumar K.V wrote:
>> Alexander Graf <agraf@suse.de> writes:
>>
>>> On 05/04/2014 07:21 PM, Aneesh Kumar K.V wrote:
>>>> Although it's optional IBM POWER cpus always had DAR value set on
>>>> alignment interrupt. So don't try to compute these values.
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>>> ---
>>>> Changes from V3:
>>>> * Use make_dsisr instead of checking feature flag to decide whether to use
>>>>     saved dsisr or not
>>>>
>> ....
>>
>>>>    ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst)
>>>>    {
>>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>>> +	return vcpu->arch.fault_dar;
>>> How about PA6T and G5s?
>>>
>>>
>> Paul mentioned that BOOK3S always had DAR value set on alignment
>> interrupt. And the patch is to enable/collect correct DAR value when
>> running with Little Endian PR guest. Now to limit the impact and to
>> enable Little Endian PR guest, I ended up doing the conditional code
>> only for book3s 64 for which we know for sure that we set DAR value.
>
> Yes, and I'm asking whether we know that this statement holds true for 
> PA6T and G5 chips which I wouldn't consider IBM POWER. Since the G5 is 
> at least developed by IBM, I'd assume its semantics here are similar to 
> POWER4, but for PA6T I wouldn't be so sure.

I will have to defer to Paul on that question. But that should not
prevent this patch from going upstream right ?

-aneesh
