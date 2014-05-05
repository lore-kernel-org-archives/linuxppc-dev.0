Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8A11E140E48
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 01:09:47 +1000 (EST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V4] POWERPC: BOOK3S: KVM: Use the saved dar value and
 generic make_dsisr
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <CALiw-2E222RXHK0drwaygb62hXT8F8KCG_AJ7OGKgNfL+Vj8dg@mail.gmail.com>
Date: Mon, 5 May 2014 17:09:35 +0200
Message-Id: <5939CD09-28F7-4741-AAE9-EE4E3928CD2D@suse.de>
References: <1399224075-18041-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <536773C2.1070502@suse.de> <87tx949u9d.fsf@linux.vnet.ibm.com>
 <5367A39D.9080709@suse.de>
 <CALiw-2E222RXHK0drwaygb62hXT8F8KCG_AJ7OGKgNfL+Vj8dg@mail.gmail.com>
To: Olof Johansson <olofj@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> Am 05.05.2014 um 16:57 schrieb Olof Johansson <olofj@google.com>:
>=20
> [Now without HTML email -- it's what you get for cc:ing me at work
> instead of my upstream email :)]
>=20
> 2014-05-05 7:43 GMT-07:00 Alexander Graf <agraf@suse.de>:
>>=20
>>> On 05/05/2014 04:26 PM, Aneesh Kumar K.V wrote:
>>>=20
>>> Alexander Graf <agraf@suse.de> writes:
>>>=20
>>>>> On 05/04/2014 07:21 PM, Aneesh Kumar K.V wrote:
>>>>>=20
>>>>> Although it's optional IBM POWER cpus always had DAR value set on
>>>>> alignment interrupt. So don't try to compute these values.
>>>>>=20
>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>>>> ---
>>>>> Changes from V3:
>>>>> * Use make_dsisr instead of checking feature flag to decide whether to=
 use
>>>>>    saved dsisr or not
>>> ....
>>>=20
>>>>>   ulong kvmppc_alignment_dar(struct kvm_vcpu *vcpu, unsigned int inst)=

>>>>>   {
>>>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>>>> +       return vcpu->arch.fault_dar;
>>>>=20
>>>> How about PA6T and G5s?
>>> Paul mentioned that BOOK3S always had DAR value set on alignment
>>> interrupt. And the patch is to enable/collect correct DAR value when
>>> running with Little Endian PR guest. Now to limit the impact and to
>>> enable Little Endian PR guest, I ended up doing the conditional code
>>> only for book3s 64 for which we know for sure that we set DAR value.
>>=20
>>=20
>> Yes, and I'm asking whether we know that this statement holds true for PA=
6T and G5 chips which I wouldn't consider IBM POWER. Since the G5 is at leas=
t developed by IBM, I'd assume its semantics here are similar to POWER4, but=
 for PA6T I wouldn't be so sure.
>=20
> Thanks for looking out for us, obviously IBM doesn't (based on the
> reply a minute ago).
>=20
> In the end, since there's been no work to enable KVM on PA6T, I'm not
> too worried. I guess it's one more thing to sort out (and check for)
> whenever someone does that.
>=20
> I definitely don't have cycles to deal with that myself at this time.
> I can help find hardware for someone who wants to, but even then I'm
> guessing the interest is pretty limited.

I know of at least 1 person who successfully runs PR KVM on a PA6T, so it's n=
either neglected nor non-working.

If you can get me access to a pa6t system I can easily check whether alignme=
nt interrupts generate dar and dsisr properly :).


Alex
