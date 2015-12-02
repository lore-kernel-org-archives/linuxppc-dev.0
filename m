Return-Path: <geyslan@gmail.com>
Received: from mail-vk0-x22e.google.com (mail-vk0-x22e.google.com
 [IPv6:2607:f8b0:400c:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A63F21A000C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 12:11:16 +1100 (AEDT)
Received: by vkha189 with SMTP id a189so15641257vkh.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Dec 2015 17:11:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <878u5dk7si.fsf@gamma.ozlabs.ibm.com>
References: <1449013410-19103-1-git-send-email-geyslan@gmail.com>
 <878u5dk7si.fsf@gamma.ozlabs.ibm.com>
Date: Tue, 1 Dec 2015 22:11:13 -0300
Message-ID: <CAGG-pUR7XPpYXVCg4wj_NY6ztTFTNsAVLEp+AsUL18gnTNqJjg@mail.gmail.com>
Subject: Re: [PATCH] kvm: remove unused variable 'vcpu_book3s'
From: "Geyslan G. Bem" <geyslan@gmail.com>
To: Daniel Axtens <dja@axtens.net>
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2015-12-01 21:34 GMT-03:00 Daniel Axtens <dja@axtens.net>:
> "Geyslan G. Bem" <geyslan@gmail.com> writes:
>
>> The vcpu_book3s struct is assigned but never used. So remove it.
>
> Just out of interest, how did you find this? Compiler warning? Static
> analysis? Manual inspection?

Sorry, I should have done the patch self contained. I caught it
through static analysis (cppcheck).

>
> Thanks in advance!

You're welcome.

>
> Regards,
> Daniel
>
>>
>> Signed-off-by: Geyslan G. Bem <geyslan@gmail.com>
>> ---
>>  arch/powerpc/kvm/book3s_64_mmu.c | 3 ---
>>  1 file changed, 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
>> index 774a253..9bf7031 100644
>> --- a/arch/powerpc/kvm/book3s_64_mmu.c
>> +++ b/arch/powerpc/kvm/book3s_64_mmu.c
>> @@ -377,15 +377,12 @@ no_seg_found:
>>
>>  static void kvmppc_mmu_book3s_64_slbmte(struct kvm_vcpu *vcpu, u64 rs, u64 rb)
>>  {
>> -     struct kvmppc_vcpu_book3s *vcpu_book3s;
>>       u64 esid, esid_1t;
>>       int slb_nr;
>>       struct kvmppc_slb *slbe;
>>
>>       dprintk("KVM MMU: slbmte(0x%llx, 0x%llx)\n", rs, rb);
>>
>> -     vcpu_book3s = to_book3s(vcpu);
>> -
>>       esid = GET_ESID(rb);
>>       esid_1t = GET_ESID_1T(rb);
>>       slb_nr = rb & 0xfff;
>> --
>> 2.6.2
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev



-- 
Regards,

Geyslan G. Bem
hackingbits.com
