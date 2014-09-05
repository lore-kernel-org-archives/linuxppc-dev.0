Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 848B71A00E4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Sep 2014 00:08:13 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 5 Sep 2014 10:08:10 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id BF6ED6E8028
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 10:07:56 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s85E885R9634226
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Sep 2014 14:08:08 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s85E87AT001837
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Sep 2014 10:08:08 -0400
Message-ID: <5409C3C6.90204@linux.vnet.ibm.com>
Date: Fri, 05 Sep 2014 09:08:06 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: bharata.rao@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pseries: Make CPU hotplug path endian safe
References: <1409908577-10648-1-git-send-email-bharata.rao@gmail.com>
In-Reply-To: <1409908577-10648-1-git-send-email-bharata.rao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Bharata B Rao <bharata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/05/2014 04:16 AM, bharata.rao@gmail.com wrote:
> From: Bharata B Rao <bharata@linux.vnet.ibm.com>
> 
> - ibm,rtas-configure-connector should treat the RTAS data as big endian.
> - Treat ibm,ppc-interrupt-server#s as big-endian when setting
>   smp_processor_id during hotplug.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/dlpar.c       | 10 +++++-----
>  arch/powerpc/platforms/pseries/hotplug-cpu.c |  4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
> index 2d0b4d6..dc55f9c 100644
> --- a/arch/powerpc/platforms/pseries/dlpar.c
> +++ b/arch/powerpc/platforms/pseries/dlpar.c
> @@ -48,11 +48,11 @@ static struct property *dlpar_parse_cc_property(struct cc_workarea *ccwa)
>  	if (!prop)
>  		return NULL;
>  
> -	name = (char *)ccwa + ccwa->name_offset;
> +	name = (char *)ccwa + be32_to_cpu(ccwa->name_offset);
>  	prop->name = kstrdup(name, GFP_KERNEL);
>  
> -	prop->length = ccwa->prop_length;
> -	value = (char *)ccwa + ccwa->prop_offset;
> +	prop->length = be32_to_cpu(ccwa->prop_length);
> +	value = (char *)ccwa + be32_to_cpu(ccwa->prop_offset);
>  	prop->value = kmemdup(value, prop->length, GFP_KERNEL);
>  	if (!prop->value) {
>  		dlpar_free_cc_property(prop);
> @@ -78,7 +78,7 @@ static struct device_node *dlpar_parse_cc_node(struct cc_workarea *ccwa,
>  	if (!dn)
>  		return NULL;
>  
> -	name = (char *)ccwa + ccwa->name_offset;
> +	name = (char *)ccwa + be32_to_cpu(ccwa->name_offset);
>  	dn->full_name = kasprintf(GFP_KERNEL, "%s/%s", path, name);
>  	if (!dn->full_name) {
>  		kfree(dn);
> @@ -148,7 +148,7 @@ struct device_node *dlpar_configure_connector(u32 drc_index,
>  		return NULL;
>  
>  	ccwa = (struct cc_workarea *)&data_buf[0];
> -	ccwa->drc_index = drc_index;
> +	ccwa->drc_index = cpu_to_be32(drc_index);

I need to look at this some more but I think this may cause an issue for
partition migration. If I am following the code correctly, starting in
pseries_devicetree_update(), the drc_index value passed to 
dlpar_configure_connector is pulled directly out of a buffer we get from
firmware. This would mean the drc_index value is already in BE format.

Whereas for cpu hotplug the drc_index value is passed in from userspace
via the cpu probe interface in sysfs. I assume that you are seeing the
drc_index value getting passed in in LE format.

-Nathan

>  	ccwa->zero = 0;
>  
>  	do {
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index 20d6297..447f8c6 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -247,7 +247,7 @@ static int pseries_add_processor(struct device_node *np)
>  	unsigned int cpu;
>  	cpumask_var_t candidate_mask, tmp;
>  	int err = -ENOSPC, len, nthreads, i;
> -	const u32 *intserv;
> +	const __be32 *intserv;
>  
>  	intserv = of_get_property(np, "ibm,ppc-interrupt-server#s", &len);
>  	if (!intserv)
> @@ -293,7 +293,7 @@ static int pseries_add_processor(struct device_node *np)
>  	for_each_cpu(cpu, tmp) {
>  		BUG_ON(cpu_present(cpu));
>  		set_cpu_present(cpu, true);
> -		set_hard_smp_processor_id(cpu, *intserv++);
> +		set_hard_smp_processor_id(cpu, be32_to_cpu(*intserv++));
>  	}
>  	err = 0;
>  out_unlock:
> 
