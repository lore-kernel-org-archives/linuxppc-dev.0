Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zR9jr5z40zDr07
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 14:33:20 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0O3So3G007198
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 22:33:18 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fpcsuj9r7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 22:33:18 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Tue, 23 Jan 2018 22:33:17 -0500
Subject: Re: [PATCH-next] powerpc/fsl_pci: Use PTR_ERR_OR_ZERO
To: =?UTF-8?Q?Christopher_D=c3=adaz_Riveros?= <chrisadr@gentoo.org>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 joe@perches.com, christian.koenig@amd.com, tyreld@linux.vnet.ibm.com,
 konrad.wilk@oracle.com, robh@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20180123203752.15057-1-chrisadr@gentoo.org>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Tue, 23 Jan 2018 19:33:10 -0800
MIME-Version: 1.0
In-Reply-To: <20180123203752.15057-1-chrisadr@gentoo.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <dff06bae-9624-b688-2865-99aca16b9214@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/23/2018 12:37 PM, Christopher Díaz Riveros wrote:
> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Christopher Díaz Riveros <chrisadr@gentoo.org>
> ---

Reviewed-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

>  arch/powerpc/sysdev/fsl_pci.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
> index cc20d2255d7f..142184635c81 100644
> --- a/arch/powerpc/sysdev/fsl_pci.c
> +++ b/arch/powerpc/sysdev/fsl_pci.c
> @@ -1304,10 +1304,7 @@ static int add_err_dev(struct platform_device *pdev)
>  						   pdev->resource,
>  						   pdev->num_resources,
>  						   &pd, sizeof(pd));
> -	if (IS_ERR(errdev))
> -		return PTR_ERR(errdev);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(errdev);
>  }
>  
>  static int fsl_pci_probe(struct platform_device *pdev)
> 
