Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id 77F2FDDE21
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 21:33:35 +1100 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: paulus@samba.org
Subject: Re: [PATCH] ppc: i8259 of_node_get cleanup
Date: Tue, 9 Jan 2007 11:33:52 +0100
References: <200701021247.42035.m.kozlowski@tuxland.pl>
In-Reply-To: <200701021247.42035.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200701091133.52438.m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

> 	This patch removes redundant argument check for of_node_get().
> 
> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> 
>  arch/powerpc/sysdev/i8259.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff -upr linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/i8259.c linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/i8259.c
> --- linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/i8259.c	2006-12-24 05:00:32.000000000 +0100
> +++ linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/i8259.c	2007-01-02 02:03:57.000000000 +0100
> @@ -276,8 +276,7 @@ void i8259_init(struct device_node *node
>  	spin_unlock_irqrestore(&i8259_lock, flags);
>  
>  	/* create a legacy host */
> -	if (node)
> -		i8259_node = of_node_get(node);
> +	i8259_node = of_node_get(node);
>  	i8259_host = irq_alloc_host(IRQ_HOST_MAP_LEGACY, 0, &i8259_host_ops, 0);
>  	if (i8259_host == NULL) {
>  		printk(KERN_ERR "i8259: failed to allocate irq host !\n");

Paul, this patch is invalid as I overlooked the code comment that says it must allow node
be NULL. On the other hand it's never called with node == NULL. So either the comment
should change or do not apply this patch.

-- 
Regards,

	Mariusz Kozlowski
