Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B0E10B7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Oct 2009 09:10:09 +1100 (EST)
Date: Wed, 14 Oct 2009 15:10:25 -0700 (PDT)
Message-Id: <20091014.151025.83161886.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH v2] net/fec_mpc52xx: Fix kernel panic on FEC error
From: David Miller <davem@davemloft.net>
In-Reply-To: <20091014174224.29221.18830.stgit@angua>
References: <20091014174224.29221.18830.stgit@angua>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: bones@secretlab.ca, netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 14 Oct 2009 11:43:43 -0600

> From: John Bonesio <bones@secretlab.ca>
> 
> The MDIO bus cannot be accessed at interrupt context, but on an FEC
> error, the fec_mpc52xx driver reset function also tries to reset the
> PHY.  Since the error is detected at IRQ context, and the PHY functions
> try to sleep, the kernel ends up panicking.
> 
> Resetting the PHY on an FEC error isn't even necessary.  This patch
> solves the problem by removing the PHY reset entirely.
> 
> Signed-off-by: John Bonesio <bones@secretlab.ca>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Applied, thanks.
