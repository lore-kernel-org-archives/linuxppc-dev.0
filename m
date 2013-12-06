Return-Path: <scottwood@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9B6BC2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 06:21:33 +1100 (EST)
Message-ID: <1386357684.7375.124.camel@snotra.buserror.net>
Subject: Re: [PATCH] DTS: DMA: Fix DMA3 interrupts
From: Scott Wood <scottwood@freescale.com>
To: <hongbo.zhang@freescale.com>
Date: Fri, 6 Dec 2013 13:21:24 -0600
In-Reply-To: <1385712446-28221-1-git-send-email-hongbo.zhang@freescale.com>
References: <1385712446-28221-1-git-send-email-hongbo.zhang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-11-29 at 16:07 +0800, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
> 
> MPIC registers for internal interrupts is non-continous in address, any
> internal interrupt number greater than 159 should be added (16+208) to work.
> 16 is due to external interrupts as usual, 208 is due to the non-continous MPIC
> register space.
> Tested on T4240 rev2 with SRIO2 disabled.
> 
> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/elo3-dma-2.dtsi |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

The FSL MPIC binding should be updated to point out how this works.  

Technically it's not a change to the binding itself, since it's defined
in terms of register offset, but the explanatory text says "So interrupt
0 is at offset 0x0, interrupt 1 is at offset 0x20, and so on." which is
not accurate for these new high interrupt numbers.

-Scott
