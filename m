Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC578DE54C
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 15:40:53 +1100 (EST)
Message-Id: <0DE1536E-02B5-4D1C-9753-295EDF0D6721@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <1229543006-8950-2-git-send-email-tpiepho@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 2/2] POWERPC/fsl-pci: Set relaxed ordering on prefetchable
	ranges
Date: Tue, 6 Jan 2009 22:38:47 -0600
References: <1229543006-8950-1-git-send-email-tpiepho@freescale.com>
	<1229543006-8950-2-git-send-email-tpiepho@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Trent Piepho <xyzzy@speakeasy.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 17, 2008, at 1:43 PM, Trent Piepho wrote:

> Provides a small speedup when accessing pefetchable ranges.  To  
> indicate
> that a memory range is prefetchable, mark it in the dts file with  
> 42000000
> instead of 02000000.
>
> A powepc pci_controller is allowed three memory ranges, any of which  
> may be
> prefetchable.  However, the PCI-PCI bridge configuration space only  
> has one
> field for "non-prefetchable memory behind bridge", which has a 32 bit
> address, and one field for "prefetchable memory behind bridge",  
> which may
> have a 64 bit address.  These are PCI bus addresses, not CPU physical
> addresses.
>
> So really you're only allowed one memory range of each type.  And if  
> you
> want the range at a PCI address above 32 bits you must make it
> prefetchable.
>
> Signed-off-by: Trent Piepho <tpiepho@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_pci.c |    3 +++
> 1 files changed, 3 insertions(+), 0 deletions(-)


applied

- k
