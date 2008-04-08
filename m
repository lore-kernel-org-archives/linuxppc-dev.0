Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CA2DDDDDFD
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 12:33:31 +1000 (EST)
Date: Mon, 7 Apr 2008 21:43:53 -0500
From: Olof Johansson <olof@lixom.net>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH] pseries: phyp dump: Variable size reserve space.
Message-ID: <20080408024352.GA32761@lixom.net>
References: <47FAB221.7050406@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47FAB221.7050406@austin.ibm.com>
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Just a few nitpicks, no comments on the functional parts:

On Mon, Apr 07, 2008 at 06:45:37PM -0500, Manish Ahuja wrote:
> A small proposed change in the amount of reserve space we allocate during boot.
> Currently we reserve 256MB only. 
> The proposed change does one of the 3 things.
> 
> A. It checks to see if there is cmdline variable set and if found sets the
>    value to it. OR
> B. It computes 5% of total ram and rounds it down to multiples of 256MB. AND
> C. Compares the rounded down value and returns larger of two values, the new
>    computed value or 256MB.

...

> +/* Look for phyp_dump_reserve_size= cmdline option */
> +static int __init early_phyp_dump_reserve_size(char *p)
> +{
> +        if (p)
> +		phyp_dump_info->phyp_dump_reserve_bootvar = memparse(p, &p);
[...]
> @@ -24,8 +24,10 @@ struct phyp_dump {
>  	/* Memory that is reserved during very early boot. */
>  	unsigned long init_reserve_start;
>  	unsigned long init_reserve_size;
> -	/* Check status during boot if dump supported, active & present*/
> +	/* cmd line options during boot */
> +	unsigned long phyp_dump_reserve_bootvar;
>  	unsigned long phyp_dump_at_boot;
> +	/* Check status during boot if dump supported, active & present*/
>  	unsigned long phyp_dump_configured;
>  	unsigned long phyp_dump_is_active;
>  	/* store cpu & hpte size */

These make for some really long variable names and lines. I know from
experience, since I've picked unneccessary long driver names in the past
myself. :)

How about just naming the new variables reserve_bootvar, etc? The name
of the struct they're in makes it obvious what they're for.


> +static inline unsigned long phyp_dump_calculate_reserve_size(void)
> +{
> +	unsigned long tmp;
> +
> +	if (phyp_dump_info->phyp_dump_reserve_bootvar)
> +		return phyp_dump_info->phyp_dump_reserve_bootvar;
> +
> +	/* divide by 20 to get 5% of value */
> +	tmp = lmb_end_of_DRAM();
> +	do_div(tmp, 20);
> +
> +	/* round it down in multiples of 256 */
> +	tmp = tmp & ~0x000000001FFFFFFF;

That's 512MB, isn't it?


-Olof
