Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id DB132DDED4
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Nov 2007 06:27:21 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCHv2] powerpc: Move CPM command handling into the cpm
	drivers
Date: Sat, 24 Nov 2007 20:27:09 +0100
References: <4748788C.7020706@scram.de>
In-Reply-To: <4748788C.7020706@scram.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711242027.10396.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 24 November 2007, Jochen Friedrich wrote:
> This patch moves the CPM command handling into commproc.c
> for CPM1 and cpm2_common.c. This is yet another preparation
> to get rid of drivers accessing the CPM via the global cpmp.

good stuff, just a little nitpicking below:

> +DEFINE_SPINLOCK(cmd_lock);

This should probably be a static variable. The name is too generic
for a global identifier. If every use of the command register
goes through the cpm_command function, you could even make it
a static variable in that function.

> +int cpm_command(u32 command, u8 opcode)
> +{
> +	int i;
> +	unsigned long flags;
> +
> +	if (command & 0xffffff0f)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&cmd_lock, flags);
> +
> +	out_be16(&cpmp->cp_cpcr, command | CPM_CR_FLG | (opcode << 8));
> +	for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
> +		if ((in_be16(&cpmp->cp_cpcr) & CPM_CR_FLG) == 0) {
> +			spin_unlock_irqrestore(&cmd_lock, flags);
> +			return 0;
> +		}

Error handling in here is nicer if you do a goto that jumps to the
unlock below. If the code ever gets more complex, this makes it easier
to check if it's correct regarding locking.

> +	printk(KERN_ERR "%s(): Not able to issue CPM command\n", __FUNCTION__);
> +	spin_unlock_irqrestore(&cmd_lock, flags);
> +	return -EIO;
> +}
> +EXPORT_SYMBOL(cpm_command);

Why not EXPORT_SYMBOL_GPL?
  
> +DEFINE_SPINLOCK(cmd_lock);

see above

> +
> +#define MAX_CR_CMD_LOOPS        10000
> +
> +int cpm_command(u32 command, u8 opcode)
> +{
> +	int i;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cmd_lock, flags);
> +
> +	out_be32(&cpmp->cp_cpcr, command | opcode | CPM_CR_FLG);
> +	for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
> +		if ((in_be32(&cpmp->cp_cpcr) & CPM_CR_FLG) == 0) {
> +			spin_unlock_irqrestore(&cmd_lock, flags);
> +			return 0;
> +		}
> +
> +	printk(KERN_ERR "%s(): Not able to issue CPM command\n", __FUNCTION__);
> +	spin_unlock_irqrestore(&cmd_lock, flags);
> +	return -EIO;
> +}
> +EXPORT_SYMBOL(cpm_command);

see above

	Arnd <><
