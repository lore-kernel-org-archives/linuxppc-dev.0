Return-Path: <kernelfans@gmail.com>
Received: from mail-qc0-x22f.google.com (mail-qc0-x22f.google.com
 [IPv6:2607:f8b0:400d:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7BB672C0335
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 13:36:09 +1100 (EST)
Received: by mail-qc0-f175.google.com with SMTP id e16so373150qcx.20
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Nov 2013 18:36:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131106111841.GA22605@iris.ozlabs.ibm.com>
References: <1383637364-14691-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1383637364-14691-2-git-send-email-pingfank@linux.vnet.ibm.com>
 <20131106050418.GD14842@drongo>
 <CAFgQCTsxEAqMDt=zfFMhEG2CZ6G=QpH+OsPvJkvjFU7GkDOcXQ@mail.gmail.com>
 <20131106111841.GA22605@iris.ozlabs.ibm.com>
Date: Thu, 7 Nov 2013 10:36:05 +0800
Message-ID: <CAFgQCTvpLR8nZFeJkeMiAeAz3FX-VMikJpo9YF3Vq=MMDkyUHQ@mail.gmail.com>
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

On Wed, Nov 6, 2013 at 7:18 PM, Paul Mackerras <paulus@samba.org> wrote:
> On Wed, Nov 06, 2013 at 02:02:07PM +0800, Liu ping fan wrote:
>> On Wed, Nov 6, 2013 at 1:04 PM, Paul Mackerras <paulus@samba.org> wrote:
>> > On Tue, Nov 05, 2013 at 03:42:43PM +0800, Liu Ping Fan wrote:
>> >> Since kvmppc_hv_find_lock_hpte() is called from both virtmode and
>> >> realmode, so it can trigger the deadlock.
>> >
>> > Good catch, we should have preemption disabled while ever we have a
>> > HPTE locked.
>> >
>> >> @@ -474,8 +474,10 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
>> >>       }
>> >>
>> >>       /* Find the HPTE in the hash table */
>> >> +     preempt_disable();
>> >>       index = kvmppc_hv_find_lock_hpte(kvm, eaddr, slb_v,
>> >>                                        HPTE_V_VALID | HPTE_V_ABSENT);
>> >> +     preempt_enable();
>> >
>> > Which means we need to add the preempt_enable after unlocking the
>> > HPTE, not here.
>> >
>> Yes. Sorry, but I am not sure about whether we can call
>> preempt_disable/enable() in realmode. I think since thread_info is
>> allocated with linear address, so we can use preempt_disable/enable()
>> inside kvmppc_hv_find_lock_hpte(), right?
>
> Your analysis correctly pointed out that we can get a deadlock if we
> can be preempted while holding a lock on a HPTE.  That means that we
> have to disable preemption before taking an HPTE lock and keep it
> disabled until after we unlock the HPTE.  Since the point of
> kvmppc_hv_find_lock_hpte() is to lock the HPTE and return with it
> locked, we can't have the preempt_enable() inside it.  The
> preempt_enable() has to come after we have unlocked the HPTE.  That is
> also why we can't have the preempt_enable() where your patch put it;
> it needs to be about 9 lines further down, after the statement
> hptep[0] = v.  (We also need to make sure to re-enable preemption in
> the index < 0 case.)
>
Oh, yes, will fix like what you said. My attention is attracted by the
trick of calling kernel func in realmode, and miss the exact point
where the lock is released.

Thanks and regards,
Pingfan
