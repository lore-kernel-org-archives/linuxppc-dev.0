Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tcn9V2hZrzDw7V
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 02:40:46 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBCFdVd1093952
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 10:40:44 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 279vb53nvg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 10:40:44 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 12 Dec 2016 08:40:41 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A034B19D803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 08:39:57 -0700 (MST)
Subject: Re: [PATCH V9 8/8] powerpc: Enable support for new DRC devtree
 properties
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <148109469581.193207.1684012254014049364.stgit@powerkvm6.aus.stglabs.ibm.com>
 <148109495293.193207.8739036690257904427.stgit@powerkvm6.aus.stglabs.ibm.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Mon, 12 Dec 2016 09:40:37 -0600
MIME-Version: 1.0
In-Reply-To: <148109495293.193207.8739036690257904427.stgit@powerkvm6.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <c0cb1efb-dfcf-0e98-92f8-67a388ca7948@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/07/2016 01:16 AM, Michael Bringmann wrote:
> prom_init.c: Enable support for new DRC device tree properties
> "ibm,drc-info" and "ibm,dynamic-memory-v2" in initial handshake
> between the Linux kernel and the front end processor.
> 
> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>

Reviewed-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/prom_init.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index 88ac964..6e6454f 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -696,7 +696,7 @@ static void __init early_cmdline_parse(void)
>  	OV4_MIN_ENT_CAP,		/* minimum VP entitled capacity */
> 
>  	/* option vector 5: PAPR/OF options */
> -	VECTOR_LENGTH(21),		/* length */
> +	VECTOR_LENGTH(22),		/* length */
>  	0,				/* don't ignore, don't halt */
>  	OV5_FEAT(OV5_LPAR) | OV5_FEAT(OV5_SPLPAR) | OV5_FEAT(OV5_LARGE_PAGES) |
>  	OV5_FEAT(OV5_DRCONF_MEMORY) | OV5_FEAT(OV5_DONATE_DEDICATE_CPU) |
> @@ -732,6 +732,7 @@ static void __init early_cmdline_parse(void)
>  	0,							/* Byte 19 */
>  	0,							/* Byte 20 */
>  	OV5_FEAT(OV5_SUB_PROCESSORS),				/* Byte 21 */
> +	OV5_FEAT(OV5_DYN_MEM_V2) | OV5_FEAT(OV5_DRC_INFO),	/* Byte 22 */
> 
>  	/* option vector 6: IBM PAPR hints */
>  	VECTOR_LENGTH(3),		/* length */
> 
