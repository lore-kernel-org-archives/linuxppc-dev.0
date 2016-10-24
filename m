Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2nBH4bcLzDvXn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 06:57:27 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9OJroZX120093
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 15:57:25 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 269ksj1rwg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 15:57:25 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 24 Oct 2016 13:57:24 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id D7BFC3E40052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 13:57:20 -0600 (MDT)
Subject: Re: [PATCH V6 5/8] pseries/drc-info: Search new DRC properties for
 CPU indexes
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <aac1ba74-6e44-3984-a4b3-fa90a6f7fa80@linux.vnet.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 24 Oct 2016 14:57:19 -0500
MIME-Version: 1.0
In-Reply-To: <aac1ba74-6e44-3984-a4b3-fa90a6f7fa80@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <d129dd93-1466-2ef2-8738-a99c478ef566@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/21/2016 09:17 AM, Michael Bringmann wrote:
> pseries/drc-info: Provide parallel routines to convert between
> drc_index and CPU numbers at runtime, using the older device-tree
> properties ("ibm,drc-indexes", "ibm,drc-names", "ibm,drc-types"
> and "ibm,drc-power-domains"), or the new property "ibm,drc-info".
> 
> [V2: Revise contant names.]
> [V3: No change.]
> [V4: No change.]
> [V5: Resynchronize/resubmit]
> [V6: No change]
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
> ---
> diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
> index 9276779..10c4200 100644
> --- a/arch/powerpc/platforms/pseries/pseries_energy.c
> +++ b/arch/powerpc/platforms/pseries/pseries_energy.c
> @@ -35,10 +35,68 @@ static int sysfs_entries;
> 
>  /* Helper Routines to convert between drc_index to cpu numbers */
> 
> +void read_one_drc_info(int **info, char **dtype, char **dname,
> +			unsigned long int *fdi_p, unsigned long int *nsl_p,
> +			unsigned long int *si_p, unsigned long int *ldi_p)
> +{
> +	char *drc_type, *drc_name, *pc;
> +	u32 fdi, nsl, si, ldi;
> +
> +	fdi = nsl = si = ldi = 0;
> +
> +	/* Get drc-type:encode-string */
> +	pc = (char *)info;
> +	drc_type = pc;
> +	pc += (strlen(drc_type) + 1);
> +
> +	/* Get drc-name-prefix:encode-string */
> +	drc_name = (char *)pc;
> +	pc += (strlen(drc_name) + 1);
> +
> +	/* Get drc-index-start:encode-int */
> +	memcpy(&fdi, pc, 4);

This may be a little nit, but could we get the shortened names for the
elements to match up with the comments, i.e. make the comment state
'Get first drc-index' to match fdi.

> +	fdi = be32_to_cpu(fdi);
> +	pc += 4;
> +
> +	/* Get/skip drc-name-suffix-start:encode-int */
> +	pc += 4;
> +
> +	/* Get number-sequential-elements:encode-int */
> +	memcpy(&nsl, pc, 4);
> +	nsl = be32_to_cpu(nsl);
> +	pc += 4;
> +
> +	/* Get sequential-increment:encode-int */
> +	memcpy(&si, pc, 4);
> +	si = be32_to_cpu(si);
> +	pc += 4;
> +
> +	/* Get/skip drc-power-domain:encode-int */
> +	pc += 4;
> +
> +	/* Should now know end of current entry */
> +	ldi = fdi + ((nsl-1)*si);
> +
> +	(*info) = (int *)pc;
> +
> +	if (dtype)
> +		*dtype = drc_type;
> +	if (dname)
> +		*dname = drc_name;
> +	if (fdi_p)
> +		*fdi_p = fdi;
> +	if (nsl_p)
> +		*nsl_p = nsl;
> +	if (si_p)
> +		*si_p = si;
> +	if (ldi_p)
> +		*ldi_p = ldi;
> +}
> +EXPORT_SYMBOL(read_one_drc_info);
> +
>  static u32 cpu_to_drc_index(int cpu)
>  {
>  	struct device_node *dn = NULL;
> -	const int *indexes;
>  	int i;
>  	int rc = 1;
>  	u32 ret = 0;
> @@ -46,18 +104,54 @@ static u32 cpu_to_drc_index(int cpu)
>  	dn = of_find_node_by_path("/cpus");
>  	if (dn == NULL)
>  		goto err;
> -	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
> -	if (indexes == NULL)
> -		goto err_of_node_put;
> +
>  	/* Convert logical cpu number to core number */
>  	i = cpu_core_index_of_thread(cpu);

Given the changes you've made to this routine I think we should re-name
i to core_index (or some such name), I had to read through a couple of
times to see where 'i' is used.

> -	/*
> -	 * The first element indexes[0] is the number of drc_indexes
> -	 * returned in the list.  Hence i+1 will get the drc_index
> -	 * corresponding to core number i.
> -	 */
> -	WARN_ON(i > indexes[0]);
> -	ret = indexes[i + 1];
> +
> +	if (firmware_has_feature(FW_FEATURE_DRC_INFO)) {
> +		int *info = (int *)4;

Why set info to 4? This doesn't appear necessary.

> +		unsigned long int num_set_entries, j, iw = i, fdi = 0;
> +		unsigned long int ldi = 0, nsl = 0, si = 0;
> +		char *dtype;
> +		char *dname;
> +
> +		info = (int *)of_get_property(dn, "ibm,drc-info", NULL);
> +		if (info == NULL)
> +			goto err_of_node_put;
> +
> +		num_set_entries = be32_to_cpu(*info++);
> +
> +		for (j = 0; j < num_set_entries; j++) {
> +
> +			read_one_drc_info(&info, &dtype, &dname, &fdi,
> +					&nsl, &si, &ldi);
> +			if (strcmp(dtype, "CPU"))
> +				goto err;
> +
> +			if (iw < ldi)
> +				break;
> +
> +			WARN_ON(((iw-fdi)%si) != 0);
> +		}
> +		WARN_ON((nsl == 0) | (si == 0));
> +
> +		ret = ldi + (iw*si);
> +	} else {
> +		const int *indexes;
> +
> +		indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
> +		if (indexes == NULL)
> +			goto err_of_node_put;
> +
> +		/*
> +		 * The first element indexes[0] is the number of drc_indexes
> +		 * returned in the list.  Hence i+1 will get the drc_index
> +		 * corresponding to core number i.
> +		 */
> +		WARN_ON(i > indexes[0]);
> +		ret = indexes[i + 1];
> +	}
> +
>  	rc = 0;
> 
>  err_of_node_put:
> @@ -78,21 +172,51 @@ static int drc_index_to_cpu(u32 drc_index)
>  	dn = of_find_node_by_path("/cpus");
>  	if (dn == NULL)
>  		goto err;
> -	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
> -	if (indexes == NULL)
> -		goto err_of_node_put;
> -	/*
> -	 * First element in the array is the number of drc_indexes
> -	 * returned.  Search through the list to find the matching
> -	 * drc_index and get the core number
> -	 */
> -	for (i = 0; i < indexes[0]; i++) {
> -		if (indexes[i + 1] == drc_index)
> +
> +	if (firmware_has_feature(FW_FEATURE_DRC_INFO)) {
> +		int *info = (int *)dn;

Why are you setting info here? This is set in the call to of_get_property()
below.

-Nathan

> +		unsigned long int num_set_entries, j, ret;
> +		unsigned long int fdi = 0, ldi = 0, nsl = 0, si = 0;
> +		char *dtype, *dname;
> +
> +		info = (int *)of_get_property(dn, "ibm,drc-info", NULL);
> +		if (info == NULL)
> +			goto err_of_node_put;
> +
> +		num_set_entries = be32_to_cpu(*info++);
> +
> +		for (j = 0; j < num_set_entries; j++) {
> +			read_one_drc_info(&info, &dtype, &dname, &fdi,
> +					&nsl, &si, &ldi);
> +			if (strcmp(dtype, "CPU"))
> +				goto err;
> +
> +			WARN_ON(drc_index < fdi);
> +			if (drc_index > ldi)
> +				continue;
> +
> +			WARN_ON(((drc_index-fdi)%si) != 0);
> +
> +			ret = ((drc_index-fdi)/si);
>  			break;
> +		}
> +	} else {
> +		indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
> +		if (indexes == NULL)
> +			goto err_of_node_put;
> +		/*
> +		 * First element in the array is the number of drc_indexes
> +		 * returned.  Search through the list to find the matching
> +		 * drc_index and get the core number
> +		 */
> +		for (i = 0; i < indexes[0]; i++) {
> +			if (indexes[i + 1] == drc_index)
> +				break;
> +		}
> +		/* Convert core number to logical cpu number */
> +		cpu = cpu_first_thread_of_core(i);
> +		rc = 0;
>  	}
> -	/* Convert core number to logical cpu number */
> -	cpu = cpu_first_thread_of_core(i);
> -	rc = 0;
> 
>  err_of_node_put:
>  	of_node_put(dn);
> 
