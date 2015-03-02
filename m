Return-Path: <cyrilbur@gmail.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32A0D1A0196
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Mar 2015 15:19:57 +1100 (AEDT)
Received: by pablj1 with SMTP id lj1so1576209pab.10
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Mar 2015 20:19:54 -0800 (PST)
Message-ID: <1425269985.2919.29.camel@cyril>
Subject: Re: [PATCH 1/3] powerpc/pseries: Simplify check for suspendability
 during suspend/migration
From: Cyril Bur <cyrilbur@gmail.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 02 Mar 2015 15:19:45 +1100
In-Reply-To: <1425090283-27694-2-git-send-email-tyreld@linux.vnet.ibm.com>
References: <1425090283-27694-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <1425090283-27694-2-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-02-27 at 18:24 -0800, Tyrel Datwyler wrote:
> During suspend/migration operation we must wait for the VASI state reported
> by the hypervisor to become Suspending prior to making the ibm,suspend-me
> RTAS call. Calling routines to rtas_ibm_supend_me() pass a vasi_state variable
> that exposes the VASI state to the caller. This is unnecessary as the caller
> only really cares about the following three conditions; if there is an error
> we should bailout, success indicating we have suspended and woken back up so
> proceed to device tree updated, or we are not suspendable yet so try calling
> rtas_ibm_suspend_me again shortly.
> 
> This patch removes the extraneous vasi_state variable and simply uses the
> return code to communicate how to proceed. We either succeed, fail, or get
> -EAGAIN in which case we sleep for a second before trying to call
> rtas_ibm_suspend_me again.
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/rtas.h           |  2 +-
>  arch/powerpc/kernel/rtas.c                | 15 +++++++--------
>  arch/powerpc/platforms/pseries/mobility.c |  8 +++-----
>  3 files changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
> index 2e23e92..fc85eb0 100644
> --- a/arch/powerpc/include/asm/rtas.h
> +++ b/arch/powerpc/include/asm/rtas.h
> @@ -327,7 +327,7 @@ extern int rtas_suspend_cpu(struct rtas_suspend_me_data *data);
>  extern int rtas_suspend_last_cpu(struct rtas_suspend_me_data *data);
>  extern int rtas_online_cpus_mask(cpumask_var_t cpus);
>  extern int rtas_offline_cpus_mask(cpumask_var_t cpus);
> -extern int rtas_ibm_suspend_me(u64 handle, int *vasi_return);
> +extern int rtas_ibm_suspend_me(u64 handle);
>  
I like ditching vasi_return, I was never happy with myself for doing
that!

>  struct rtc_time;
>  extern unsigned long rtas_get_boot_time(void);
> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
> index 21c45a2..603b928 100644
> --- a/arch/powerpc/kernel/rtas.c
> +++ b/arch/powerpc/kernel/rtas.c
> @@ -897,7 +897,7 @@ int rtas_offline_cpus_mask(cpumask_var_t cpus)
>  }
>  EXPORT_SYMBOL(rtas_offline_cpus_mask);
>  
> -int rtas_ibm_suspend_me(u64 handle, int *vasi_return)
> +int rtas_ibm_suspend_me(u64 handle)

That definition is actually in an #ifdef CONFIG_PPC_PSERIES, you'll need
to change the definition for !CONFIG_PPC_PSERIES
>  {
>  	long state;
>  	long rc;
> @@ -919,13 +919,11 @@ int rtas_ibm_suspend_me(u64 handle, int *vasi_return)
>  		printk(KERN_ERR "rtas_ibm_suspend_me: vasi_state returned %ld\n",rc);
>  		return rc;
>  	} else if (state == H_VASI_ENABLED) {
> -		*vasi_return = RTAS_NOT_SUSPENDABLE;
> -		return 0;
> +		return -EAGAIN;
>  	} else if (state != H_VASI_SUSPENDING) {
>  		printk(KERN_ERR "rtas_ibm_suspend_me: vasi_state returned state %ld\n",
>  		       state);
> -		*vasi_return = -1;
> -		return 0;
> +		return -EIO;

I've had a look as to how these return values get passed back up the
stack and admittedly were dealing with a confusing mess, I've compared
back to before my patch (which wasn't perfect either it seems).
Both the state == H_VASI_ENABLED and state == H_VASI_SUSPENDING cause
ppc_rtas to go to the copy_return and return 0 (albeit with an error
code in args.rets[0]), because rtas_ppc goes back to out userland, I
hesitate to change any of that.
>  	}
>  
>  	if (!alloc_cpumask_var(&offline_mask, GFP_TEMPORARY))
> @@ -1060,9 +1058,10 @@ asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
>  		int vasi_rc = 0;

This generates unused variable warning.

>  		u64 handle = ((u64)be32_to_cpu(args.args[0]) << 32)
>  		              | be32_to_cpu(args.args[1]);
> -		rc = rtas_ibm_suspend_me(handle, &vasi_rc);
> -		args.rets[0] = cpu_to_be32(vasi_rc);
> -		if (rc)
> +		rc = rtas_ibm_suspend_me(handle);
> +		if (rc == -EAGAIN)
> +			args.rets[0] = cpu_to_be32(RTAS_NOT_SUSPENDABLE);

(continuing on...) so perhaps here have
	rc = 0;
else if (rc == -EIO)
	args.rets[0] = cpu_to_be32(-1);
	rc = 0;
Which should keep the original behaviour, the last thing we want to do
is break BE.

Might be worth checking that rc from rtas_ibm_suspend_me will only be
-EAGAIN and -EIO when they are explicitly set in rtas_ibm_suspend_me and
can't come back out from the hcall.
>From reading PAPR we're ok there but just as a thought it might be worth
returning errno as positive because hcall errors are going to be
negative, to make life easier at some point... but then we'll have to
remember to make them negative when going back to userland (and there
are two places...) so there's no perfect win here.

> +		else if (rc)
>  			return rc;
>  		goto copy_return;
>  	}
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index 90cf3dc..29e4f04 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -325,15 +325,13 @@ static ssize_t migrate_store(struct class *class, struct class_attribute *attr,
>  		return rc;
>  
>  	do {
> -		rc = rtas_ibm_suspend_me(streamid, &vasi_rc);
> -		if (!rc && vasi_rc == RTAS_NOT_SUSPENDABLE)
> +		rc = rtas_ibm_suspend_me(streamid);
> +		if (rc == -EAGAIN)
>  			ssleep(1);
> -	} while (!rc && vasi_rc == RTAS_NOT_SUSPENDABLE);
> +	} while (rc == -EAGAIN);

This is going to change the value of the error code.
>  
>  	if (rc)
>  		return rc;
> -	if (vasi_rc)
> -		return vasi_rc;
>  
>  	post_mobility_fixup();
>  	return count;

Thanks for taking it, it looks nicer now.

Cyril
