Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E1910DDF6B
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 13:18:30 +1100 (EST)
Message-ID: <47EDA6F1.9080206@garzik.org>
Date: Fri, 28 Mar 2008 22:18:25 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 1/2] ibm_newemac: PowerPC 440GX EMAC PHY clock workaround
References: <20080327144044.GA8831@ru.mvista.com>
In-Reply-To: <20080327144044.GA8831@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valentine Barshak wrote:
> The PowerPC 440GX Taishan board fails to reset EMAC3 (reset timeout error)
> if there's no link. Because of that it fails to find PHY chip. The older ibm_emac
> driver had a workaround for that: the EMAC_CLK_INTERNAL/EMAC_CLK_EXTERNAL macros,
> which toggle the Ethernet Clock Select bit in the SDR0_MFR register. This patch
> does the same for "ibm,emac-440gx" compatible chips. The workaround forces
> clock on -all- EMACs, so we select clock under global emac_phy_map_lock.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> ---
>  drivers/net/ibm_newemac/core.c |   16 +++++++++++++++-
>  drivers/net/ibm_newemac/core.h |    8 ++++++--
>  2 files changed, 21 insertions(+), 3 deletions(-)

is this for 2.6.25-rc?
