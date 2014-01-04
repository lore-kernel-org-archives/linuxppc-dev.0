Return-Path: <groeck7@gmail.com>
Received: from mail-pd0-x233.google.com (mail-pd0-x233.google.com
 [IPv6:2607:f8b0:400e:c02::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1B0542C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Jan 2014 06:15:42 +1100 (EST)
Received: by mail-pd0-f179.google.com with SMTP id r10so16618338pdi.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Jan 2014 11:15:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 4 Jan 2014 11:15:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Anton Blanchard <anton@samba.org>
Subject: Re: drivers/tty: ehv_bytechan fails to build as a module
Message-ID: <20140104191537.GA9051@roeck-us.net>
References: <20131209160310.7f81a1bc@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20131209160310.7f81a1bc@kryten>
Cc: gregkh@linuxfoundation.org, dvaleev@suse.com, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 09, 2013 at 04:03:10PM +1100, Anton Blanchard wrote:
> ehv_bytechan is marked tristate but fails to build as a module:
> 
> drivers/tty/ehv_bytechan.c:363:1: error: type defaults to ‘int’ in declaration of ‘console_initcall’ [-Werror=implicit-int]
> 
> It doesn't make much sense for a console driver to be built as
> a module, so change it to a bool.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> 

Any comments on this patch ? The problem still causes powerpc:allmodconfig to
fail.

Guenter

> ---
> 
> 
> Index: b/drivers/tty/Kconfig
> ===================================================================
> --- a/drivers/tty/Kconfig
> +++ b/drivers/tty/Kconfig
> @@ -366,7 +366,7 @@ config TRACE_SINK
>  	  "Trace data router for MIPI P1149.7 cJTAG standard".
>  
>  config PPC_EPAPR_HV_BYTECHAN
> -	tristate "ePAPR hypervisor byte channel driver"
> +	bool "ePAPR hypervisor byte channel driver"
>  	depends on PPC
>  	select EPAPR_PARAVIRT
>  	help
