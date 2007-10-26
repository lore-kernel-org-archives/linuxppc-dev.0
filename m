Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2D651DDE3B
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 05:39:59 +1000 (EST)
Date: Fri, 26 Oct 2007 14:40:05 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: reg adjust_total_lowmem
Message-ID: <20071026194005.GA4571@loki.buserror.net>
References: <4dd2a2ce0710252051pe83a943q48f52d148f5a9603@mail.gmail.com>
	<524E69ED-899B-452F-B593-44499C5181A3@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <524E69ED-899B-452F-B593-44499C5181A3@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Surya Ravikiran <koduks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 26, 2007 at 10:04:19AM -0500, Kumar Gala wrote:
> 
> On Oct 25, 2007, at 10:51 PM, Surya Ravikiran wrote:
> 
> > Hi,
> >
> > I am trying to bootup a Linux kernel, on a FS eval board with 256M.
> > I pass the kernel argument mem=252M, and see that the kernel boots up
> > fine, but with much less memory, ~192M (the closes 64M multiple), and
> > I browsed through the code to see that the adjust_total_lowmem
> > function does not add up the residual memory to the total memory.
> > I am trying to understand why I cannot do this reserving of higher end
> > of the RAM during boot up,
> > I would appreciate your comments.
> 
> The reason you have 192M is that lowmem is the total amount of memory  
> that can be covered by up to three CAM entries.  In the case of  
> setting mem=252M that max that three CAM entries can cover is 192M (64 
> +64+64).  You should be able to access the other 60M via HIGHMEM.

Why doesn't it just use a 256M mapping, and not access the last 4M?

-Scott
