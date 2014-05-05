Return-Path: <chzigotzky@xenosoft.de>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.162])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 101C7140E3F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 07:23:40 +1000 (EST)
Message-ID: <53680150.3050603@xenosoft.de>
Date: Mon, 05 May 2014 23:23:28 +0200
From: Christian Zigotzky <chzigotzky@xenosoft.de>
MIME-Version: 1.0
To: Olof Johansson <olofj@google.com>, Alexander Graf <agraf@suse.de>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V4] POWERPC: BOOK3S: KVM: Use the saved dar value and
 generic make_dsisr
References: <1399224075-18041-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>	<536773C2.1070502@suse.de>	<87tx949u9d.fsf@linux.vnet.ibm.com>	<5367A39D.9080709@suse.de>
 <CALiw-2E222RXHK0drwaygb62hXT8F8KCG_AJ7OGKgNfL+Vj8dg@mail.gmail.com>
In-Reply-To: <CALiw-2E222RXHK0drwaygb62hXT8F8KCG_AJ7OGKgNfL+Vj8dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Am 05.05.14 16:57, schrieb Olof Johansson:
> [Now without HTML email -- it's what you get for cc:ing me at work
> instead of my upstream email :)]
>
> 2014-05-05 7:43 GMT-07:00 Alexander Graf <agraf@suse.de>:
>> On 05/05/2014 04:26 PM, Aneesh Kumar K.V wrote:
>>> Alexander Graf <agraf@suse.de> writes:
>>>
>>>> On 05/04/2014 07:21 PM, Aneesh Kumar K.V wrote:
>>>>> Although it's optional IBM POWER cpus always had DAR value set on
>>>>> alignment interrupt. So don't try to compute these values.
>>>>>
>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>>>> ---
>>>>> Changes from V3:
>>>>> * Use make_dsisr instead of checking feature flag to decide whether to use
>>>>>      saved dsisr or not
>>>>>
>>> ....
>>>
>>>>>     ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst)
>>>>>     {
>>>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>>>> +       return vcpu->arch.fault_dar;
>>>> How about PA6T and G5s?
>>>>
>>>>
>>> Paul mentioned that BOOK3S always had DAR value set on alignment
>>> interrupt. And the patch is to enable/collect correct DAR value when
>>> running with Little Endian PR guest. Now to limit the impact and to
>>> enable Little Endian PR guest, I ended up doing the conditional code
>>> only for book3s 64 for which we know for sure that we set DAR value.
>>
>> Yes, and I'm asking whether we know that this statement holds true for PA6T and G5 chips which I wouldn't consider IBM POWER. Since the G5 is at least developed by IBM, I'd assume its semantics here are similar to POWER4, but for PA6T I wouldn't be so sure.
>>
> Thanks for looking out for us, obviously IBM doesn't (based on the
> reply a minute ago).
>
> In the end, since there's been no work to enable KVM on PA6T, I'm not
> too worried. I guess it's one more thing to sort out (and check for)
> whenever someone does that.
>
> I definitely don't have cycles to deal with that myself at this time.
> I can help find hardware for someone who wants to, but even then I'm
> guessing the interest is pretty limited.
>
>
> -Olof
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
Just for info: "PR" KVM works great on my PA6T machine. I booted the 
Lubuntu 14.04 PowerPC live DVD on a QEMU virtual machine with "PR" KVM 
successfully. But Mac OS X Jaguar, Panther, and Tiger don't boot with 
KVM on Mac-on-Linux and QEMU. See 
http://forum.hyperion-entertainment.biz/viewtopic.php?f=35&t=1747.

-- Christian
