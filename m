Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 393B4DDE02
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 07:43:22 +1100 (EST)
Subject: Re: [Patch 0/2] powerpc: avoid userspace poking to legacy ioports
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Krafft <krafft@de.ibm.com>
In-Reply-To: <20080213183506.7f3e3145@de.ibm.com>
References: <20080213182800.5c6940a8@de.ibm.com>
	<20080213183506.7f3e3145@de.ibm.com>
Content-Type: text/plain
Date: Thu, 14 Feb 2008 07:42:54 +1100
Message-Id: <1202935374.7296.44.camel@pasglop>
Mime-Version: 1.0
Cc: parabelboi@bopserverein.de, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-02-13 at 18:35 +0100, Christian Krafft wrote:
> sensors_detect crashes kernel on PowerPC, as it pokes directly to memory.
> This patch adds a check_legacy_ioports to read_port and write_port.
> It will now return ENXIO, instead of oopsing.
> 
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>

The problem is that this prevents using /proc/ioports to access PCI
IO space, which might be useful.

I hate that sensors_detect.. or for that matter any other userland code
that pokes random ports like that. It should die.

Ben.

> Index: linux.git/drivers/char/mem.c
> ===================================================================
> --- linux.git.orig/drivers/char/mem.c
> +++ linux.git/drivers/char/mem.c
> @@ -566,8 +566,13 @@ static ssize_t read_port(struct file * f
>  	char __user *tmp = buf;
>  
>  	if (!access_ok(VERIFY_WRITE, buf, count))
> -		return -EFAULT; 
> +		return -EFAULT;
> +
>  	while (count-- > 0 && i < 65536) {
> +#ifdef CONFIG_PPC_MERGE
> +		if (check_legacy_ioport(i))
> +			return -ENXIO;
> +#endif
>  		if (__put_user(inb(i),tmp) < 0) 
>  			return -EFAULT;  
>  		i++;
> @@ -585,6 +590,7 @@ static ssize_t write_port(struct file * 
>  
>  	if (!access_ok(VERIFY_READ,buf,count))
>  		return -EFAULT;
> +
>  	while (count-- > 0 && i < 65536) {
>  		char c;
>  		if (__get_user(c, tmp)) {
> @@ -592,6 +598,10 @@ static ssize_t write_port(struct file * 
>  				break;
>  			return -EFAULT; 
>  		}
> +#ifdef CONFIG_PPC_MERGE
> +		if (check_legacy_ioport(i))
> +			return -ENXIO;
> +#endif
>  		outb(c,i);
>  		i++;
>  		tmp++;
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
