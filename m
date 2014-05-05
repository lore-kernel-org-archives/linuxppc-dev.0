Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4886C140307
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 01:03:17 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 5 May 2014 20:33:15 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 857FBE0044
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 20:33:37 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s45F3FQh6619484
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 20:33:16 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s45F3BSQ006493
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 May 2014 20:33:12 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Olof Johansson <olofj@google.com>, Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH V4] POWERPC: BOOK3S: KVM: Use the saved dar value and
 generic make_dsisr
In-Reply-To: <CALiw-2G2LL55WfZpDTrGr198W4uokcoZn5JxYNVYHbt4Bu_DhA@mail.gmail.com>
References: <1399224075-18041-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <536773C2.1070502@suse.de> <87tx949u9d.fsf@linux.vnet.ibm.com>
 <5367A39D.9080709@suse.de>
 <CALiw-2G2LL55WfZpDTrGr198W4uokcoZn5JxYNVYHbt4Bu_DhA@mail.gmail.com>
Date: Mon, 05 May 2014 20:33:11 +0530
Message-ID: <87d2fs9sk0.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Olof Johansson <olofj@google.com> writes:

> 2014-05-05 7:43 GMT-07:00 Alexander Graf <agraf@suse.de>:
>
>> On 05/05/2014 04:26 PM, Aneesh Kumar K.V wrote:
>>
>>> Alexander Graf <agraf@suse.de> writes:
>>>
>>>  On 05/04/2014 07:21 PM, Aneesh Kumar K.V wrote:
>>>>
>>>>> Although it's optional IBM POWER cpus always had DAR value set on
>>>>> alignment interrupt. So don't try to compute these values.
>>>>>
>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>>>> ---
>>>>> Changes from V3:
>>>>> * Use make_dsisr instead of checking feature flag to decide whether to
>>>>> use
>>>>>     saved dsisr or not
>>>>>
>>>>>  ....
>>>
>>>     ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst)
>>>>>    {
>>>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>>>> +       return vcpu->arch.fault_dar;
>>>>>
>>>> How about PA6T and G5s?
>>>>
>>>>
>>>>  Paul mentioned that BOOK3S always had DAR value set on alignment
>>> interrupt. And the patch is to enable/collect correct DAR value when
>>> running with Little Endian PR guest. Now to limit the impact and to
>>> enable Little Endian PR guest, I ended up doing the conditional code
>>> only for book3s 64 for which we know for sure that we set DAR value.
>>>
>>
>> Yes, and I'm asking whether we know that this statement holds true for
>> PA6T and G5 chips which I wouldn't consider IBM POWER. Since the G5 is at
>> least developed by IBM, I'd assume its semantics here are similar to
>> POWER4, but for PA6T I wouldn't be so sure.
>>
>>
> Thanks for looking out for us, obviously IBM doesn't (based on the reply a
> minute ago).

The reason I deferred the question to Paul is really because I don't
know enough about PA6T and G5 to comment. I intentionally restricted the
changes to BOOK3S_64 because I wanted to make sure I don't break
anything else. It is in no way to hint that others don't care.

-aneesh
