Return-Path: <kernelfans@gmail.com>
Received: from mail-qc0-x229.google.com (mail-qc0-x229.google.com
 [IPv6:2607:f8b0:400d:c01::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 605162C00BC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 17:02:11 +1100 (EST)
Received: by mail-qc0-f169.google.com with SMTP id x12so5578963qcv.14
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Nov 2013 22:02:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131106050418.GD14842@drongo>
References: <1383637364-14691-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1383637364-14691-2-git-send-email-pingfank@linux.vnet.ibm.com>
 <20131106050418.GD14842@drongo>
Date: Wed, 6 Nov 2013 14:02:07 +0800
Message-ID: <CAFgQCTsxEAqMDt=zfFMhEG2CZ6G=QpH+OsPvJkvjFU7GkDOcXQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc/kvm: fix rare but potential deadlock scene
From: Liu ping fan <kernelfans@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 6, 2013 at 1:04 PM, Paul Mackerras <paulus@samba.org> wrote:
> On Tue, Nov 05, 2013 at 03:42:43PM +0800, Liu Ping Fan wrote:
>> Since kvmppc_hv_find_lock_hpte() is called from both virtmode and
>> realmode, so it can trigger the deadlock.
>
> Good catch, we should have preemption disabled while ever we have a
> HPTE locked.
>
>> @@ -474,8 +474,10 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
>>       }
>>
>>       /* Find the HPTE in the hash table */
>> +     preempt_disable();
>>       index = kvmppc_hv_find_lock_hpte(kvm, eaddr, slb_v,
>>                                        HPTE_V_VALID | HPTE_V_ABSENT);
>> +     preempt_enable();
>
> Which means we need to add the preempt_enable after unlocking the
> HPTE, not here.
>
Yes. Sorry, but I am not sure about whether we can call
preempt_disable/enable() in realmode. I think since thread_info is
allocated with linear address, so we can use preempt_disable/enable()
inside kvmppc_hv_find_lock_hpte(), right?

Thanks and regards,
Pingfan

> Regards,
> Paul.
