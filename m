Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id E02F1DDEB6
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 04:46:30 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] powerpc: MPC85xx EDAC device driver
Date: Mon, 30 Jul 2007 20:46:09 +0200
References: <20070726222225.GB10427@blade.az.mvista.com>
	<200707301928.51253.arnd@arndb.de> <46AE2487.7060103@mvista.com>
In-Reply-To: <46AE2487.7060103@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707302046.10010.arnd@arndb.de>
Cc: norsk5@yahoo.com, bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 30 July 2007, Dave Jiang wrote:
> 
> > What about the other option I mentioned, handling the EDAC stuff from the
> > fsl_add_bridge() function?
> 
> I'm not sure I follow your thought on this quite yet. Do you mean the setup of
> either of_device or platform_device or do you mean the actual pci err driver?
> I'm not understanding how doing the setup code in fsl_add_bridge() would allow
> us to prevent the of_device being monopolized by the EDAC driver or the future
> PCI code.... The EDAC driver still needs some sort of "device" to claim one way
> or another right?

What I meant is calling the edac_pci_alloc_ctl_info() function directly
from fsl_add_bridge() where appropriate, with all the 85xx PCI EDAC
code moved into fsl_pci.c.

	Arnd <><
