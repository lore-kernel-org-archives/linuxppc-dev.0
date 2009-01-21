Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5551ADDED6
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 05:13:30 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0LIDQKN019518
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 11:13:27 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n0LIDPIK001728
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 12:13:26 -0600 (CST)
Date: Wed, 21 Jan 2009 12:13:24 -0600
From: Scott Wood <scottwood@freescale.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc: more printing warning fixes for the l64 to ll64
	conversion
Message-ID: <20090121181324.GA32224@ld0162-tx32.am.freescale.net>
References: <20090121111651.7d6e87ec.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090121111651.7d6e87ec.sfr@canb.auug.org.au>
Cc: Nick Spence <nick.spence@freescale.com>, linuxppc-dev@ozlabs.org,
	Egor Martovetsky <egor@pasemi.com>, Paul Mackerras <paulus@samba.org>,
	Doug Thompson <dougthompson@xmission.com>,
	Olof Johansson <olof@lixom.net>, linux-mtd@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 21, 2009 at 11:16:51AM +1100, Stephen Rothwell wrote:
> -	printk(KERN_INFO "eLBC NAND device at 0x%zx, bank %d\n",
> +	printk(KERN_INFO "eLBC NAND device at 0x%llx, bank %d\n",
>  	       res.start, priv->bank);

This won't work if resource_size_t is 32-bit; it needs a cast.

ACK the other two fsl_elbc fixes.

-Scott
