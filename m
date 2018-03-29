Return-Path: <srs0=ipyq=gt=linux.vnet.ibm.com=prvs=062608506d=mauricfo@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [103.22.144.68])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Btj52vBkzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 05:35:21 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40Btj46Ysjz8vnt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 05:35:20 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40Btj40vQvz9s0b
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2018 05:35:19 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2TIZIDQ090101
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2018 14:35:18 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2h138vpcpa-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Mar 2018 14:35:17 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Thu, 29 Mar 2018 14:35:11 -0400
Subject: Re: [PATCH v2 03/10] powerpc/pseries: Set or clear security feature
 flags
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20180327120153.31612-1-mpe@ellerman.id.au>
 <20180327120153.31612-3-mpe@ellerman.id.au>
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
Date: Thu, 29 Mar 2018 15:35:07 -0300
MIME-Version: 1.0
In-Reply-To: <20180327120153.31612-3-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <9bcaff0a-d293-6b5b-8f2d-25490ca02b33@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On 03/27/2018 09:01 AM, Michael Ellerman wrote:
> +	if (!(result->character & H_CPU_BEHAV_FAVOUR_SECURITY))
> +		security_ftr_clear(SEC_FTR_FAVOUR_SECURITY);
> +
> +	if (!(result->character & H_CPU_BEHAV_L1D_FLUSH_PR))
> +		security_ftr_clear(SEC_FTR_L1D_FLUSH_PR);
> +
> +	if (!(result->character & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR))
> +		security_ftr_clear(SEC_FTR_BNDS_CHK_SPEC_BAR);

Oops, I missed this..

The H_CPU_BEHAV flags should be checked for in 'result->behaviour'.

Just sent '[PATCH] powerpc/pseries: Fix to clear security feature flags'

cheers,
Mauricio
