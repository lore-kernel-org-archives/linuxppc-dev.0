Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de
	(static-ip-62-75-166-246.inaddr.intergenia.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 136E2DDFCA
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 00:58:11 +1000 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [patch] powerpc: sysfs fix compiler warning
Date: Fri, 29 Jun 2007 16:57:20 +0200
References: <20070629165010.1ec5f082@localhost>
In-Reply-To: <20070629165010.1ec5f082@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200706291657.20942.mb@bu3sch.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 29 June 2007 16:50:10 Christian Krafft wrote:
> From: Christian Krafft <krafft@de.ibm.com>
> 
> This patch fixes the following compiler warning:
> arch/powerpc/kernel/sysfs.c:385: warning: ignoring return value of
> `sysfs_create_group',
> 
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> 
> --- linux-2.6.orig/arch/powerpc/kernel/sysfs.c
> +++ linux-2.6/arch/powerpc/kernel/sysfs.c
> @@ -380,16 +380,25 @@ int cpu_add_sysdev_attr_group(struct att
>  {
>  	int cpu;
>  	struct sys_device *sysdev;
> +	int error = 0;
>  
>  	mutex_lock(&cpu_mutex);
>  
>  	for_each_possible_cpu(cpu) {
>  		sysdev = get_cpu_sysdev(cpu);
> -		sysfs_create_group(&sysdev->kobj, attrs);
> +		error = sysfs_create_group(&sysdev->kobj, attrs);
> +
> +		if (error) {
> +			for_each_possible_cpu(cpu) {
> +				sysdev = get_cpu_sysdev(cpu);
> +				sysfs_remove_group(&sysdev->kobj, attrs);

Is sysfs_remove_group() safe to call on kobjs for which
we did not call sysfs_create_group()?

> +			}
> +			break;
> +		}
>  	}
>  
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
