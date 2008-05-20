Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 04835DE718
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 05:32:27 +1000 (EST)
Date: Tue, 20 May 2008 14:33:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: [PATCH] Fix cpm uart corruption with PREEMPT_RT
Message-ID: <20080520193307.GA32130@loki.buserror.net>
References: <20080520192816.7F7E15AF22@innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080520192816.7F7E15AF22@innovsys.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 20, 2008 at 02:28:16PM -0500, Rune Torgersen wrote:
> Fix CPM serial port corruption when running with CONFIG_PREEMPT_RT.
> Userland usage of console, and kernel printf's were stepping on each others toes.
> 
> Signed-off-by: Rune Torgersen <runet@innovsys.com>
> 
> diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
> index fb93403..79c109d 100755
> --- a/drivers/serial/cpm_uart/cpm_uart_core.c
> +++ b/drivers/serial/cpm_uart/cpm_uart_core.c
> @@ -1214,7 +1214,9 @@ static void cpm_uart_console_write(struct console *co, const char *s,
>  	unsigned int i;
>  	cbd_t __iomem *bdp, *bdbase;
>  	unsigned char *cp;
> +	unsigned long flags;
>  
> +	spin_lock_irqsave(&pinfo->port.lock, flags);
>  	/* Get the address of the host memory buffer.
>  	 */
>  	bdp = pinfo->tx_cur;
> @@ -1282,6 +1284,8 @@ static void cpm_uart_console_write(struct console *co, const char *s,
>  		;
>  
>  	pinfo->tx_cur = bdp;
> +
> +	spin_unlock_irqrestore(&pinfo->port.lock, flags);
>  }

We should bypass the lock when oops_in_progress is set, something like:

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index a19dc7e..bc45f8a 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1178,6 +1178,14 @@ static void cpm_uart_console_write(struct console *co, const char *s,
 	unsigned int i;
 	cbd_t __iomem *bdp, *bdbase;
 	unsigned char *cp;
+	unsigned long flags;
+	int nolock = oops_in_progress;
+
+	if (unlikely(nolock)) {
+		local_irq_save(flags);
+	} else {
+		spin_lock_irqsave(&pinfo->port.lock, flags);
+	}
 
 	/* Get the address of the host memory buffer.
 	 */
@@ -1239,8 +1247,13 @@ static void cpm_uart_console_write(struct console *co, const char *s,
 		;
 
 	pinfo->tx_cur = bdp;
-}
 
+	if (unlikely(nolock)) {
+		local_irq_restore(flags);
+	} else {
+		spin_unlock_irqrestore(&pinfo->port.lock, flags);
+	}
+}
 
 static int __init cpm_uart_console_setup(struct console *co, char *options)
 {

-Scott
