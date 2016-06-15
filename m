Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV3sn0TnczDqhy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 21:18:20 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5FBEJOx011400
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 07:18:18 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23je2mc8ft-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 07:18:18 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 15 Jun 2016 07:18:17 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] Add support for power9 in ibm_architecture_vec
In-Reply-To: <900d62c2-8bdf-839a-49fa-99aff00a4d87@gmail.com>
References: <900d62c2-8bdf-839a-49fa-99aff00a4d87@gmail.com>
Date: Wed, 15 Jun 2016 16:47:31 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87k2hqaegk.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> The PVR list has been updated and IBM_ARCH_VEC_NRCORES_OFFSET.
>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/include/asm/prom.h | 5 ++++-
>  arch/powerpc/kernel/prom_init.c | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/prom.h b/arch/powerpc/include/asm/prom.h
> index 7f436ba..da0c98e 100644
> --- a/arch/powerpc/include/asm/prom.h
> +++ b/arch/powerpc/include/asm/prom.h
> @@ -111,7 +111,7 @@ struct of_drconf_cell {
>  #define OV_IGNORE		0x80	/* ignore this vector */
>  #define OV_CESSATION_POLICY	0x40	/* halt if unsupported option present*/
>
> -/* Option vector 1: processor architectures supported */
> +/* Option vector 1: byte 2, processor architectures supported */
>  #define OV1_PPC_2_00		0x80	/* set if we support PowerPC 2.00 */
>  #define OV1_PPC_2_01		0x40	/* set if we support PowerPC 2.01 */
>  #define OV1_PPC_2_02		0x20	/* set if we support PowerPC 2.02 */
> @@ -121,6 +121,9 @@ struct of_drconf_cell {
>  #define OV1_PPC_2_06		0x02	/* set if we support PowerPC 2.06 */
>  #define OV1_PPC_2_07		0x01	/* set if we support PowerPC 2.07 */
>
> +/* Option vector 1: byte 3, processor architectures supported */
> +#define OV1_PPC_3_00		0x80	/* set if we support PowerPC 3.00 */
> +
>  /* Option vector 2: Open Firmware options supported */
>  #define OV2_REAL_MODE		0x20	/* set if we want OF in real mode */
>
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index ccd2037..51f63e8 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -658,6 +658,8 @@ unsigned char ibm_architecture_vec[] = {
>  	W(0xffff0000), W(0x004b0000),	/* POWER8E */
>  	W(0xffff0000), W(0x004c0000),   /* POWER8NVL */
>  	W(0xffff0000), W(0x004d0000),	/* POWER8 */
> +	W(0xffff0000), W(0x004e0000),	/* POWER9 */
> +	W(0xffffffff), W(0x0f000005),	/* all 3.0-compliant */
>  	W(0xffffffff), W(0x0f000004),	/* all 2.07-compliant */
>  	W(0xffffffff), W(0x0f000003),	/* all 2.06-compliant */
>  	W(0xffffffff), W(0x0f000002),	/* all 2.05-compliant */
> @@ -669,6 +671,7 @@ unsigned char ibm_architecture_vec[] = {
>  	0,				/* don't ignore, don't halt */
>  	OV1_PPC_2_00 | OV1_PPC_2_01 | OV1_PPC_2_02 | OV1_PPC_2_03 |
>  	OV1_PPC_2_04 | OV1_PPC_2_05 | OV1_PPC_2_06 | OV1_PPC_2_07,
> +	OV1_PPC_3_00,
>
>  	/* option vector 2: Open Firmware options supported */
>  	VECTOR_LENGTH(33),		/* length */
> @@ -719,7 +722,7 @@ unsigned char ibm_architecture_vec[] = {
>  	 * must match by the macro below. Update the definition if
>  	 * the structure layout changes.
>  	 */
> -#define IBM_ARCH_VEC_NRCORES_OFFSET	125
> +#define IBM_ARCH_VEC_NRCORES_OFFSET	150

Shouldn't this be 125 + 16 ?

>  	W(NR_CPUS),			/* number of cores supported */
>  	0,
>  	0,
> -- 
> 2.5.5
