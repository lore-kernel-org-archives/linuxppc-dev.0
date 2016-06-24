Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbRd56Mc3zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 15:26:01 +1000 (AEST)
In-Reply-To: <20160622192507.11192.84463.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>,
 lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>, kexec@lists.infradead.org,
 Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [v2,1/2] refactor code parsing size based on memory range
Message-Id: <3rbRd54y9Vz9t0p@ozlabs.org>
Date: Fri, 24 Jun 2016 15:26:01 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-22-06 at 19:25:26 UTC, Hari Bathini wrote:
> Currently, crashkernel parameter supports the below syntax to parse size
> based on memory range:
> 
> 	crashkernel=<range1>:<size1>[,<range2>:<size2>,...]
> 
> While such parsing is implemented for crashkernel parameter, it applies to
> other parameters with similar syntax. So, move this code to a more generic
> place for code reuse.
> 
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: kexec@lists.infradead.org
> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>

Hari, it's not immediately clear that this makes no change to the logic in the
kexec code. Can you reply with a longer change log explaining why the old & new
logic is the same for kexec.

cheers


> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index 94aa10f..72f55e5 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -436,6 +436,11 @@ extern char *get_options(const char *str, int nints, int *ints);
>  extern unsigned long long memparse(const char *ptr, char **retptr);
>  extern bool parse_option_str(const char *str, const char *option);
>  
> +extern bool __init is_param_range_based(const char *cmdline);
> +extern unsigned long long __init parse_mem_range_size(const char *param,
> +						      char **str,
> +						      unsigned long long system_ram);
> +
>  extern int core_kernel_text(unsigned long addr);
>  extern int core_kernel_data(unsigned long addr);
>  extern int __kernel_text_address(unsigned long addr);
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 56b3ed0..d43f5cc 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1083,59 +1083,9 @@ static int __init parse_crashkernel_mem(char *cmdline,
>  	char *cur = cmdline, *tmp;
>  
>  	/* for each entry of the comma-separated list */
> -	do {
> -		unsigned long long start, end = ULLONG_MAX, size;
> -
> -		/* get the start of the range */
> -		start = memparse(cur, &tmp);
> -		if (cur == tmp) {
> -			pr_warn("crashkernel: Memory value expected\n");
> -			return -EINVAL;
> -		}
> -		cur = tmp;
> -		if (*cur != '-') {
> -			pr_warn("crashkernel: '-' expected\n");
> -			return -EINVAL;
> -		}
> -		cur++;
> -
> -		/* if no ':' is here, than we read the end */
> -		if (*cur != ':') {
> -			end = memparse(cur, &tmp);
> -			if (cur == tmp) {
> -				pr_warn("crashkernel: Memory value expected\n");
> -				return -EINVAL;
> -			}
> -			cur = tmp;
> -			if (end <= start) {
> -				pr_warn("crashkernel: end <= start\n");
> -				return -EINVAL;
> -			}
> -		}
> -
> -		if (*cur != ':') {
> -			pr_warn("crashkernel: ':' expected\n");
> -			return -EINVAL;
> -		}
> -		cur++;
> -
> -		size = memparse(cur, &tmp);
> -		if (cur == tmp) {
> -			pr_warn("Memory value expected\n");
> -			return -EINVAL;
> -		}
> -		cur = tmp;
> -		if (size >= system_ram) {
> -			pr_warn("crashkernel: invalid size\n");
> -			return -EINVAL;
> -		}
> -
> -		/* match ? */
> -		if (system_ram >= start && system_ram < end) {
> -			*crash_size = size;
> -			break;
> -		}
> -	} while (*cur++ == ',');
> +	*crash_size = parse_mem_range_size("crashkernel", &cur, system_ram);
> +	if (cur == cmdline)
> +		return -EINVAL;
>  
>  	if (*crash_size > 0) {
>  		while (*cur && *cur != ' ' && *cur != '@')
> @@ -1272,7 +1222,6 @@ static int __init __parse_crashkernel(char *cmdline,
>  			     const char *name,
>  			     const char *suffix)
>  {
> -	char	*first_colon, *first_space;
>  	char	*ck_cmdline;
>  
>  	BUG_ON(!crash_size || !crash_base);
> @@ -1290,12 +1239,10 @@ static int __init __parse_crashkernel(char *cmdline,
>  		return parse_crashkernel_suffix(ck_cmdline, crash_size,
>  				suffix);
>  	/*
> -	 * if the commandline contains a ':', then that's the extended
> +	 * if the parameter is range based, then that's the extended
>  	 * syntax -- if not, it must be the classic syntax
>  	 */
> -	first_colon = strchr(ck_cmdline, ':');
> -	first_space = strchr(ck_cmdline, ' ');
> -	if (first_colon && (!first_space || first_colon < first_space))
> +	if (is_param_range_based(ck_cmdline))
>  		return parse_crashkernel_mem(ck_cmdline, system_ram,
>  				crash_size, crash_base);
>  
> diff --git a/kernel/params.c b/kernel/params.c
> index a6d6149..84e40ae 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -268,6 +268,102 @@ char *parse_args(const char *doing,
>  	return err;
>  }
>  
> +/*
> + * is_param_range_based - check if current parameter is range based
> + * @cmdline: points to the parameter to check
> + *
> + * Returns true when the current paramer is range based, false otherwise
> + */
> +bool __init is_param_range_based(const char *cmdline)
> +{
> +	char    *first_colon, *first_space;
> +
> +	first_colon = strchr(cmdline, ':');
> +	first_space = strchr(cmdline, ' ');
> +	if (first_colon && (!first_space || first_colon < first_space))
> +		return true;
> +
> +	return false;
> +}
> +
> +/*
> + * parse_mem_range_size - parse size based on memory range
> + * @param:  the thing being parsed
> + * @str: (input)  where parse begins
> + *                expected format - <range1>:<size1>[,<range2>:<size2>,...]
> + *       (output) On success - next char after parse completes
> + *                On failure - unchanged
> + * @system_ram: system ram size to check memory range against
> + *
> + * Returns the memory size on success and 0 on failure
> + */
> +unsigned long long __init parse_mem_range_size(const char *param,
> +					       char **str,
> +					       unsigned long long system_ram)
> +{
> +	char *cur = *str, *tmp;
> +	unsigned long long mem_size = 0;
> +
> +	/* for each entry of the comma-separated list */
> +	do {
> +		unsigned long long start, end = ULLONG_MAX, size;
> +
> +		/* get the start of the range */
> +		start = memparse(cur, &tmp);
> +		if (cur == tmp) {
> +			printk(KERN_INFO "%s: Memory value expected\n", param);
> +			return mem_size;
> +		}
> +		cur = tmp;
> +		if (*cur != '-') {
> +			printk(KERN_INFO "%s: '-' expected\n", param);
> +			return mem_size;
> +		}
> +		cur++;
> +
> +		/* if no ':' is here, than we read the end */
> +		if (*cur != ':') {
> +			end = memparse(cur, &tmp);
> +			if (cur == tmp) {
> +				printk(KERN_INFO "%s: Memory value expected\n",
> +					param);
> +				return mem_size;
> +			}
> +			cur = tmp;
> +			if (end <= start) {
> +				printk(KERN_INFO "%s: end <= start\n", param);
> +				return mem_size;
> +			}
> +		}
> +
> +		if (*cur != ':') {
> +			printk(KERN_INFO "%s: ':' expected\n", param);
> +			return mem_size;
> +		}
> +		cur++;
> +
> +		size = memparse(cur, &tmp);
> +		if (cur == tmp) {
> +			printk(KERN_INFO "%s: Memory value expected\n", param);
> +			return mem_size;
> +		}
> +		cur = tmp;
> +		if (size >= system_ram) {
> +			printk(KERN_INFO "%s: invalid size\n", param);
> +			return mem_size;
> +		}
> +
> +		/* match ? */
> +		if (system_ram >= start && system_ram < end) {
> +			mem_size = size;
> +			*str = cur;
> +			break;
> +		}
> +	} while (*cur++ == ',');
> +
> +	return mem_size;
> +}
> +
>  /* Lazy bastard, eh? */
>  #define STANDARD_PARAM_DEF(name, type, format, strtolfn)      		\
>  	int param_set_##name(const char *val, const struct kernel_param *kp) \
