Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 399FADDFBB
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 12:57:44 +1100 (EST)
Date: Tue, 20 Mar 2007 21:11:49 -0500
To: anton@samba.org
Subject: Re: [patch 10/10] Make sure we only enable xmon once
Message-ID: <20070321021149.GA2564@lixom.net>
References: <20070321013810.404636000@samba.org>
	<20070321013825.735752000@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070321013825.735752000@samba.org>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 20, 2007 at 08:38:20PM -0500, anton@samba.org wrote:
> Now we use notifier hooks we have to be careful not to enable xmon multiple
> times.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
> 
> Index: linux-2.6/arch/powerpc/xmon/xmon.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/xmon/xmon.c	2007-03-11 14:52:45.000000000 -0500
> +++ linux-2.6/arch/powerpc/xmon/xmon.c	2007-03-11 14:56:37.000000000 -0500
> @@ -2658,11 +2658,20 @@
>  	unregister_page_fault_notifier(&xmon_page_fault_nb);
>  }
>  
> +#ifdef CONFIG_XMON_DEFAULT
> +int __initdata xmon_on = 1;
> +#else
> +int __initdata xmon_on = 0;
> +#endif

This shouldn't be __initdata, should it? It's used at runtime below.

> +
>  #ifdef CONFIG_MAGIC_SYSRQ
>  static void sysrq_handle_xmon(int key, struct tty_struct *tty) 
>  {
>  	/* ensure xmon is enabled */
> -	xmon_enable();
> +	if (!xmon_on) {
> +		xmon_on = 1;
> +		xmon_enable();
> +	}
>  	xmon(get_irq_regs());
>  }
[...]



-Olof
