Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zjC2z2wyZzF0m1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 10:21:46 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1FNKriq100753
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 18:21:44 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g5ke88rsn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 18:21:44 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 15 Feb 2018 23:21:42 -0000
Subject: Re: [PATCH] powerpc/eeh: Add conditional check on notify_resume
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org, jjalvare@linux.vnet.ibm.com,
 seroyer@linux.vnet.ibm.com
References: <1518720591-84657-1-git-send-email-bryantly@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 16 Feb 2018 10:21:35 +1100
MIME-Version: 1.0
In-Reply-To: <1518720591-84657-1-git-send-email-bryantly@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <eab718d5-3134-45af-eca0-c886dca28909@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16/02/18 05:49, Bryant G. Ly wrote:
> From: "Juan J. Alvarez" <jjalvare@linux.vnet.ibm.com>
> 
> EEH structure is not populated with function
> notify resume when running on systems that do not support
> it, i.e: BMC. Hence adding a conditional check for NULL for

Seems to me that by "BMC" you really mean "powernv platform"?

> systems that don't add function notify_resume.
> 
> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
> Reviewed-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Tested-by: Carol L. Soto <clsoto@us.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   arch/powerpc/kernel/eeh_driver.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index beea218..0c0b66f 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -384,7 +384,8 @@ static void *eeh_report_resume(void *data, void *userdata)
>   	eeh_pcid_put(dev);
>   	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
>   #ifdef CONFIG_PCI_IOV
> -	eeh_ops->notify_resume(eeh_dev_to_pdn(edev));
> +	if (eeh_ops->notify_resume && eeh_dev_to_pdn(edev))
> +		eeh_ops->notify_resume(eeh_dev_to_pdn(edev));
>   #endif
>   	return NULL;
>   }
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
