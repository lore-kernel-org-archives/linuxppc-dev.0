Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 72FB61A01BA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 08:30:12 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 2 Mar 2015 16:30:09 -0500
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 5624AC90057
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2015 16:21:18 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t22LU7c720250712
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Mar 2015 21:30:07 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t22LU6iT003221
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Mar 2015 16:30:07 -0500
Message-ID: <54F4D65B.5080603@linux.vnet.ibm.com>
Date: Mon, 02 Mar 2015 13:30:03 -0800
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Cyril Bur <cyrilbur@gmail.com>
Subject: Re: [PATCH 1/3] powerpc/pseries: Simplify check for suspendability
 during suspend/migration
References: <1425090283-27694-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1425090283-27694-2-git-send-email-tyreld@linux.vnet.ibm.com>
 <1425269985.2919.29.camel@cyril>
In-Reply-To: <1425269985.2919.29.camel@cyril>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/01/2015 08:19 PM, Cyril Bur wrote:
> On Fri, 2015-02-27 at 18:24 -0800, Tyrel Datwyler wrote:
>> During suspend/migration operation we must wait for the VASI state reported
>> by the hypervisor to become Suspending prior to making the ibm,suspend-me
>> RTAS call. Calling routines to rtas_ibm_supend_me() pass a vasi_state variable
>> that exposes the VASI state to the caller. This is unnecessary as the caller
>> only really cares about the following three conditions; if there is an error
>> we should bailout, success indicating we have suspended and woken back up so
>> proceed to device tree updated, or we are not suspendable yet so try calling
>> rtas_ibm_suspend_me again shortly.
>>
>> This patch removes the extraneous vasi_state variable and simply uses the
>> return code to communicate how to proceed. We either succeed, fail, or get
>> -EAGAIN in which case we sleep for a second before trying to call
>> rtas_ibm_suspend_me again.
>>
>> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/rtas.h           |  2 +-
>>  arch/powerpc/kernel/rtas.c                | 15 +++++++--------
>>  arch/powerpc/platforms/pseries/mobility.c |  8 +++-----
>>  3 files changed, 11 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
>> index 2e23e92..fc85eb0 100644
>> --- a/arch/powerpc/include/asm/rtas.h
>> +++ b/arch/powerpc/include/asm/rtas.h
>> @@ -327,7 +327,7 @@ extern int rtas_suspend_cpu(struct rtas_suspend_me_data *data);
>>  extern int rtas_suspend_last_cpu(struct rtas_suspend_me_data *data);
>>  extern int rtas_online_cpus_mask(cpumask_var_t cpus);
>>  extern int rtas_offline_cpus_mask(cpumask_var_t cpus);
>> -extern int rtas_ibm_suspend_me(u64 handle, int *vasi_return);
>> +extern int rtas_ibm_suspend_me(u64 handle);
>>  
> I like ditching vasi_return, I was never happy with myself for doing
> that!
> 
>>  struct rtc_time;
>>  extern unsigned long rtas_get_boot_time(void);
>> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
>> index 21c45a2..603b928 100644
>> --- a/arch/powerpc/kernel/rtas.c
>> +++ b/arch/powerpc/kernel/rtas.c
>> @@ -897,7 +897,7 @@ int rtas_offline_cpus_mask(cpumask_var_t cpus)
>>  }
>>  EXPORT_SYMBOL(rtas_offline_cpus_mask);
>>  
>> -int rtas_ibm_suspend_me(u64 handle, int *vasi_return)
>> +int rtas_ibm_suspend_me(u64 handle)
> 
> That definition is actually in an #ifdef CONFIG_PPC_PSERIES, you'll need
> to change the definition for !CONFIG_PPC_PSERIES

Good catch. I'll fix it there too.

