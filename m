Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3NXt41FGzDrFq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 17:31:41 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8T7Sx0B052242
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 03:31:39 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d98pv9ety-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 03:31:38 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 29 Sep 2017 17:31:36 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8T7VYZn46792720
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 17:31:34 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8T7VZtr026790
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 17:31:35 +1000
Date: Fri, 29 Sep 2017 13:01:24 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, anton@samba.org, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc/lib/sstep: Add XER bits introduced in POWER
 ISA v3.0
References: <20170929054410.12600-1-sandipan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170929054410.12600-1-sandipan@linux.vnet.ibm.com>
Message-Id: <20170929073124.zymjf7v7dr336ye3@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/09/29 05:44AM, Sandipan Das wrote:
> This adds definitions for the OV32 and CA32 bits of XER that
> were introduced in POWER ISA v3.0. There are some existing
> instructions that currently set the OV and CA bits based on
> certain conditions.
> 
> The emulation behaviour of all these instructions needs to
> be updated to set these new bits accordingly.
> 
> Signed-off-by: Sandipan Das <sandipan@linux.vnet.ibm.com>

For this series:
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

> ---
>  arch/powerpc/lib/sstep.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index 5e8418c28bd8..16814bfc01da 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -31,6 +31,8 @@ extern char system_call_common[];
>  #define XER_SO		0x80000000U
>  #define XER_OV		0x40000000U
>  #define XER_CA		0x20000000U
> +#define XER_OV32	0x00080000U
> +#define XER_CA32	0x00040000U
> 
>  #ifdef CONFIG_PPC_FPU
>  /*
> -- 
> 2.13.5
> 
