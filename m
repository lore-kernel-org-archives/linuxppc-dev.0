Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 229631401F0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 21:37:58 +1000 (EST)
Message-ID: <536A1B11.2030101@suse.de>
Date: Wed, 07 May 2014 13:37:53 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] KVM: PPC: BOOK3S: PR: Fix WARN_ON with debug options
 on
References: <1399224368-22122-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140507055626.GA26650@iris.ozlabs.ibm.com>
In-Reply-To: <20140507055626.GA26650@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/07/2014 07:56 AM, Paul Mackerras wrote:
> On Sun, May 04, 2014 at 10:56:08PM +0530, Aneesh Kumar K.V wrote:
>> With debug option "sleep inside atomic section checking" enabled we get
>> the below WARN_ON during a PR KVM boot. This is because upstream now
>> have PREEMPT_COUNT enabled even if we have preempt disabled. Fix the
>> warning by adding preempt_disable/enable around floating point and altivec
>> enable.
> This worries me a bit.  In this code:
>
>>   	if (msr & MSR_FP) {
>> +		preempt_disable();
>>   		enable_kernel_fp();
>>   		load_fp_state(&vcpu->arch.fp);
>>   		t->fp_save_area = &vcpu->arch.fp;
>> +		preempt_enable();
> What would happen if we actually did get preempted at this point?
> Wouldn't we lose the FP state we just loaded?
>
> In other words, how come we're not already preempt-disabled at this
> point?

This is probably because we're trying to confuse Linux :). The entry 
path happens with interrupts hard disabled, but preempt enabled so that 
Linux doesn't consider the guest time as non-preemptible. That's the 
only call I could find where preempt is logically enabled (though it 
really isn't).


Alex
