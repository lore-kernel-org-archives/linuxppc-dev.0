Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5F0002C0080
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2013 13:41:30 +1100 (EST)
Message-ID: <1360291273.2650.52.camel@pasglop>
Subject: Re: [PATCH] powerpc: kernel/kgdb.c: fix memory leakage
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jason Wessel <jason.wessel@windriver.com>
Date: Fri, 08 Feb 2013 13:41:13 +1100
In-Reply-To: <510B22C2.90606@windriver.com>
References: <1358184395-31418-1-git-send-email-dinggnu@gmail.com>
 <510B22C2.90606@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Neuling <mikey@neuling.org>, Cong Ding <dinggnu@gmail.com>,
 linux-kernel@vger.kernel.org, Tiejun Chen <tiejun.chen@windriver.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-01-31 at 20:04 -0600, Jason Wessel wrote:

> > diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> > index 8747447..5ca82cd 100644
> > --- a/arch/powerpc/kernel/kgdb.c
> > +++ b/arch/powerpc/kernel/kgdb.c
> > @@ -154,12 +154,12 @@ static int kgdb_handle_breakpoint(struct pt_regs *regs)
> >  static int kgdb_singlestep(struct pt_regs *regs)
> >  {
> >  	struct thread_info *thread_info, *exception_thread_info;
> > -	struct thread_info *backup_current_thread_info = \
> > -		(struct thread_info *)kmalloc(sizeof(struct thread_info), GFP_KERNEL);
> > +	struct thread_info *backup_current_thread_info;
> 
> 
> 
> Woh...  This is definitely wrong.  You have found a problem for sure,
> but this is not the right way to fix it.
>
> It is not a good idea to kmalloc while single stepping because you can
> hang the kernel if you single step any operation in kmalloc().

Ok. I applied the fix because it was obviously correct vs. the previous
version of the code (ie. the kmalloc was already there)

> I am in the process of going through all the kgdb mails from the last
> few months while I had been away from the project, so I didn't catch
> this one and I see it has upstream commit (fefd9e6f8).  I'll submit
> another patch to fix this the right way and use a static variable.
> This is ok to use a static variable here because this is not something
> we can recursively call at a single CPU level.

But a static will be shared by all CPUs or do you mean a per-cpu one ?

> If Ben prefers we not burn the memory unless kgdb is active we can
> kmalloc / kfree the space we need at the time that kgdb is
> initialized.  Else we can go with this patch you see below.  We'll see
> what Ben desires.

What about the stack ? thread info isn't very big...

Cheers,
Ben.

> -----
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index a7bc752..bb12c8b 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -151,15 +151,16 @@ static int kgdb_handle_breakpoint(struct pt_regs *regs)
>  	return 1;
>  }
>  
> +static struct thread_info kgdb_backup_thread_info[NR_CPUS];
> +
>  static int kgdb_singlestep(struct pt_regs *regs)
>  {
>  	struct thread_info *thread_info, *exception_thread_info;
> -	struct thread_info *backup_current_thread_info;
> +	int cpu = raw_smp_processor_id();
>  
>  	if (user_mode(regs))
>  		return 0;
>  
> -	backup_current_thread_info = (struct thread_info *)kmalloc(sizeof(struct thread_info), GFP_KERNEL);
>  	/*
>  	 * On Book E and perhaps other processors, singlestep is handled on
>  	 * the critical exception stack.  This causes current_thread_info()
> @@ -175,7 +176,7 @@ static int kgdb_singlestep(struct pt_regs *regs)
>  
>  	if (thread_info != exception_thread_info) {
>  		/* Save the original current_thread_info. */
> -		memcpy(backup_current_thread_info, exception_thread_info, sizeof *thread_info);
> +		memcpy(&kgdb_backup_thread_info[cpu], exception_thread_info, sizeof *thread_info);
>  		memcpy(exception_thread_info, thread_info, sizeof *thread_info);
>  	}
>  
> @@ -183,9 +184,8 @@ static int kgdb_singlestep(struct pt_regs *regs)
>  
>  	if (thread_info != exception_thread_info)
>  		/* Restore current_thread_info lastly. */
> -		memcpy(exception_thread_info, backup_current_thread_info, sizeof *thread_info);
> +		memcpy(exception_thread_info, &kgdb_backup_thread_info[cpu], sizeof *thread_info);
>  
> -	kfree(backup_current_thread_info);
>  	return 1;
>  }
>  
> 
> -----
> 
> 
> Thanks,
> Jason.
> 
> 
> >  
> >  	if (user_mode(regs))
> >  		return 0;
> >  
> > +	backup_current_thread_info = (struct thread_info *)kmalloc(sizeof(struct thread_info), GFP_KERNEL);
> >  	/*
> >  	 * On Book E and perhaps other processors, singlestep is handled on
> >  	 * the critical exception stack.  This causes current_thread_info()
> > @@ -185,6 +185,7 @@ static int kgdb_singlestep(struct pt_regs *regs)
> >  		/* Restore current_thread_info lastly. */
> >  		memcpy(exception_thread_info, backup_current_thread_info, sizeof *thread_info);
> >  
> > +	kfree(backup_current_thread_info);
> >  	return 1;
> >  }
> >  
> > 
