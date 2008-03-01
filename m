Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9A4ABDDEE7
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Mar 2008 00:17:41 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m21DHcEB001069
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Mar 2008 08:17:38 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m21DHbH8142876
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Mar 2008 06:17:37 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m21DHbUw009087
	for <linuxppc-dev@ozlabs.org>; Sat, 1 Mar 2008 06:17:37 -0700
Date: Sat, 1 Mar 2008 07:15:35 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] [POWERPC] 40X: Add Default Restart Machdep Method to
	40X  Platforms
Message-ID: <20080301071535.643a5d93@zod.rchland.ibm.com>
In-Reply-To: <200803011232.54392.sr@denx.de>
References: <C3E49AAC.D8E4%erick205@umn.edu>
	<200803011232.54392.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Grant Erickson <erick205@umn.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 1 Mar 2008 12:32:54 +0100
Stefan Roese <sr@denx.de> wrote:

> On Saturday 23 February 2008, Grant Erickson wrote:
> > This patch restores the reset on restart functionality to 40x-based
> > platforms that was formerly provided--but not used in arch/powerpc--by
> > abort() in head_40x.S. This functionality is now provided by
> > ppc40x_reset_system(char *) in a fashion similar to that of the 44x-based
> > platforms.
> >
> > Compiled, linked and tested against the AMCC Haleakala board.
> 
> Instead of duplicating this code in platform/40x/ which is already present in 
> platforms/44x/misc_44x.S, why not move this misc_44x.S code into a common 
> place for all 4xx (40x and 44x) PPC's? There seems to be nothing 44x 
> specific.
> 
> I suggest to introduce platforms/4xx/misc.S or sysdev/ppc4xx_misc.S with these 
> functions and change the code referencing it accordingly.
> 
> Comments/thoughts?

It's a good idea.  I'd rather avoid platforms/4xx for now, but
sysdev/ppc4xx_misc.S seems reasonable.

I'll move it in my tree soon and do the necessary makefile fixups.

josh
