Return-Path: <miltonm@us.ibm.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 585791007D2
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 17:17:41 +1000 (EST)
From: Milton Miller <miltonm@us.ibm.com>
Date: Wed, 9 Jun 2010 16:01:10 +1000
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: rtas_flash cannot be a module
Message-Id: <20100610-reply@mdm.bga.com>
In-Reply-To: <20100609060110.GM28295@kryten>
References: <20100609060110.GM28295@kryten>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 9 Jun 2010 at about 16:01:10 +1000 Anton Blanchard wrote:
> 
> When trying to flash a machine via the update_flash command, I received the
> following error:
> 
> 
>     Restarting system.
>     FLASH: kernel bug...flash list header addr above 4GB
> 
> 
> The code in question has a comment that the flash list should be in
> the kernel data and therefore under 4GB:
> 
>         /* NOTE: the "first" block list is a global var with no data
>          * blocks in the kernel data segment.  We do this because
>          * we want to ensure this block_list addr is under 4GB.
>          */
> 
> Unfortunately the Kconfig option is marked tristate which means the variable
> may not be in the kernel data and could be above 4GB.

So we should use that rtas_data_buf with its lock ...

Oh look, the driver already uses that buffer for the call to verify_flash

untested patch to follow

milton
