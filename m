Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de
	(static-ip-62-75-166-246.inaddr.intergenia.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0535DDECF
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Jun 2007 19:47:45 +1000 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch] powerpc: sysfs fix compiler warning
Date: Sat, 23 Jun 2007 11:46:54 +0200
References: <20070622194853.72fb652a@localhost>
In-Reply-To: <20070622194853.72fb652a@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200706231146.54959.mb@bu3sch.de>
Cc: Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 22 June 2007 19:48:53 Christian Krafft wrote:
> From: Christian Krafft <krafft@de.ibm.com>
> 
> This patch fixes the following compiler warning:
> arch/powerpc/kernel/sysfs.c:385: warning: ignoring return value of
> `sysfs_create_group',
> 
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> 
> Index: linux-2.6.22-rc5/arch/powerpc/kernel/sysfs.c
> ===================================================================
> --- linux-2.6.22-rc5.orig/arch/powerpc/kernel/sysfs.c
> +++ linux-2.6.22-rc5/arch/powerpc/kernel/sysfs.c
> @@ -380,16 +380,23 @@ int cpu_add_sysdev_attr_group(struct att
>  {
>  	int cpu;
>  	struct sys_device *sysdev;
> +	int error;
>  
>  	mutex_lock(&cpu_mutex);
>  
>  	for_each_possible_cpu(cpu) {
>  		sysdev = get_cpu_sysdev(cpu);
> -		sysfs_create_group(&sysdev->kobj, attrs);
> +		error |= sysfs_create_group(&sysdev->kobj, attrs);

That is probably dangerous, if multiple sysfs_create_group fail
with different error codes. So it will wiggle the error codes
together.

>  	}
>  
> +	if(error)
 {
> +		for_each_possible_cpu(cpu) {
> +			sysdev = get_cpu_sysdev(cpu);
> +			sysfs_remove_group(&sysdev->kobj, attrs);
> +		}
probably do something like
		error = -ENOENT;
 }
or some other error code here to fix it.
> +
>  	mutex_unlock(&cpu_mutex);
> -	return 0;
> +	return error;
>  }
>  EXPORT_SYMBOL_GPL(cpu_add_sysdev_attr_group);
>  
> 
> 



-- 
Greetings Michael.
