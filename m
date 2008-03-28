Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id D4E64DDF3A
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 12:45:31 +1100 (EST)
Date: Thu, 27 Mar 2008 20:54:14 -0500
From: Olof Johansson <olof@lixom.net>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Make pasemi_mac.c depend on PPC_PASEMI to prevent link
	errors
Message-ID: <20080328015414.GA23856@lixom.net>
References: <c9b4b088d00e37e33907b15ac59450c04ef36112.1206666963.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c9b4b088d00e37e33907b15ac59450c04ef36112.1206666963.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jeff@garzik.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 28, 2008 at 12:17:33PM +1100, Michael Ellerman wrote:
> drivers/net/pasemi_mac.c is enabled by CONFIG_PASEMI_MAC, which depends on
> PPC64 && PCI. However pasemi_mac.c uses several routines that are only
> built when PPC_PASEMI is selected. This can lead to an unbuildable config:
> 
>  ERROR: ".pasemi_dma_start_chan" [drivers/net/pasemi_mac.ko] undefined!
> 
> So make CONFIG_PASEMI_MAC depend on PPC_PASEMI instead of PPC64.
> 

Ah, good catch. It was OK until I introduced dma_lib under
platforms/pasemi.

> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
