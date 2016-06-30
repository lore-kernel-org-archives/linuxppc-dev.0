Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgMBv6x7zzDql5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 00:20:23 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UEKLcP064683
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 10:20:21 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23v09qyt9e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 10:20:20 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 15:19:59 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id A407F17D805A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 15:21:16 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5UEJt1V16449848
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 14:19:56 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5UEJtYq020075
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 08:19:55 -0600
Subject: Re: [PATCH 1/2] cxl: Fix bug where AFU disable operation had no effect
To: Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 mikey <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Huy Nguyen <huyn@mellanox.com>
References: <1467226286-28547-1-git-send-email-imunsie@au.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Thu, 30 Jun 2016 16:19:54 +0200
MIME-Version: 1.0
In-Reply-To: <1467226286-28547-1-git-send-email-imunsie@au.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <57752A8A.1020501@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ian,

> -static int afu_control(struct cxl_afu *afu, u64 command,
> +static int afu_control(struct cxl_afu *afu, u64 command, u64 clear,
>   		       u64 result, u64 mask, bool enabled)

I'm not a big fan of the new "clear" argument, which forces us to pass 
an extra 0 most of the time. Why not always clearing the "action" bits 
of the register before applying the command? They are mutually 
exclusive, so it should work. I.e. :

+	AFU_Cntl = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
+	AFU_Cntl &= ~(CXL_AFU_Cntl_An_E | CXL_AFU_Cntl_An_RA);
+	AFU_Cntl |= command;




> @@ -595,7 +597,16 @@ static int deactivate_afu_directed(struct cxl_afu *afu)
>   	cxl_sysfs_afu_m_remove(afu);
>   	cxl_chardev_afu_remove(afu);
>
> -	cxl_ops->afu_reset(afu);
> +	if (afu->adapter->native->sl_ops->needs_reset_before_disable) {
> +		/*
> +		 * XXX: We may be able to do away with this entirely - it is
> +		 * possible that this was only ever needed due to a bug where
> +		 * the disable operation did not clear the enable bit, however
> +		 * I will only consider dropping this after more regression
> +		 * testing on earlier PSL images.
> +		 */
> +		cxl_ops->afu_reset(afu);
> +	}
>   	cxl_afu_disable(afu);
>   	cxl_psl_purge(afu);
>
> @@ -735,7 +746,16 @@ static int native_attach_process(struct cxl_context *ctx, bool kernel,
>
>   static inline int detach_process_native_dedicated(struct cxl_context *ctx)
>   {
> -	cxl_ops->afu_reset(ctx->afu);
> +	if (ctx->afu->adapter->native->sl_ops->needs_reset_before_disable) {
> +		/*
> +		 * XXX: We may be able to do away with this entirely - it is
> +		 * possible that this was only ever needed due to a bug where
> +		 * the disable operation did not clear the enable bit, however
> +		 * I will only consider dropping this after more regression
> +		 * testing on earlier PSL images.
> +		 */
> +		cxl_ops->afu_reset(ctx->afu);
> +	}

For dedicated mode, the CAIA recommends an explicit reset of the AFU 
(section 2.1.1).

For directed mode, CAIA says it's AFU-specific. So for xsl, we only 
disable the afu and purge the xsl. Are we getting rid of the reset 
because it's useless in that environment, or because it times out? If 
just because of timeout, would it make sense to switch the order and 
disable first, then reset? I don't see any afu-reset on the next activation.

   Fred
