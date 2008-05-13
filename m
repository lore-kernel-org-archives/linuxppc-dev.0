Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02F06DDDEF
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 15:16:18 +1000 (EST)
Message-ID: <48292419.6010302@garzik.org>
Date: Tue, 13 May 2008 01:16:09 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Hannes Hering <hannes.hering@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/3] [2.6.26] memory: Introduce exports for memory
	notifiers
References: <200805071443.02145.hannes.hering@linux.vnet.ibm.com>
In-Reply-To: <200805071443.02145.hannes.hering@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tklein@de.ibm.com, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, raisch@de.ibm.com,
	ossrosch@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, ossthema@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hannes Hering wrote:
> This patch introduces two exports to allow modules to use memory notifiers.
> 
> Signed-off-by: Hannes Hering <hering2@de.ibm.com>
> ---
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 8ce6de5..937e825 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -53,11 +53,13 @@ int register_memory_notifier(struct notifier_block *nb)
>  {
>          return blocking_notifier_chain_register(&memory_chain, nb);
>  }
> +EXPORT_SYMBOL(register_memory_notifier);
>  
>  void unregister_memory_notifier(struct notifier_block *nb)
>  {
>          blocking_notifier_chain_unregister(&memory_chain, nb);
>  }
> +EXPORT_SYMBOL(unregister_memory_notifier);

applied 1-3
