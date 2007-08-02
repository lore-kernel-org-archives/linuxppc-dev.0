Return-Path: <kim.phillips@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8C7AEDDDF3
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 10:20:36 +1000 (EST)
Date: Wed, 1 Aug 2007 19:20:09 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: "Keith Mund" <keith.mund@clearcube.com>
Subject: Re: MPC83xx - previous patch to set MBAR
Message-Id: <20070801192009.656fc2e0.kim.phillips@freescale.com>
In-Reply-To: <5EACFDEA24DADE42BF109303D305A8093120A6@MAIL.clearcube.com>
References: <20070801133056.GP3972@stusta.de>
	<fa686aa40708010653v7e1fb909gb03eb1d4754359bf@mail.gmail.com>
	<5EACFDEA24DADE42BF109303D305A8093120A6@MAIL.clearcube.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, u-boot-users@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 1 Aug 2007 15:20:22 -0500
"Keith Mund" <keith.mund@clearcube.com> wrote:

> There was a u-boot 1.1.3 patch for start.S posted on the Freescale LTIB

posts concerning u-boot should go to the u-boot-users list (cc'd).

> site:
> http://www.bitshrine.org/gpp/u-boot-1.1.3-mpc83xx-cpu-4.patch
> 
> The end result simply adds a line to set MBAR to match IMMRBAR.
> 
>         lis     r3, CFG_IMMRBAR@h
>         ori     r3, r3, CFG_IMMRBAR@l
>         stw     r3, IMMRBAR(r4)
> +       mtspr   MBAR, r3
> 
> Are these patches routinely added to the mainstream u-boot code? 
> 
> Is there any reason why this fix is not a good idea?
> 
does setting MBAR really fix anything?

MBAR doesn't live up to its name.  It's a general-purpose scratch
register - the hardware doesn't do anything with it.  So, wrt integrity
within u-boot itself, I see no point/value in setting it.  If some
piece of software needs temporary storage, it can set it and use it as
it wishes, independent of u-boot.

Kim
