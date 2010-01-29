Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2CA40B7D03
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jan 2010 11:04:08 +1100 (EST)
Subject: Re: [PATCH 1/2] eeh: Fixing a bug when pci structure is null
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: leitao@linux.vnet.ibm.com
In-Reply-To: <0642ead63df1b9fdced24750eb0aea940f0408b7.1264617281.git.root@sanx1002.austin.ibm.com>
References: <0642ead63df1b9fdced24750eb0aea940f0408b7.1264617281.git.root@sanx1002.austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 29 Jan 2010 11:03:50 +1100
Message-ID: <1264723430.20211.16.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Linas Vepstas <linasvepstas@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-01-27 at 12:43 -0600, leitao@linux.vnet.ibm.com wrote:

> diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
> index ef8e454..afdddf6 100644
> --- a/arch/powerpc/platforms/pseries/eeh_driver.c
> +++ b/arch/powerpc/platforms/pseries/eeh_driver.c
> @@ -41,6 +41,13 @@ static inline const char * pcid_name (struct pci_dev *pdev)
>  	return "";
>  }
>  
> +inline const char *eeh_pci_name(struct pci_dev *pdev)
> +{
> +        if (NULL==pdev)
> +                return "<null>";
> +        return pci_name(pdev);
> +}
> +

Coding style gack ... just make it static inline in the header file.

Cheers,
Ben.
