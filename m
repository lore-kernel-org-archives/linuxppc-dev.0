Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ccJ912KYzF0PW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 13:02:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 11/13] powerpc/eeh: Introduce eeh_set_irq_state()
In-Reply-To: <facebfcf7726c381957cc5fac0fc9510ac27c472.1525242772.git.sbobroff@linux.ibm.com>
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
 <facebfcf7726c381957cc5fac0fc9510ac27c472.1525242772.git.sbobroff@linux.ibm.com>
Date: Fri, 04 May 2018 13:02:32 +1000
Message-ID: <87vac486nr.fsf@concordia.ellerman.id.au>
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
> index f63a01d336ee..b3edd0df04b8 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -210,6 +206,23 @@ static void eeh_set_channel_state(struct eeh_pe *root, enum pci_channel_state s)
>  				edev->pdev->error_state = s;
>  }
>  
> +static void eeh_set_irq_state(struct eeh_pe *root, bool enable)
> +{
> +	struct eeh_pe *pe;
> +	struct eeh_dev *edev, *tmp;
> +
> +	eeh_for_each_pe(root, pe)
> +		eeh_pe_for_each_dev(pe, edev, tmp)
> +			if (eeh_edev_actionable(edev))
> +				if (eeh_pcid_get(edev->pdev)) {
> +					if (enable)
> +						eeh_enable_irq(edev);
> +					else
> +						eeh_disable_irq(edev);
> +					eeh_pcid_put(edev->pdev);
> +				}

Yikes.

What about?

	eeh_for_each_pe(root, pe) {
		eeh_pe_for_each_dev(pe, edev, tmp) {
			if (!eeh_edev_actionable(edev))
				continue;

			if (!eeh_pcid_get(edev->pdev))
				continue;

			if (enable)
				eeh_enable_irq(edev);
			else
				eeh_disable_irq(edev);

			eeh_pcid_put(edev->pdev);
		}
	}

cheers
