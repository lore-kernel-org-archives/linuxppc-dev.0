Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wqhm874MRzDq7W
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Jun 2017 02:00:40 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5HFwdCd139488
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 12:00:37 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b57a80cyw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 12:00:37 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Sat, 17 Jun 2017 12:00:36 -0400
Date: Sat, 17 Jun 2017 09:00:19 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm/hash: Free the subpage_prot_table correctly
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1497709855-25788-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497709855-25788-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20170617160019.GB5845@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This fix, resolved the OOM seen while running subpage_prot selftest, in a
infinite loop.

Tested-by: Ram Pai <linuxram@us.ibm.com>


On Sat, Jun 17, 2017 at 08:00:55PM +0530, Aneesh Kumar K.V wrote:
> Fixes: dad6f37c2602e ("powerpc: subpage_protect: Increase the array size to take care of 64TB")
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/subpage-prot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
> index e94fbd4c8845..781532d7bc4d 100644
> --- a/arch/powerpc/mm/subpage-prot.c
> +++ b/arch/powerpc/mm/subpage-prot.c
> @@ -36,7 +36,7 @@ void subpage_prot_free(struct mm_struct *mm)
>  		}
>  	}
>  	addr = 0;
> -	for (i = 0; i < 2; ++i) {
> +	for (i = 0; i < (TASK_SIZE_USER64 >> 43); ++i) {
>  		p = spt->protptrs[i];
>  		if (!p)
>  			continue;
> -- 
> 2.7.4

-- 
Ram Pai
