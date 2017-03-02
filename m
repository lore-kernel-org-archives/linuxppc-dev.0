Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vYjlX1tQlzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 17:56:23 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v226rVgt102206
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 01:56:21 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28xdv11h1g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Mar 2017 01:56:21 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 2 Mar 2017 16:56:18 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5E7173578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Mar 2017 17:56:15 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v226u78k9044186
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 17:56:15 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v226tgRu003289
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Mar 2017 17:55:43 +1100
Subject: Re: [PATCH 5/7] cxl: Rename some psl8 specific functions
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
References: <1485970213-25532-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1485970213-25532-6-git-send-email-clombard@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 2 Mar 2017 17:55:18 +1100
MIME-Version: 1.0
In-Reply-To: <1485970213-25532-6-git-send-email-clombard@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <29f1e718-27a7-893c-b928-afd4207efd4d@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/02/17 04:30, Christophe Lombard wrote:
> Rename a few functions, changing the '_psl' suffix to '_psl8', to make
> clear that the implementation is psl8 specific.
> Those functions will have an equivalent implementation for the psl9 in
> a later patch.
>
> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>

This patch needs rebasing, I've done it at:

https://github.com/ajdlinux/linux/commit/ff6837cfae79d51829db824e4b914c9f1e76a9c1

Possibly could be squashed into the previous patch, but imho it's fine 
as is.

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> @@ -873,26 +873,25 @@ struct cxl_irq_info {
>  };
>
>  void cxl_assign_psn_space(struct cxl_context *ctx);
> -int cxl_invalidate_all_psl(struct cxl *adapter);
> -irqreturn_t cxl_irq_psl(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info);
> -irqreturn_t cxl_fail_irq_psl(struct cxl_afu *afu, struct cxl_irq_info *irq_info);
> +int cxl_invalidate_all_psl8(struct cxl *adapter);
> +irqreturn_t cxl_irq_psl8(int irq, struct cxl_context *ctx, struct cxl_irq_info *irq_info);
> +irqreturn_t cxl_fail_irq_psl8(struct cxl_afu *afu, struct cxl_irq_info *irq_info);
>  int cxl_register_one_irq(struct cxl *adapter, irq_handler_t handler,
>  			void *cookie, irq_hw_number_t *dest_hwirq,
>  			unsigned int *dest_virq, const char *name);
>
>  int cxl_check_error(struct cxl_afu *afu);
>  int cxl_afu_slbia(struct cxl_afu *afu);
> -int cxl_tlb_slb_invalidate(struct cxl *adapter);

This isn't a rename. :)

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
