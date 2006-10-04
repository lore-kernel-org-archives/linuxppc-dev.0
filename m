Return-Path: <jeremy@goop.org>
Received: from mail.goop.org (gw.goop.org [64.81.55.164])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.goop.org", Issuer "Goop.org CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 62A6967C9A
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 06:39:16 +1000 (EST)
Message-ID: <45241659.301@goop.org>
Date: Wed, 04 Oct 2006 13:15:21 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
To: Judith Lebzelter <judith@osdl.org>
Subject: Re: [PATCH] use-generic-bug-for-ppc
References: <20061004184927.GH665@shell0.pdx.osdl.net>
In-Reply-To: <20061004184927.GH665@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Judith Lebzelter wrote:
> Index: linux/arch/ppc/kernel/traps.c
> ===================================================================
> --- linux.orig/arch/ppc/kernel/traps.c	2006-10-03 16:11:26.461653713 -0700
> +++ linux/arch/ppc/kernel/traps.c	2006-10-04 10:00:21.198907987 -0700
> @@ -28,6 +28,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/prctl.h>
> +#include <linux/bug.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/uaccess.h>
> @@ -568,55 +569,9 @@
>   */
>  extern struct bug_entry __start___bug_table[], __stop___bug_table[];
>  
> -#ifndef CONFIG_MODULES
> -#define module_find_bug(x)	NULL
> -#endif
>   
Looks like you need to delete a bit more here - the extern struct 
bug_entry, and the comment above.
    J
