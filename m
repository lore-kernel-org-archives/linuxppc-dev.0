Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F2D482C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 21:57:43 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 31 Jan 2014 16:27:39 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D29291258054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 16:29:23 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0VAvUOq38731926
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 16:27:30 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0VAvbOx003671
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 16:27:37 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH 02/10] KVM: PPC: BOOK3S: PR: Emulate virtual timebase
 register
In-Reply-To: <20140130054913.GA10611@iris.ozlabs.ibm.com>
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390927455-3312-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140130054913.GA10611@iris.ozlabs.ibm.com>
Date: Fri, 31 Jan 2014 16:27:37 +0530
Message-ID: <87vbx0ju5a.fsf@linux.vnet.ibm.com>
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

> On Tue, Jan 28, 2014 at 10:14:07PM +0530, Aneesh Kumar K.V wrote:
>> virtual time base register is a per vm register and need to saved
>> and restored on vm exit and entry. Writing to VTB is not allowed
>> in the privileged mode.
> ...
>
>> +#ifdef CONFIG_PPC_BOOK3S_64
>> +#define mfvtb()		({unsigned long rval;				\
>> +			asm volatile("mfspr %0, %1" :			\
>> +				     "=r" (rval) : "i" (SPRN_VTB)); rval;})
>
> The mfspr will be a no-op on anything before POWER8, meaning the
> result will be whatever value was in the destination GPR before the
> mfspr.  I suppose that may not matter if the result is only ever used
> when we're running on a POWER8 host, but I would feel more comfortable
> if we had explicit feature tests to make sure of that, rather than
> possibly doing computations with unpredictable values.
>
> With your patch, a guest on a POWER7 or a PPC970 could do a read from
> VTB and get garbage -- first, there is nothing to stop userspace from
> requesting POWER8 emulation on an older machine, and secondly, even if
> the virtual machine is a PPC970 (say) you don't implement
> unimplemented SPR semantics for VTB (no-op if PR=0, illegal
> instruction interrupt if PR=1).

Ok that means we need to do something like  ?

	struct cpu_spec *s = find_cpuspec(vcpu->arch.pvr);
        if (s->cpu_features & CPU_FTR_ARCH_207S) {

        }

        
>
> On the whole I think it is reasonable to reject an attempt to set the
> virtual PVR to a POWER8 PVR value if we are not running on a POWER8
> host, because emulating all the new POWER8 features in software
> (particularly transactional memory) would not be feasible.  Alex may
> disagree. :)

That would make it much simpler.

-aneesh
