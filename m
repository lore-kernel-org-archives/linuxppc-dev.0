Return-Path: <dsd@gentoo.org>
Received: from queue02-winn.ispmail.ntl.com (queue02-winn.ispmail.ntl.com
	[81.103.221.56]) by ozlabs.org (Postfix) with ESMTP id 10ACA6816B
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Sep 2005 08:12:37 +1000 (EST)
Message-ID: <431755E4.70703@gentoo.org>
Date: Thu, 01 Sep 2005 20:26:28 +0100
From: Daniel Drake <dsd@gentoo.org>
MIME-Version: 1.0
To: Stelian Pop <stelian@popies.net>
References: <jehdda2tqt.fsf@sykes.suse.de>	
	<1125288175.5595.3.camel@localhost.localdomain>
	<1125311951.4662.3.camel@localhost.localdomain>
In-Reply-To: <1125311951.4662.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
	Alex Williamson <alex.williamson@hp.com>, linuxppc-dev@ozlabs.org
Subject: Re: 2.6.13-rc7-git2 crashes on iBook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Stelian Pop wrote:
> Confirmed on an Apple Powerbook too.
> 
> For reference, the (already reverted) patch which needs to be applied is
> below.
> 
> Signed-off-by: Stelian Pop <stelian@popies.net>
> 
> Index: linux-2.6.git/drivers/pci/setup-res.c
> ===================================================================
> --- linux-2.6.git.orig/drivers/pci/setup-res.c	2005-08-29 10:03:00.000000000 +0200
> +++ linux-2.6.git/drivers/pci/setup-res.c	2005-08-29 12:23:20.980716336 +0200
> @@ -53,9 +53,7 @@
>  	if (resno < 6) {
>  		reg = PCI_BASE_ADDRESS_0 + 4 * resno;
>  	} else if (resno == PCI_ROM_RESOURCE) {
> -		if (!(res->flags & IORESOURCE_ROM_ENABLE))
> -			return;
> -		new |= PCI_ROM_ADDRESS_ENABLE;
> +		new |= res->flags & IORESOURCE_ROM_ENABLE;
>  		reg = dev->rom_base_reg;
>  	} else {
>  		/* Hmm, non-standard resource. */
> 

Sorry for my ignorance. Which tree was this reverted in? You are probably 
aware that this bug made it into 2.6.13 (patch was not reverted there).

Daniel