>>  {
>>  	long state;
>>  	long rc;
>> @@ -919,13 +919,11 @@ int rtas_ibm_suspend_me(u64 handle, int *vasi_return)
>>  		printk(KERN_ERR "rtas_ibm_suspend_me: vasi_state returned %ld\n",rc);
>>  		return rc;
>>  	} else if (state == H_VASI_ENABLED) {
>> -		*vasi_return = RTAS_NOT_SUSPENDABLE;
>> -		return 0;
>> +		return -EAGAIN;
>>  	} else if (state != H_VASI_SUSPENDING) {
>>  		printk(KERN_ERR "rtas_ibm_suspend_me: vasi_state returned state %ld\n",
>>  		       state);
>> -		*vasi_return = -1;
>> -		return 0;
>> +		return -EIO;
> 
> I've had a look as to how these return values get passed back up the
> stack and admittedly were dealing with a confusing mess, I've compared
> back to before my patch (which wasn't perfect either it seems).
> Both the state == H_VASI_ENABLED and state == H_VASI_SUSPENDING cause
> ppc_rtas to go to the copy_return and return 0 (albeit with an error
> code in args.rets[0]), because rtas_ppc goes back to out userland, I
> hesitate to change any of that.

Agreed, that this is a bit of a mess. The problem is we have two call
paths into rtas_ibm_suspend_me(). The one from migrate_store() and one
from ppc_rtas(). I'll address each with your other comments below.

>>  	}
>>  
>>  	if (!alloc_cpumask_var(&offline_mask, GFP_TEMPORARY))
>> @@ -1060,9 +1058,10 @@ asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
>>  		int vasi_rc = 0;
> 
> This generates unused variable warning.

Sloppy on my part. Will remove.

> 
>>  		u64 handle = ((u64)be32_to_cpu(args.args[0]) << 32)
>>  		              | be32_to_cpu(args.args[1]);
>> -		rc = rtas_ibm_suspend_me(handle, &vasi_rc);
>> -		args.rets[0] = cpu_to_be32(vasi_rc);
>> -		if (rc)
>> +		rc = rtas_ibm_suspend_me(handle);
>> +		if (rc == -EAGAIN)
>> +			args.rets[0] = cpu_to_be32(RTAS_NOT_SUSPENDABLE);
> 
> (continuing on...) so perhaps here have
> 	rc = 0;
> else if (rc == -EIO)
> 	args.rets[0] = cpu_to_be32(-1);
> 	rc = 0;
> Which should keep the original behaviour, the last thing we want to do
> is break BE.

The biggest problem here is we are making what basically equates to a
fake rtas call from drmgr which we intercept in ppc_rtas(). From there
we make this special call to rtas_ibm_suspend_me() to check VASI state
and do a bunch of other specialized work that needs to be setup prior to
making the actual ibm,suspend-me rtas call. Since, we are cheating PAPR
here I guess we can really handle it however we want. I chose to simply
fail the rtas call in the case where rtas_ibm_suspend_me() fails with
something other than -EAGAIN. In user space librtas will log errno for
the failure and return RTAS_IO_ASSERT to drmgr which in turn will log
that error and fail.

Going forward we want to move drmgr to initiating migration through
sysfs and not this clunky highway robbery of the rtas interface. So, for
legacy purpose does it matter how we fail the call here? I'm open to
either solution. If we choose to pass the error back through args.ret[0]
what value do we choose? The following are all pretty standardized, but
I don't think make sense here:

-1: Hardware error
-2: Busy
-3: Parameter error
9000: Suspension Aborted

The 9000 code maybe makes sense, but doesn't really convey that
something bad a happened. In the end whatever value is passed in
args.ret[0] drmgr will simply log.

While I agree about not breaking BE I'm not sure how it would. All i've
done is added the -EIO case to explicit failure.

> 
> Might be worth checking that rc from rtas_ibm_suspend_me will only be
> -EAGAIN and -EIO when they are explicitly set in rtas_ibm_suspend_me and
> can't come back out from the hcall.
> From reading PAPR we're ok there but just as a thought it might be worth
> returning errno as positive because hcall errors are going to be
> negative, to make life easier at some point... but then we'll have to
> remember to make them negative when going back to userland (and there
> are two places...) so there's no perfect win here.
> 

There are a variety of things that could go wrong that aren't directly
related to rtas. This is why I chose to explicitly fail the rtas call if
we get anything other than 0 or -EAGAIN.

>> +		else if (rc)
>>  			return rc;
>>  		goto copy_return;
>>  	}
>> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
>> index 90cf3dc..29e4f04 100644
>> --- a/arch/powerpc/platforms/pseries/mobility.c
>> +++ b/arch/powerpc/platforms/pseries/mobility.c
>> @@ -325,15 +325,13 @@ static ssize_t migrate_store(struct class *class, struct class_attribute *attr,
>>  		return rc;
>>  
>>  	do {
>> -		rc = rtas_ibm_suspend_me(streamid, &vasi_rc);
>> -		if (!rc && vasi_rc == RTAS_NOT_SUSPENDABLE)
>> +		rc = rtas_ibm_suspend_me(streamid);
>> +		if (rc == -EAGAIN)
>>  			ssleep(1);
>> -	} while (!rc && vasi_rc == RTAS_NOT_SUSPENDABLE);
>> +	} while (rc == -EAGAIN);
> 
> This is going to change the value of the error code.

Here drmgr assumes a zero or greater value to mean success, and anything
negative failure. It logs errno in failure case.

-Tyrel

>>  
>>  	if (rc)
>>  		return rc;
>> -	if (vasi_rc)
>> -		return vasi_rc;
>>  
>>  	post_mobility_fixup();
>>  	return count;
> 
> Thanks for taking it, it looks nicer now.
> 
> Cyril
> 
> 
