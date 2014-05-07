Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E58F914028F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 17:58:38 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 7 May 2014 13:28:34 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 937BEE005F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 13:28:56 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s477wZwX50069726
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 May 2014 13:28:35 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s477wSch014954
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 May 2014 13:28:29 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] KVM: PPC: BOOK3S: PR: Fix WARN_ON with debug options on
In-Reply-To: <20140507055626.GA26650@iris.ozlabs.ibm.com>
References: <1399224368-22122-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20140507055626.GA26650@iris.ozlabs.ibm.com>
Date: Wed, 07 May 2014 13:28:27 +0530
Message-ID: <87iopiuijg.fsf@linux.vnet.ibm.com>
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

> On Sun, May 04, 2014 at 10:56:08PM +0530, Aneesh Kumar K.V wrote:
>> With debug option "sleep inside atomic section checking" enabled we get
>> the below WARN_ON during a PR KVM boot. This is because upstream now
>> have PREEMPT_COUNT enabled even if we have preempt disabled. Fix the
>> warning by adding preempt_disable/enable around floating point and altivec
>> enable.
>
> This worries me a bit.  In this code:
>
>>  	if (msr & MSR_FP) {
>> +		preempt_disable();
>>  		enable_kernel_fp();
>>  		load_fp_state(&vcpu->arch.fp);
>>  		t->fp_save_area = &vcpu->arch.fp;
>> +		preempt_enable();
>
> What would happen if we actually did get preempted at this point?
> Wouldn't we lose the FP state we just loaded?

I was not sure we have got CONFIG_PREEMPT working with kvm. So i was
not looking at preempted case. But yes, if we have PREEMPT enabled it
would break as per the current code. 

>
> In other words, how come we're not already preempt-disabled at this
> point?

I don't see us disabling preempt in the code path. Are you suggesting
that we should be preempt disabled for the whole duration of
kvmppc_handle_ext ? 

-aneesh
