Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1E17DDDEE
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 23:08:43 +1100 (EST)
Message-ID: <47DE5F43.80604@garzik.org>
Date: Mon, 17 Mar 2008 08:08:35 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] net: NEWEMAC: Support for Pause packets in EMAC driver
References: <1205488348-22536-1-git-send-email-sr@denx.de>
In-Reply-To: <1205488348-22536-1-git-send-email-sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> From: Pravin M. Bathija <pbathija@amcc.com>
> 
> Problem Description and Fix
> ---------------------------
> When a pause packet(with destination as reserved Multicast address) is
> received by the EMAC hardware to control the flow of frames being
> transmitted by it, it is dropped by the hardware unless the reserved
> Multicast address is hashed in to the GAHT[1-4] registers. This code fix
> adds the default reserved multicast address to the GAHT[1-4] registers
> in the EMAC(s) present on the chip. The flow control with Pause packets
> will only work if the following register bits are programmed in EMAC:
> EMACx_MR1[APP] = 1
> EMACx_RMR[BAE] = 1
> EMACx_RMR[MAE] = 1
> 
> Behavior that may be observed in a running system
> -------------------------------------------------
> A host transferring data from a PPC based system may send a Pause packet
> to the PPC EMAC requesting it to slow down the flow of packets. If the
> default reserved multicast MAC address is not programmed into the
> GAHT[1-4] registers this Pause packet will be dropped by PPC EMAC and no
> Flow Control will be done.
> 
> Signed-off-by: Pravin M. Bathija <pbathija@amcc.com>
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
>  drivers/net/ibm_newemac/core.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)

applied
