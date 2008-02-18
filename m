Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B8705DDEF5
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 01:17:58 +1100 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [PATCH] next-20080218 build failure at pmac_ide_macio_attach ()
References: <20080218140159.GA31310@linux.vnet.ibm.com>
Date: Mon, 18 Feb 2008 15:17:49 +0100
In-Reply-To: <20080218140159.GA31310@linux.vnet.ibm.com> (Kamalesh Babulal's
	message of "Mon\, 18 Feb 2008 19\:31\:59 +0530")
Message-ID: <jeodae4acy.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linux-ide@vger.kernel.org, sfr@canb.auug.org.au,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> writes:

> --- linux-2.6.25-rc1/drivers/ide/ppc/pmac.c	2008-02-18 18:41:48.000000000 +0530
> +++ linux-2.6.25-rc1/drivers/ide/ppc/~pmac.c	2008-02-18 19:20:37.000000000 +0530
> @@ -1091,7 +1091,7 @@ pmac_ide_macio_attach(struct macio_dev *
>  	int irq, rc;
>  	hw_regs_t hw;
>  
> -	pmif = (struct pmac_ide_hwif)kzalloc(sizeof(*pmif), GFP_KERNEL);
> +	pmif = (struct pmac_ide_hwif*)kzalloc(sizeof(*pmif), GFP_KERNEL);

Just remove the cast.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
