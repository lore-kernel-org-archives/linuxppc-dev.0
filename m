Return-Path: <mgreer@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [63.81.120.158])
	by ozlabs.org (Postfix) with ESMTP id 7420A689AD
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jan 2006 05:58:00 +1100 (EST)
Date: Thu, 19 Jan 2006 11:29:38 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Eric Sesterhenn / snakebyte <snakebyte@gmx.de>
Subject: Re: [RFC][Patch] pci_0 pci_1 mixup in ppc/platforms/chestnut.c
Message-ID: <20060119182938.GA24369@mag.az.mvista.com>
References: <1137679159.22607.5.camel@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1137679159.22607.5.camel@alice>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 19, 2006 at 02:59:19PM +0100, Eric Sesterhenn / snakebyte wrote:

<snip>

> --- linux-2.6.15-git11/arch/ppc/platforms/chestnut.c.orig	2006-01-19 14:54:59.000000000 +0100
> +++ linux-2.6.15-git11/arch/ppc/platforms/chestnut.c	2006-01-19 14:55:25.000000000 +0100
> @@ -199,7 +199,7 @@ chestnut_setup_bridge(void)
>  		si.mpsc_options[i] = MV64360_MPSC2MEM_SNOOP_NONE;
>  		si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_NONE;
>  
> -		si.pci_1.acc_cntl_options[i] =
> +		si.pci_0.acc_cntl_options[i] =
>  		    MV64360_PCI_ACC_CNTL_SNOOP_NONE |
>  		    MV64360_PCI_ACC_CNTL_SWAP_NONE |
>  		    MV64360_PCI_ACC_CNTL_MBURST_128_BYTES |
> 

Good catch.  Note that the tree you should be submitting patches against
is the powerpc.git tree.  In this case, though, I expect the patch to apply
cleanly to that tree.

Also, there are 2 place where that occurs.  Mind fixing both?

Mark
