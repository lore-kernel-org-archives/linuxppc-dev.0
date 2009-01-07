Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77863DE014
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 15:40:48 +1100 (EST)
Message-Id: <35FA8393-FC32-44DC-970E-55EFA16E0D20@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <1229543006-8950-1-git-send-email-tpiepho@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/2] POWERPC/fsl-pci: Better ATMU setup
Date: Tue, 6 Jan 2009 22:38:41 -0600
References: <1229543006-8950-1-git-send-email-tpiepho@freescale.com>
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

> The code that sets up the outbound ATMU windows, which is used to  
> map CPU
> physical addresses into PCI bus addresses where BARs will be mapped,  
> didn't
> work so well.
>
> For one, it leaked the ioremap() of the ATMU registers.  Another  
> small bug
> was the high 20 bits of the PCI bus address were left as zero.  It's  
> legal
> for prefetchable memory regions to be above 32 bits, so the high 20  
> bits
> might not be zero.
>
> Mainly, it couldn't handle ranges that were not a power of two in  
> size or
> were not naturally aligned.  The ATMU windows have these  
> requirements (size
> & alignment), but the code didn't bother to check if the ranges it was
> programming met them.  If they didn't, the windows would silently be
> programmed incorrectly.
>
> This new code can handle ranges which are not power of two sized nor
> naturally aligned.  It simply splits the ranges into multiple valid  
> ATMU
> windows.  As there are only four windows, pooly aligned or sized  
> ranges
> (which didn't even work before) may run out of windows.  In this  
> case an
> error is printed and an effort is made to disable the unmapped  
> resources.
>
> An improvement that could be made would be to make use of the default
> outbound window.  Iff hose->pci_mem_offset is zero, then it's  
> possible that
> some or all of the ranges might not need an outbound window and  
> could just
> use the default window.
>
> The default ATMU window can support a pci_mem_offset less than zero  
> too,
> but pci_mem_offset is unsigned.  One could say the abilities allowed a
> powerpc pci_controller is neither subset nor a superset of the  
> abilities of
> a Freescale PCIe controller.  Thankfully, the most useful bits are  
> in the
> intersection of the two abilities.
>
> Signed-off-by: Trent Piepho <tpiepho@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_pci.c |  104 +++++++++++++++++++++++++++ 
> +-------------
> 1 files changed, 71 insertions(+), 33 deletions(-)

applied

- k
