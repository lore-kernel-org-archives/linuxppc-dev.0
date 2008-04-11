Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4BB7BDE560
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 05:11:25 +1000 (EST)
Message-ID: <47FFB7F0.5030206@freescale.com>
Date: Fri, 11 Apr 2008 14:11:44 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH v2.6.26] gianfar: Determine TBIPA value dynamically
References: <1207870471-3601-1-git-send-email-afleming@freescale.com>
	<20080411153125.GA2588@loki.buserror.net>
	<1D6963B0-4EC5-41F7-8BFA-97C2C0647A13@freescale.com>
In-Reply-To: <1D6963B0-4EC5-41F7-8BFA-97C2C0647A13@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	paul.gortmaker@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andy Fleming wrote:
> I tried.  Technically, we can.  But the issue is that struct gfar 
> *enet_regs->gfar_mii_regs is declared:
> 
> u8 gfar_mii_regs[24];
> 
> I could not find any sequence of castings that made the warning go away 
> about casting that to a struct gfar_mii __iomem *.  And that includes 
> mucking around with the declaration of gfar_mii_regs.  I vaguely recall 
> determining that you couldn't make it a struct, because you can't 
> guarantee gcc won't much with the size of the struct.  Or something.  

We use structs for registers all over the place.  The only time GCC 
should mess with struct layout is if fields aren't aligned as required 
by the ABI (and in that case, use the packed attribute).

-Scott
