Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44917B7D0A
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jan 2010 11:04:56 +1100 (EST)
Subject: Re: [PATCH 2/2] eeh: fixing pci_dev dependency
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: leitao@linux.vnet.ibm.com
In-Reply-To: <930155d7427ae670cd2add220649c6490f68d0d4.1264617281.git.root@sanx1002.austin.ibm.com>
References: <0642ead63df1b9fdced24750eb0aea940f0408b7.1264617281.git.root@sanx1002.austin.ibm.com>
	<930155d7427ae670cd2add220649c6490f68d0d4.1264617281.git.root@sanx1002.austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 29 Jan 2010 11:04:47 +1100
Message-ID: <1264723487.20211.17.camel@pasglop>
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
> Currently pci_dev can be null when EEH is in action. This patch
> just assure that we pci_dev is not NULL before calling pci_dev_put.

Like all variants of *_put(), it already checks for a NULL argument
afaik. So that patch should be unnecessary.

Cheers,
Ben.
 
> Signed-off-by: Breno Leitao <leitao@linux.vnet.ibm.com>
> Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>
> ---
>  arch/powerpc/platforms/pseries/eeh_event.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/eeh_event.c b/arch/powerpc/platforms/pseries/eeh_event.c
> index ec5df8f..7956e46 100644
> --- a/arch/powerpc/platforms/pseries/eeh_event.c
> +++ b/arch/powerpc/platforms/pseries/eeh_event.c
> @@ -85,7 +85,8 @@ static int eeh_event_handler(void * dummy)
>  	pdn = handle_eeh_events(event);
>  
>  	eeh_clear_slot(event->dn, EEH_MODE_RECOVERING);
> -	pci_dev_put(event->dev);
> +	if (event->dev)
> +		pci_dev_put(event->dev);
>  	kfree(event);
>  	mutex_unlock(&eeh_event_mutex);
>  
