Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ccD10LKTzF0yB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 12:58:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/13] powerpc/eeh: Clean up pci_ers_result handling
In-Reply-To: <a4aae83e02d8a5424a92321659a2100a5589d366.1525242772.git.sbobroff@linux.ibm.com>
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
 <a4aae83e02d8a5424a92321659a2100a5589d366.1525242772.git.sbobroff@linux.ibm.com>
Date: Fri, 04 May 2018 12:58:55 +1000
Message-ID: <87y3h086ts.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sam Bobroff <sbobroff@linux.ibm.com> writes:
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 188d15c4fe3a..f33dd68a9ca2 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -39,6 +39,29 @@ struct eeh_rmv_data {
>  	int removed;
>  };
>  
> +static int eeh_result_priority(enum pci_ers_result result)
> +{
> +	switch (result) {
> +	case PCI_ERS_RESULT_NONE: return 0;
> +	case PCI_ERS_RESULT_NO_AER_DRIVER: return 1;
> +	case PCI_ERS_RESULT_RECOVERED: return 2;
> +	case PCI_ERS_RESULT_CAN_RECOVER: return 3;
> +	case PCI_ERS_RESULT_DISCONNECT: return 4;
> +	case PCI_ERS_RESULT_NEED_RESET: return 5;
> +	default:
> +		WARN_ONCE(1, "Unknown pci_ers_result value");
> +		return 0;
> +	}
> +};
> +
> +static enum pci_ers_result merge_result(enum pci_ers_result old,
> +					enum pci_ers_result new)
> +{
> +	if (eeh_result_priority(new) > eeh_result_priority(old))
> +		return new;
> +	return old;

max() ?

cheers
