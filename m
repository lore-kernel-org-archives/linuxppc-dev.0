Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1A6E7140A99
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 00:43:45 +1000 (EST)
Message-ID: <5367A39D.9080709@suse.de>
Date: Mon, 05 May 2014 16:43:41 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V4] POWERPC: BOOK3S: KVM: Use the saved dar value and
 generic make_dsisr
References: <1399224075-18041-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <536773C2.1070502@suse.de> <87tx949u9d.fsf@linux.vnet.ibm.com>
In-Reply-To: <87tx949u9d.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 05/05/2014 04:26 PM, Aneesh Kumar K.V wrote:
> Alexander Graf <agraf@suse.de> writes:
>
>> On 05/04/2014 07:21 PM, Aneesh Kumar K.V wrote:
>>> Although it's optional IBM POWER cpus always had DAR value set on
>>> alignment interrupt. So don't try to compute these values.
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>> ---
>>> Changes from V3:
>>> * Use make_dsisr instead of checking feature flag to decide whether to use
>>>     saved dsisr or not
>>>
> ....
>
>>>    ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst)
>>>    {
>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>> +	return vcpu->arch.fault_dar;
>> How about PA6T and G5s?
>>
>>
> Paul mentioned that BOOK3S always had DAR value set on alignment
> interrupt. And the patch is to enable/collect correct DAR value when
> running with Little Endian PR guest. Now to limit the impact and to
> enable Little Endian PR guest, I ended up doing the conditional code
> only for book3s 64 for which we know for sure that we set DAR value.

Yes, and I'm asking whether we know that this statement holds true for 
PA6T and G5 chips which I wouldn't consider IBM POWER. Since the G5 is 
at least developed by IBM, I'd assume its semantics here are similar to 
POWER4, but for PA6T I wouldn't be so sure.


Alex
