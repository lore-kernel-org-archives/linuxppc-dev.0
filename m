Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D8A01A082E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 20:45:33 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 4 Jun 2014 20:45:32 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 324C32CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 20:45:28 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s54ANZ0E11206940
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jun 2014 20:23:35 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s54AjR0r006037
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jun 2014 20:45:27 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] KVM: PPC: BOOK3S: PR: Fix PURR and SPURR emulation
In-Reply-To: <20140604041547.GA32223@drongo>
References: <1401797771-25606-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140604041547.GA32223@drongo>
Date: Wed, 04 Jun 2014 16:15:23 +0530
Message-ID: <87vbsh6ji4.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> On Tue, Jun 03, 2014 at 05:46:11PM +0530, Aneesh Kumar K.V wrote:
>> We use time base for PURR and SPURR emulation with PR KVM since we
>> are emulating a single threaded core. When using time base
>> we need to make sure that we don't accumulate time spent in the host
>> in PURR and SPURR value.
>
> Mostly looks good except for this...
>
>> @@ -170,6 +175,11 @@ void kvmppc_copy_from_svcpu(struct kvm_vcpu *vcpu,
>>  
>>  out:
>>  	preempt_enable();
>> +	/*
>> +	 * Update purr and spurr using time base
>> +	 */
>> +	vcpu->arch.purr += get_tb() - vcpu->arch.entry_tb;
>> +	vcpu->arch.spurr += get_tb() - vcpu->arch.entry_tb;
>
> You need to do those updates before the "out:" label.  Otherwise if
> this function gets called with !svcpu->in_use (which can happen if
> CONFIG_PREEMPT is enabled) we would do these updates a second time for
> one guest exit.  The thing is that kvmppc_copy_from_svcpu() can get
> called from kvmppc_core_vcpu_put_pr() if the vcpu task gets preempted
> on the way out from the guest before we get to the regular call of
> kvmppc_copy_from_svcpu().  It would then get called again when the
> task gets to run, but this time it does nothing because svcpu->in_use
> is false.

Looking at the code, since we enable MSR.EE early now, we might possibly
end up calling this function late in the guest exit path. That
implies, we may account that time (time spent after a preempt immediately
following a guest exit) in purr/spurr. I guess that amount of inaccuracy is
ok, because that is the best we could do here ?

-aneesh
