Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (unknown
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by ozlabs.org (Postfix) with ESMTP id 946D52C02C7
 for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2013 05:58:01 +1100 (EST)
Date: Mon, 11 Feb 2013 13:50:45 -0500 (EST)
Message-Id: <20130211.135045.288377899939965231.davem@davemloft.net>
To: sr@denx.de
Subject: Re: [PATCH RESEND] net: fec_mpc52xx: Read MAC address from device-tree
From: David Miller <davem@davemloft.net>
In-Reply-To: <1360403352-24237-1-git-send-email-sr@denx.de>
References: <1360403352-24237-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, agust@denx.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stefan Roese <sr@denx.de>
Date: Sat,  9 Feb 2013 10:49:12 +0100

> Until now, the MPC5200 FEC ethernet driver relied upon the bootloader
> (U-Boot) to write the MAC address into the ethernet controller
> registers. The Linux driver should not rely on such a thing. So
> lets read the MAC address from the DT as it should be done here.
> 
> This fixes a problem with a MPC5200 board that uses the SPL U-Boot
> version without FEC initialization before Linux booting for
> boot speedup.
> 
> Additionally a status line will now be printed upon successful
> driver probing, also displaying this MAC address.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>

I don't think this is a conservative enough change.

You have to keep the MAC register reading code around, as a backup
code path in case the OF device node lacks a MAC address, also:

> +	if (!is_zero_ether_addr(mpc52xx_fec_mac_addr)) {

I really wish I would have caught this terrible module parameter
when the driver was initially submitted.

I would just get rid of this, and have a priority list of cases:

1) First, try OF node MAC address, if not present or invalid, then:

2) Read from MAC address registers, if invalid, then:

3) Log a warning message, and choose a random MAC address.

That way no matter what happens, the user will at least have a
functioning networking device.
