Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcDjZ6KTfzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 10:18:42 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id f27so14032158pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 17:18:42 -0700 (PDT)
Date: Tue, 30 May 2017 10:18:28 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, "pc@us.ibm.com" <pc@us.ibm.com>
Subject: Re: [PATCH] powerpc/64s: dt_cpu_ftrs boot time setup option
Message-ID: <20170530101828.49ee3154@roar.ozlabs.ibm.com>
In-Reply-To: <87h9046jmq.fsf@concordia.ellerman.id.au>
References: <20170511112441.30287-1-npiggin@gmail.com>
 <87h9046jmq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 29 May 2017 20:29:49 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > Provide a dt_cpu_ftrs= cmdline option to disable the dt_cpu_ftrs CPU
> > feature discovery, and fall back to the "cputable" based version.  
> 
> I don't think this works properly.
> 
> > diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> > index fcc7588a96d6..050925b5b451 100644
> > --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> > +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> > @@ -775,6 +785,16 @@ bool __init dt_cpu_ftrs_in_use(void)
> >  
> >  bool __init dt_cpu_ftrs_init(void *fdt)
> >  {
> > +	if (!using_dt_cpu_ftrs) {
> > +		/*
> > +		 * This should never happen because this runs before
> > +		 * early_praam, however if the init ordering changes,
> > +		 * test if early_param has disabled this.
> > +		 */
> > +		return false;
> > +	}
> > +	using_dt_cpu_ftrs = false;
> > +
> >  	/* Setup and verify the FDT, if it fails we just bail */
> >  	if (!early_init_dt_verify(fdt))
> >  		return false;  
> ...
> 	return true;
> 
> Because this runs before early_param(), as you mention,
> dt_cpu_ftrs_init() returns true, which means we skip calling
> identify_cpu().
> 
> So although passing dt_cpu_ftrs=off will skip the later logic, it
> doesn't cause us to call identify_cpu() in early_setup() which it
> should.
> 
> In practice it works because the base CPU spec that we initialise in
> dt_cpu_ftrs.c is mostly OK, and skiboot also adds the cpu-version
> property which causes us to call identify_cpu() again later, but that's
> all a bit fragile IMHO.

Yeah that's a huge bug :P Good catch. Possible something would fail on
CPUs that aren't POWER8/9.

> 
> So unfortunately I think we need to add logic in dt_cpu_ftrs_init() to
> look for dt_cpu_ftrs=off on the command line.
> 
> The patch below seems to work, but would appreciate more eyes on it.

I can't find a problem with it, but I don't know how this fdt/prom stuff
all fits together exactly. Why is early_cmdline_parse() using call_prom
for essentially the same thing?

Thanks,
Nick

> 
> cheers
> 
> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> index d6f05e4dc328..9a560954498a 100644
> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> @@ -8,6 +8,7 @@
>  #include <linux/export.h>
>  #include <linux/init.h>
>  #include <linux/jump_label.h>
> +#include <linux/libfdt.h>
>  #include <linux/memblock.h>
>  #include <linux/printk.h>
>  #include <linux/sched.h>
> @@ -767,6 +770,26 @@ static void __init cpufeatures_setup_finished(void)
>  		cur_cpu_spec->cpu_features, cur_cpu_spec->mmu_features);
>  }
>  
> +static int __init disabled_on_cmdline(void)
> +{
> +	unsigned long root, chosen;
> +	const char *p;
> +
> +	root = of_get_flat_dt_root();
> +	chosen = of_get_flat_dt_subnode_by_name(root, "chosen");
> +	if (chosen == -FDT_ERR_NOTFOUND)
> +		return false;
> +
> +	p = of_get_flat_dt_prop(chosen, "bootargs", NULL);
> +	if (!p)
> +		return false;
> +
> +	if (strstr(p, "dt_cpu_ftrs=off"))
> +		return true;
> +
> +	return false;
> +}
> +
>  static int __init fdt_find_cpu_features(unsigned long node, const char *uname,
>  					int depth, void *data)
>  {
> @@ -801,6 +826,9 @@ bool __init dt_cpu_ftrs_init(void *fdt)
>  	if (!of_scan_flat_dt(fdt_find_cpu_features, NULL))
>  		return false;
>  
> +	if (disabled_on_cmdline())
> +		return false;
> +
>  	cpufeatures_setup_cpu();
>  
>  	using_dt_cpu_ftrs = true;
