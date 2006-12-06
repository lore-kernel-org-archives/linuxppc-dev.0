Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id DFBEB67BD9
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 23:19:30 +1100 (EST)
Message-ID: <4576B5AE.90508@ru.mvista.com>
Date: Wed, 06 Dec 2006 15:21:02 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH] powerpc: fix build error in rom.c
References: <45760109.8030200@am.sony.com>
In-Reply-To: <45760109.8030200@am.sony.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: dwmw2@redhat.com, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Geoff Levand wrote:

> Add missing include in rom.c.  Fixes this build error when CONFIG_MTD=y:

>   arch/powerpc/sysdev/rom.c:26: error: implicit declaration of function of_platform_device_create

    Uh oh, that's what happens when someone doesn't respin the patches quickly 
enough. Finally, the obsolete version has been committed -- it also misses one 
property in the node spec and "reg" was called "regs" there...

> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> ---
>  arch/powerpc/sysdev/rom.c |    1 +
>  1 files changed, 1 insertion(+)
> 
> --- linux-2.6.19.ppc64.orig/arch/powerpc/sysdev/rom.c
> +++ linux-2.6.19.ppc64/arch/powerpc/sysdev/rom.c
> @@ -9,6 +9,7 @@
>  
>  #include <linux/kernel.h>
>  #include <asm/of_device.h>
> +#include <asm/of_platform.h>
>  
>  static int __init powerpc_flash_init(void)
>  {

WBR, Sergei
