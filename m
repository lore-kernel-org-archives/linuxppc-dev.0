Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsLH15ldnzDqhl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 18:14:37 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5K84Nal118862
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 04:14:34 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b6hbj2406-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 04:14:33 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 20 Jun 2017 18:14:30 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5K8ESha63832220
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 18:14:28 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5K8EQlF025971
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 18:14:26 +1000
Subject: Re: [RFC v2 07/12] powerpc: Macro the mask used for checking DSI
 exception
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-8-git-send-email-linuxram@us.ibm.com>
Cc: dave.hansen@intel.com, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 20 Jun 2017 13:44:25 +0530
MIME-Version: 1.0
In-Reply-To: <1497671564-20030-8-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <427a86fa-0f61-43b4-1423-7f78a3fd3cb1@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2017 09:22 AM, Ram Pai wrote:
> Replace the magic number used to check for DSI exception
> with a meaningful value.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/reg.h       | 9 ++++++++-
>  arch/powerpc/kernel/exceptions-64s.S | 2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 7e50e47..2dcb8a1 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -272,16 +272,23 @@
>  #define SPRN_DAR	0x013	/* Data Address Register */
>  #define SPRN_DBCR	0x136	/* e300 Data Breakpoint Control Reg */
>  #define SPRN_DSISR	0x012	/* Data Storage Interrupt Status Register */
> +#define   DSISR_BIT32		0x80000000	/* not defined */
>  #define   DSISR_NOHPTE		0x40000000	/* no translation found */
> +#define   DSISR_PAGEATTR_CONFLT	0x20000000	/* page attribute conflict */
> +#define   DSISR_BIT35		0x10000000	/* not defined */
>  #define   DSISR_PROTFAULT	0x08000000	/* protection fault */
>  #define   DSISR_BADACCESS	0x04000000	/* bad access to CI or G */
>  #define   DSISR_ISSTORE		0x02000000	/* access was a store */
>  #define   DSISR_DABRMATCH	0x00400000	/* hit data breakpoint */
> -#define   DSISR_NOSEGMENT	0x00200000	/* SLB miss */
>  #define   DSISR_KEYFAULT	0x00200000	/* Key fault */
> +#define   DSISR_BIT43		0x00100000	/* not defined */
>  #define   DSISR_UNSUPP_MMU	0x00080000	/* Unsupported MMU config */
>  #define   DSISR_SET_RC		0x00040000	/* Failed setting of R/C bits */
>  #define   DSISR_PGDIRFAULT      0x00020000      /* Fault on page directory */
> +#define   DSISR_PAGE_FAULT_MASK (DSISR_BIT32 | \
> +				DSISR_PAGEATTR_CONFLT | \
> +				DSISR_BADACCESS |       \
> +				DSISR_BIT43)

Sorry missed this one. Seems like there are couple of unnecessary
line additions in the subsequent patch which adds the new PKEY
reason code.

-#define   DSISR_PAGE_FAULT_MASK (DSISR_BIT32 | \
-				DSISR_PAGEATTR_CONFLT | \
-				DSISR_BADACCESS |       \
+#define   DSISR_PAGE_FAULT_MASK (DSISR_BIT32 |	\
+				DSISR_PAGEATTR_CONFLT |	\
+				DSISR_BADACCESS |	\
+				DSISR_KEYFAULT |	\
 				DSISR_BIT43)
