Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 2D05EDDEDC
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 06:33:44 +1000 (EST)
Date: Sun, 20 Jul 2008 15:33:33 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Mike Mason <mmlnx@us.ibm.com>
Subject: Re: [PATCH] Don't panic when EEH_MAX_FAILS is exceeded
Message-ID: <20080720203333.GQ9594@localdomain>
References: <488383D4.9000602@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <488383D4.9000602@us.ibm.com>
Cc: linasvepstas@gmail.com, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mike Mason wrote:
>
> This patch changes the EEH_MAX_FAILS action from panic to printing
> an error message.  Panicking under under this condition is too
> harsh.  Although performance will be affected and the device may not
> recover, the system is still running, which at the very least,
> should allow for a more graceful shutdown.  The panic() is now
> wrapped in a DEBUG statement for development purposes.  The patch
> also removes the msleep() within a spinlock, which is not allowed.

> @@ -509,18 +510,24 @@

For ease of review, please try to use diff -p to generate patches.

> 	rc = 1;
> 	if (pdn->eeh_mode & EEH_MODE_ISOLATED) {
> 		pdn->eeh_check_count ++;
> -		if (pdn->eeh_check_count >= EEH_MAX_FAILS) {
> -			printk (KERN_ERR "EEH: Device driver ignored %d bad reads, panicing\n",
> -			        pdn->eeh_check_count);
> +		if (pdn->eeh_check_count % EEH_MAX_FAILS == 0) {
> +			location = (char *) of_get_property(dn, "ibm,loc-code", NULL);

Unneeded cast here, I think.

> +			printk (KERN_ERR "EEH: %d reads ignored for recovering device at "
> +				"location=%s driver=%s pci addr=%s\n",
> +				pdn->eeh_check_count, location,
> +				dev->driver->name, pci_name(dev));
> +			printk (KERN_ERR "EEH: Might be infinite loop in %s driver\n",
> +				dev->driver->name);
> +#ifdef DEBUG
> 			dump_stack();
> -			msleep(5000);
> -			
> +
> 			/* re-read the slot reset state */
> 			if (read_slot_reset_state(pdn, rets) != 0)
> 				rets[0] = -1;	/* reset state unknown */
>
> 			/* If we are here, then we hit an infinite loop. Stop. */
> 			panic("EEH: MMIO halt (%d) on device:%s\n", rets[0], pci_name(dev));
> +#endif

While I tend to agree that panic() is unnecessary, don't we want a
stack dump unconditionally (i.e. not bracketed in #ifdef DEBUG)?

I'd prefer just removing the code instead of adding #ifdef's in the
middle of this function.  eeh.c needs less #ifdef DEBUG, not more :)
