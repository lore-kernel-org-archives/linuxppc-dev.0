Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 21751679FC
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 05:22:16 +1000 (EST)
Date: Fri, 28 Apr 2006 14:21:49 -0500
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [RFC , PATCH] support for the ibm,pa_features cpu property
Message-ID: <20060428192149.GJ5518@pb15.lixom.net>
References: <1146249684.27214.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1146249684.27214.18.camel@localhost.localdomain>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Will,

Some general comments below. Not having seen the documentation for the
new property I obviously can't comment on the correctness from that
perspective.

Do you know why they went for this brand new extra architected bitfield
instead of continuing down the way that processor features always have
been documented before, by adding a property to the cpu device node?

That seems like a much more logical solution to me. It sort of sounds
like someone was bored one day and decided to get busy with architecting
yet another way to specify processor capabilities. :(

(Now, the naming convention of calling it a "pa feature" is unfortunate,
but nothing I can really complain about since our stuff is not yet in
tree.)


-Olof

On Fri, Apr 28, 2006 at 01:41:24PM -0500, Will Schmidt wrote:
> 
> To determine if our processors support some features, such as large
> pages, we should be using the ibm,pa_features property, rather than just
> the PVR values.  
> This is an initial pass at the functionality.  This has been tested in
> the case where the property is missing, but still needs to be tested
> against a system where the property actually exists.  :-o  
> 
> 
> 
> diff --git a/arch/powerpc/kernel/setup_64.c
> b/arch/powerpc/kernel/setup_64.c
> index 13e91c4..78ad054 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -106,6 +106,65 @@ static struct notifier_block ppc64_panic
>  	.priority = INT_MIN /* may not return; must be done last */
>  };
>  
> +/*
> + * ibm,pa-features is a per-cpu property that contains a 2 byte header
> + * plus up to 256 bytes worth of processor attributes.  First header
> + * byte specifies the number of bytes implemented by the platform.
> + * Second header byte is an "attribute-specifier" type, which should
> + * be zero.  Remainder of the data consists of ones and zeros.

So, essentially a bit array with one bit per feature with a 2-byte
header?

> + * Implementation:  Pass in the byte and bit offset for the feature
> + * that we are interested in.  The function will return -1 if the
> + * pa-features property is missing, or a 1/0 to indicate if the feature
> + * is supported/not supported.
> + */
> +
> +static int get_pa_features(int pabyte,int pabit)

So this is more of a check_pa_feature (int pabyte, int pabit)

(note space after comma, CodingStyle)

> +{
> +	struct device_node *cpu;
> +	char *pa_feature_table;
> +
> +	cpu = of_find_node_by_type(NULL, "cpu");
> +	pa_feature_table = 
> +		(char *)get_property(cpu, "ibm,pa-features", NULL);
> +	if ( pa_feature_table == NULL ) {

No spaces after ( and before )

> +		printk("ibm,pa-features property is missing.\n");
> +		return -1;
> +	}

This will read the property on every call. How about making the table
pointer static instead and keeping it cached?

> +
> +	/* sanity check */
> +	if ( pabyte > pa_feature_table[0] ) {
> +		printk("%s: %d out of range for table of size %d\n",
> +			__FUNCTION__,pabyte,pa_feature_table[0]);

This might pop on regular machines, so you might want to do away with
the printk by default, or add it under a DBG() macro that's not enabled
by default (see other powerpc files for examples)

> +		return -1;
> +	}
> +	
> +	return pa_feature_table[2+pabyte*8+pabit];
> +}

Not knowing the order of the bitfield, I'm guessing you might want this
instead:

	return pa_feature_table[2+pabyte] & (0x80 >> pabit);

I would prefer to see a 0/1 return. 1 if the feature is set, 0
otherwise. I.e. no -1 on failure.

> +/*
> + * set values within the cur_cpu_spec table according to
> + * the ibm,pa_features property. 
> + * potential entries include: 
> + * Byte 0, bit 1 - FPU available
> + * Byte 1, bit 2 - Large Pages 
> + * Byte 2, bit 3 - DAR set on alignment Interrupt. 

Wow, that's a really sparse array, 8 empty entries between each
allocated bit so far.

I would like to see these as #defines as well. It might make more sense
to have them as just bit number, and calculate the byte in the function
above instead. That way it's only one define per feature.

> + */
> +static void add_cpu_features()
> +{
> +	/* if no property, bail early */
> +	if (get_pa_features(0,0) == -1 ) return;

Probably no need to bail early, especially if the feature check function
just returns 0 if it's out-of-bounds (or no property exists)

> +
> +	if (get_pa_features(1,2) ) {
> +		printk("Adding CI_LARGE_PAGE to cur_cpu_spec \n");
> +		cur_cpu_spec->cpu_features |= CPU_FTR_CI_LARGE_PAGE;
> +	}
> +
> +	/* add more here... */
> +
> +}
> +
> +
>  #ifdef CONFIG_SMP
>  
>  static int smt_enabled_cmdline;
> @@ -425,6 +484,8 @@ void __init setup_system(void)
>  
>  	parse_early_param();
>  
> +	add_cpu_features();
> +
>  	check_smt_enabled();
>  	smp_setup_cpu_maps();
>  
> 
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
