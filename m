Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svG8S1h1PzDsrd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 01:14:48 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9CEEUj8101178
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 10:14:45 -0400
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 by mx0b-001b2d01.pphosted.com with ESMTP id 261nbq48cm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 10:14:44 -0400
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Wed, 12 Oct 2016 15:14:41 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id A6FB21B08023
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 15:16:38 +0100 (BST)
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
 [9.149.37.213])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9CEEb6M21299412
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 14:14:37 GMT
Received: from d06av03.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av03.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9CEEa9G001631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 08:14:37 -0600
Subject: Re: [PATCH] powerpc/mm: Prevent unlikely crash in
 copro_calculate_slb()
To: linuxppc-dev@lists.ozlabs.org
References: <1466182408-17884-1-git-send-email-fbarrat@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Wed, 12 Oct 2016 16:14:35 +0200
MIME-Version: 1.0
In-Reply-To: <1466182408-17884-1-git-send-email-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <3e856f04-23a7-b980-a857-27b3342f1548@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ping? The patch still applies cleanly on recent trees.

   Fred

Le 17/06/2016 à 18:53, Frederic Barrat a écrit :
> If a cxl adapter faults on an invalid address for a kernel context, we
> may enter copro_calculate_slb() with a NULL mm pointer (kernel
> context) and an effective address which looks like a user
> address. Which will cause a crash when dereferencing mm. It is clearly
> an AFU bug, but there's no reason to crash either. So return an error,
> so that cxl can ack the interrupt with an address error.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Cc: <stable@vger.kernel.org>
> ---
>  arch/powerpc/mm/copro_fault.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
> index 6527882..ddfd274 100644
> --- a/arch/powerpc/mm/copro_fault.c
> +++ b/arch/powerpc/mm/copro_fault.c
> @@ -106,6 +106,8 @@ int copro_calculate_slb(struct mm_struct *mm, u64 ea, struct copro_slb *slb)
>  	switch (REGION_ID(ea)) {
>  	case USER_REGION_ID:
>  		pr_devel("%s: 0x%llx -- USER_REGION_ID\n", __func__, ea);
> +		if (mm == NULL)
> +			return 1;
>  		psize = get_slice_psize(mm, ea);
>  		ssize = user_segment_size(ea);
>  		vsid = get_vsid(mm->context.id, ea, ssize);
>
