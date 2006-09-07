Return-Path: <rsa@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8412E67B94
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Sep 2006 06:40:38 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k87KeYdA026533
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 16:40:34 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k87KeYig287544
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 16:40:34 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k87KeXDx013398
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Sep 2006 16:40:33 -0400
Subject: Re: [PATCH] powerpc: Quiet hvc_console console output on failed opens
From: Ryan Arnold <rsa@us.ibm.com>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20060907151808.2295ad9a@localhost.localdomain>
References: <20060907151808.2295ad9a@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 15:38:58 -0500
Message-Id: <1157661538.25088.235.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-09-07 at 15:18 -0500, Olof Johansson wrote:
> Hi,
> 
> Please consider for the 2.6.19 queue:
> 
> 
> 
> No other tty driver will print on the console when the open of it fails.
> 
> On systems that happen to be configured for both ttyS0 and hvc0 console,
> this will keep flooding the console output.  This is most likely to
> happen with systems booted between with and without hypervisor from the
> same filesystem.
> 
> Let's just remove it. When it's really needed (i.e. when the open fails
> and someone is trying to debug it), noone will see the output anyway. And
> init will report the opens failing in due time through the syslog.
> 
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> Index: merge/drivers/char/hvc_console.c
> ===================================================================
> --- merge.orig/drivers/char/hvc_console.c
> +++ merge/drivers/char/hvc_console.c
> @@ -320,10 +320,8 @@ static int hvc_open(struct tty_struct *t
>  	struct kobject *kobjp;
>  
>  	/* Auto increments kobject reference if found. */
> -	if (!(hp = hvc_get_by_index(tty->index))) {
> -		printk(KERN_WARNING "hvc_console: tty open failed, no vty associated with tty.\n");
> +	if (!(hp = hvc_get_by_index(tty->index)))
>  		return -ENODEV;
> -	}
>  
>  	spin_lock_irqsave(&hp->lock, flags);
>  	/* Check and then increment for fast path open. */

This seems like a good fix to me.  I think it is a debug artifact
anyway.

-- 
Ryan S. Arnold <rsa@us.ibm.com>
IBM Linux Technology Center
Linux on Power Toolchain
