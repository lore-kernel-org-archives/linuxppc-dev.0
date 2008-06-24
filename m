Return-Path: <brking@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 15034DE12B
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 00:24:48 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5OEOiZ6024838
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 10:24:44 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5OEOieS100342
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 08:24:44 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5OEOdDP028603
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 08:24:43 -0600
Message-ID: <4861037D.8000408@linux.vnet.ibm.com>
Date: Tue, 24 Jun 2008 09:23:57 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Nathan Fontenot <nfont@austin.ibm.com>
Subject: Re: [PATCH 03/19][v3] powerpc: Add memory entitlement capabilities
	to /proc/ppc64/lparcfg
References: <20080612220923.GJ30916@linux.vnet.ibm.com>
	<4856D17F.7010804@austin.ibm.com>
In-Reply-To: <4856D17F.7010804@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just a few minor nits.

> +/**
> + * h_get_mpp
> + * H_GET_MPP hcall returns info in 7 parms
> + */
> +int h_get_mpp(struct hvcall_mpp_data *mpp_data)
> +{
> +    int rc;
> +    unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
   ^^^^

Should be tabs instead of spaces in this function and a few others
in this patch file.

> +/**
> + * parse_mpp_data
> + * Parse out data returned from h_get_mpp
> + */
> +static void parse_mpp_data(struct seq_file *m)
> +{
> +    struct hvcall_mpp_data mpp_data;
> +    int rc;

Same here.

> +/**
> + * update_mpp
> + *
> + * Update the memory entitlement and weight for the partition.  Caller
> must
> + * spercify either a new entitlement or weight, not both, to be updated
      ^^^^^^^^

> + * since the h_set_mpp call takes both entitlement and weight as
> parameters.
> + */
> +static ssize_t update_mpp(u64 *entitlement, u8 *weight)
> +{
> +    struct hvcall_mpp_data mpp_data;

Tab/spacing here.

> @@ -270,6 +272,20 @@
>  };
>  #define HCALL_STAT_ARRAY_SIZE    ((MAX_HCALL_OPCODE >> 2) + 1)
> 
> +struct hvcall_mpp_data {
> +    unsigned long entitled_mem;
> +    unsigned long mapped_mem;
> +    unsigned short group_num;
> +    unsigned short pool_num;
> +    unsigned char mem_weight;
> +    unsigned char unallocated_mem_weight;
> +    unsigned long unallocated_entitlement;    /* value in bytes */
> +    unsigned long pool_size;
> +    long loan_request;

Might as well be specific here and call this a signed long.
Tab/spacing issue here as well.


-- 
Brian King
Linux on Power Virtualization
IBM Linux Technology Center
