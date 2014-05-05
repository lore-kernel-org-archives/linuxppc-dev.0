Return-Path: <olofj@google.com>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C585614132B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 01:06:52 +1000 (EST)
Received: by mail-wg0-f49.google.com with SMTP id m15so2346952wgh.20
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 May 2014 08:06:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87d2fs9sk0.fsf@linux.vnet.ibm.com>
References: <1399224075-18041-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <536773C2.1070502@suse.de> <87tx949u9d.fsf@linux.vnet.ibm.com>
 <5367A39D.9080709@suse.de>
 <CALiw-2G2LL55WfZpDTrGr198W4uokcoZn5JxYNVYHbt4Bu_DhA@mail.gmail.com>
 <87d2fs9sk0.fsf@linux.vnet.ibm.com>
Date: Mon, 5 May 2014 08:06:48 -0700
Message-ID: <CALiw-2ED5AFuZjUkHXsxCWe17+2_kxoDBT8J_sj_NU7PaUtKUA@mail.gmail.com>
Subject: Re: [PATCH V4] POWERPC: BOOK3S: KVM: Use the saved dar value and
 generic make_dsisr
From: Olof Johansson <olofj@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2014-05-05 8:03 GMT-07:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
> Olof Johansson <olofj@google.com> writes:
>
>> 2014-05-05 7:43 GMT-07:00 Alexander Graf <agraf@suse.de>:
>>
>>> On 05/05/2014 04:26 PM, Aneesh Kumar K.V wrote:
>>>
>>>> Alexander Graf <agraf@suse.de> writes:
>>>>
>>>>  On 05/04/2014 07:21 PM, Aneesh Kumar K.V wrote:
>>>>>
>>>>>> Although it's optional IBM POWER cpus always had DAR value set on
>>>>>> alignment interrupt. So don't try to compute these values.
>>>>>>
>>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>>>>> ---
>>>>>> Changes from V3:
>>>>>> * Use make_dsisr instead of checking feature flag to decide whether to
>>>>>> use
>>>>>>     saved dsisr or not
>>>>>>
>>>>>>  ....
>>>>
>>>>     ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst)
>>>>>>    {
>>>>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>>>>> +       return vcpu->arch.fault_dar;
>>>>>>
>>>>> How about PA6T and G5s?
>>>>>
>>>>>
>>>>>  Paul mentioned that BOOK3S always had DAR value set on alignment
>>>> interrupt. And the patch is to enable/collect correct DAR value when
>>>> running with Little Endian PR guest. Now to limit the impact and to
>>>> enable Little Endian PR guest, I ended up doing the conditional code
>>>> only for book3s 64 for which we know for sure that we set DAR value.
>>>>
>>>
>>> Yes, and I'm asking whether we know that this statement holds true for
>>> PA6T and G5 chips which I wouldn't consider IBM POWER. Since the G5 is at
>>> least developed by IBM, I'd assume its semantics here are similar to
>>> POWER4, but for PA6T I wouldn't be so sure.
>>>
>>>
>> Thanks for looking out for us, obviously IBM doesn't (based on the reply a
>> minute ago).
>
> The reason I deferred the question to Paul is really because I don't
> know enough about PA6T and G5 to comment. I intentionally restricted the
> changes to BOOK3S_64 because I wanted to make sure I don't break
> anything else. It is in no way to hint that others don't care.

Ah, I see -- the disconnect is that you don't think PA6T and 970 are
64-bit book3s CPUs. They are.


-Olof
