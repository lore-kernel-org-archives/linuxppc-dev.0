Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3FNG44B5zDqRW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 21:08:29 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v66B885D143309
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Jul 2017 07:08:26 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bhm2e80xq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Jul 2017 07:08:25 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 6 Jul 2017 21:08:21 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v66B8Jei51839208
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Jul 2017 21:08:19 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v66B8Ig7002427
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Jul 2017 21:08:18 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com
Subject: Re: [PATCH] cxl: Fix is_page_fault() for POWER9
In-Reply-To: <1499182912-26730-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1499182912-26730-1-git-send-email-clombard@linux.vnet.ibm.com>
Date: Thu, 06 Jul 2017 16:38:11 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87efttrffo.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Christophe Lombard <clombard@linux.vnet.ibm.com> writes:

> This patches removes this restriction and all page faults, whatever the
> reason, will be handled. In this case, the interruption is always
> acknowledged.

This can also be done with adding call to cxl_ack_ae(ctx) at the end of
cxl_handle_fault().

>  static bool cxl_is_page_fault(struct cxl_context *ctx, u64 dsisr)
>  {
> -	u64 crs; /* Translation Checkout Response Status */
> -
>  	if ((cxl_is_power8()) && (dsisr & CXL_PSL_DSISR_An_DM))
>  		return true;
>
> -	if (cxl_is_power9()) {
> -		crs = (dsisr & CXL_PSL9_DSISR_An_CO_MASK);
> -		if ((crs == CXL_PSL9_DSISR_An_PF_SLR) ||
> -		    (crs == CXL_PSL9_DSISR_An_PF_RGC) ||
> -		    (crs == CXL_PSL9_DSISR_An_PF_RGP) ||
> -		    (crs == CXL_PSL9_DSISR_An_PF_HRH) ||
> -		    (crs == CXL_PSL9_DSISR_An_PF_STEG) ||
> -		    (crs == CXL_PSL9_DSISR_An_URTCH)) {
> -			return true;
> -		}
> -	}
Removing this check will force call to copro_handle_mm_fault even for
nmmu reported errors that only need to be communicated to the AFU and
not handled by mm subsystem as such. 

> +	if (cxl_is_power9())
> +		return true;

Optional: With this change the function has become a good candidate for
being inlined or even converting to a macro.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
