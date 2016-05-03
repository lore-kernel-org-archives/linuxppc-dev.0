Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzwsm2gVqzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 08:32:43 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 3 May 2016 16:32:41 -0600
Subject: Re: [PATCH 2/2] powerpc: Update of_remove_property() call sites to
 remove null checking
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1461821695-19204-1-git-send-email-sjitindarsingh@gmail.com>
 <1461821695-19204-2-git-send-email-sjitindarsingh@gmail.com>
Cc: robh+dt@kernel.org, paulus@samba.org, grant.likely@linaro.org,
 frowand.list@gmail.com
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Message-ID: <57292702.5070507@linux.vnet.ibm.com>
Date: Tue, 3 May 2016 15:32:34 -0700
MIME-Version: 1.0
In-Reply-To: <1461821695-19204-2-git-send-email-sjitindarsingh@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/27/2016 10:34 PM, Suraj Jitindar Singh wrote:
> After obtaining a property from of_find_property() and before calling
> of_remove_property() most code checks to ensure that the property
> returned from of_find_property() is not null. The previous patch
> moved this check to the start of the function of_remove_property() in
> order to avoid the case where this check isn't done and a null value is
> passed. This ensures the check is always conducted before taking locks
> and attempting to remove the property. Thus it is no longer necessary
> to perform a check for null values before invoking of_remove_property().
> 
> Update of_remove_property() call sites in order to remove redundant
> checking for null property value as check is now performed within the
> of_remove_property function().
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  arch/powerpc/kernel/machine_kexec.c       | 19 ++++++-------------
>  arch/powerpc/kernel/machine_kexec_64.c    | 11 ++++-------
>  arch/powerpc/platforms/pseries/mobility.c |  4 ++--
>  arch/powerpc/platforms/pseries/reconfig.c |  5 +----
>  4 files changed, 13 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
> index 015ae55..55744a8 100644
> --- a/arch/powerpc/kernel/machine_kexec.c
> +++ b/arch/powerpc/kernel/machine_kexec.c
> @@ -228,17 +228,12 @@ static struct property memory_limit_prop = {
>  
>  static void __init export_crashk_values(struct device_node *node)
>  {
> -	struct property *prop;
> -
>  	/* There might be existing crash kernel properties, but we can't
>  	 * be sure what's in them, so remove them. */
> -	prop = of_find_property(node, "linux,crashkernel-base", NULL);
> -	if (prop)
> -		of_remove_property(node, prop);
> -
> -	prop = of_find_property(node, "linux,crashkernel-size", NULL);
> -	if (prop)
> -		of_remove_property(node, prop);
> +	of_remove_property(node, of_find_property(node,
> +				"linux,crashkernel-base", NULL));
> +	of_remove_property(node, of_find_property(node,
> +				"linux,crashkernel-size", NULL));
>  
>  	if (crashk_res.start != 0) {
>  		crashk_base = cpu_to_be_ulong(crashk_res.start),
> @@ -258,16 +253,14 @@ static void __init export_crashk_values(struct device_node *node)
>  static int __init kexec_setup(void)
>  {
>  	struct device_node *node;
> -	struct property *prop;
>  
>  	node = of_find_node_by_path("/chosen");
>  	if (!node)
>  		return -ENOENT;
>  
>  	/* remove any stale properties so ours can be found */
> -	prop = of_find_property(node, kernel_end_prop.name, NULL);
> -	if (prop)
> -		of_remove_property(node, prop);
> +	of_remove_property(node, of_find_property(node, kernel_end_prop.name,
> +				NULL));
>  
>  	/* information needed by userspace when using default_machine_kexec */
>  	kernel_end = cpu_to_be_ulong(__pa(_end));
> diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
> index 0fbd75d..2608192 100644
> --- a/arch/powerpc/kernel/machine_kexec_64.c
> +++ b/arch/powerpc/kernel/machine_kexec_64.c
> @@ -401,7 +401,6 @@ static struct property htab_size_prop = {
>  static int __init export_htab_values(void)
>  {
>  	struct device_node *node;
> -	struct property *prop;
>  
>  	/* On machines with no htab htab_address is NULL */
>  	if (!htab_address)
> @@ -412,12 +411,10 @@ static int __init export_htab_values(void)
>  		return -ENODEV;
>  
>  	/* remove any stale propertys so ours can be found */
> -	prop = of_find_property(node, htab_base_prop.name, NULL);
> -	if (prop)
> -		of_remove_property(node, prop);
> -	prop = of_find_property(node, htab_size_prop.name, NULL);
> -	if (prop)
> -		of_remove_property(node, prop);
> +	of_remove_property(node, of_find_property(node, htab_base_prop.name,
> +				NULL));
> +	of_remove_property(node, of_find_property(node, htab_size_prop.name,
> +				NULL));
>  
>  	htab_base = cpu_to_be64(__pa(htab_address));
>  	of_add_property(node, &htab_base_prop);
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index ceb18d3..a560a98 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -191,8 +191,8 @@ static int update_dt_node(__be32 phandle, s32 scope)
>  				break;
>  
>  			case 0x80000000:
> -				prop = of_find_property(dn, prop_name, NULL);
> -				of_remove_property(dn, prop);
> +				of_remove_property(dn, of_find_property(dn,
> +							prop_name, NULL));
>  				prop = NULL;
>  				break;
>

You haven't removed a NULL check here, as suggested by the changelog,
but instead made a cosmetic change to the code that still leaves behind
a now unnecessary "prop = NULL;" to bit rot.

> diff --git a/arch/powerpc/platforms/pseries/reconfig.c b/arch/powerpc/platforms/pseries/reconfig.c
> index 7c7fcc0..cc66c49 100644
> --- a/arch/powerpc/platforms/pseries/reconfig.c
> +++ b/arch/powerpc/platforms/pseries/reconfig.c
> @@ -303,7 +303,6 @@ static int do_remove_property(char *buf, size_t bufsize)
>  {
>  	struct device_node *np;
>  	char *tmp;
> -	struct property *prop;
>  	buf = parse_node(buf, bufsize, &np);
>  
>  	if (!np)
> @@ -316,9 +315,7 @@ static int do_remove_property(char *buf, size_t bufsize)
>  	if (strlen(buf) == 0)
>  		return -EINVAL;
>  
> -	prop = of_find_property(np, buf, NULL);
> -
> -	return of_remove_property(np, prop);
> +	return of_remove_property(np, of_find_property(np, buf, NULL));
>  }

Again, you are not removing a NULL check as suggested by the changelog.

-Tyrel

>  
>  static int do_update_property(char *buf, size_t bufsize)
> 
