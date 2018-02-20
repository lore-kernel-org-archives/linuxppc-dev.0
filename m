Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlxyQ3Nf8zF0jx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 21:42:22 +1100 (AEDT)
Message-ID: <1519123341.5655.5.camel@neuling.org>
Subject: Re: [PATCH] powerpc/eeh: Add conditional check on notify_resume
From: Michael Neuling <mikey@neuling.org>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
 jjalvare@linux.vnet.ibm.com,  seroyer@linux.vnet.ibm.com
Date: Tue, 20 Feb 2018 21:42:21 +1100
In-Reply-To: <1518720591-84657-1-git-send-email-bryantly@linux.vnet.ibm.com>
References: <1518720591-84657-1-git-send-email-bryantly@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-02-15 at 12:49 -0600, Bryant G. Ly wrote:
> From: "Juan J. Alvarez" <jjalvare@linux.vnet.ibm.com>
>=20
> EEH structure is not populated with function
> notify resume when running on systems that do not support
> it, i.e: BMC. Hence adding a conditional check for NULL for
> systems that don't add function notify_resume.
>=20
> Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
> Reviewed-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
> Tested-by: Carol L. Soto <clsoto@us.ibm.com>

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
>  arch/powerpc/kernel/eeh_driver.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/eeh_driver.c
> b/arch/powerpc/kernel/eeh_driver.c
> index beea218..0c0b66f 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -384,7 +384,8 @@ static void *eeh_report_resume(void *data, void *user=
data)
>  	eeh_pcid_put(dev);
>  	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
>  #ifdef CONFIG_PCI_IOV
> -	eeh_ops->notify_resume(eeh_dev_to_pdn(edev));
> +	if (eeh_ops->notify_resume && eeh_dev_to_pdn(edev))
> +		eeh_ops->notify_resume(eeh_dev_to_pdn(edev));
>  #endif
>  	return NULL;
>  }
