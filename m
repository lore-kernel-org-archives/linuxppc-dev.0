Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 99757DDF18
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 02:52:52 +1100 (EST)
Message-ID: <474AEBD2.3040504@freescale.com>
Date: Mon, 26 Nov 2007 09:52:50 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [RFC/PATCHv3] powerpc: Move CPM command handling into the cpm
	drivers
References: <474886C2.7030609@scram.de>
In-Reply-To: <474886C2.7030609@scram.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jochen Friedrich wrote:
> diff --git a/arch/powerpc/sysdev/commproc.c 
> b/arch/powerpc/sysdev/commproc.c
> index f6a6378..2426bcb 100644
> --- a/arch/powerpc/sysdev/commproc.c
> +++ b/arch/powerpc/sysdev/commproc.c
> @@ -240,6 +240,34 @@ void __init cpm_reset(void)
> #endif
> }
> 
> +static DEFINE_SPINLOCK(cmd_lock);
> +
> +#define MAX_CR_CMD_LOOPS        10000
> +
> +int cpm_command(u32 command, u8 opcode)
> +{
> +    int i, ret;
> +    unsigned long flags;
> +
> +    if (command & 0xffffff0f)
> +        return -EINVAL;
> +
> +    spin_lock_irqsave(&cmd_lock, flags);

I'm a little uneasy about this -- what's the longest it can take for the 
CPM command to complete (or timeout)?  I'd rather use a mutex, if we can 
make sure that it's never called from atomic context.

> +
> +    ret = 0;
> +    out_be16(&cpmp->cp_cpcr, command | CPM_CR_FLG | (opcode << 8));
> +    for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
> +        if ((in_be16(&cpmp->cp_cpcr) & CPM_CR_FLG) == 0)
> +            goto out;
> +
> +    printk(KERN_ERR "%s(): Not able to issue CPM command\n", 
> __FUNCTION__);
> +    ret = -EIO;
> +out:
> +    spin_unlock_irqrestore(&cmd_lock, flags);
> +    return ret;
> +}
> +EXPORT_SYMBOL_GPL(cpm_command);

Can we please not play the GPL DRM game here?

Besides, Documentation/DocBook/kernel-hacking.tmpl explicitly says that 
"It implies that the function is considered an internal implementation 
issue, and not really an interface."

I don't think this is the case here.

-Scott
