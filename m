Return-Path: <maurosr@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zjYmV5Qp6zF1NN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Feb 2018 00:25:23 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1GDOjKC027756
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 08:25:21 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g5x6evxek-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 08:25:21 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maurosr@linux.vnet.ibm.com>;
 Fri, 16 Feb 2018 08:25:19 -0500
Date: Fri, 16 Feb 2018 11:25:12 -0200
From: Mauro Rodrigues <maurosr@linux.vnet.ibm.com>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
 jjalvare@linux.vnet.ibm.com, seroyer@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/eeh: Add conditional check on notify_resume
References: <1518720591-84657-1-git-send-email-bryantly@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518720591-84657-1-git-send-email-bryantly@linux.vnet.ibm.com>
Message-Id: <20180216132512.GA30262@korriban>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 15, 2018 at 12:49:51PM -0600, Bryant G. Ly wrote:
> From: "Juan J. Alvarez" <jjalvare@linux.vnet.ibm.com>
> 
> EEH structure is not populated with function
> notify resume when running on systems that do not support
> it, i.e: BMC. Hence adding a conditional check for NULL for
> systems that don't add function notify_resume.
> 
> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
> Reviewed-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Tested-by: Carol L. Soto <clsoto@us.ibm.com>

Tested-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>

Thanks! I was debugging it and I'm glad you proposed a fix already.
> ---
>  arch/powerpc/kernel/eeh_driver.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index beea218..0c0b66f 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -384,7 +384,8 @@ static void *eeh_report_resume(void *data, void *userdata)
>  	eeh_pcid_put(dev);
>  	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
>  #ifdef CONFIG_PCI_IOV
> -	eeh_ops->notify_resume(eeh_dev_to_pdn(edev));
> +	if (eeh_ops->notify_resume && eeh_dev_to_pdn(edev))
> +		eeh_ops->notify_resume(eeh_dev_to_pdn(edev));
>  #endif
>  	return NULL;
>  }
> -- 
> 2.7.2
> 
