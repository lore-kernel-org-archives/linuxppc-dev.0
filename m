Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 2EE81B7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Oct 2009 06:20:36 +1100 (EST)
Message-ID: <4AD62247.4020102@grandegger.com>
Date: Wed, 14 Oct 2009 21:11:03 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] net/fec_mpc52xx: Fix kernel panic on FEC error
References: <20091014174224.29221.18830.stgit@angua>
In-Reply-To: <20091014174224.29221.18830.stgit@angua>
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Bonesio <bones@secretlab.ca>, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> From: John Bonesio <bones@secretlab.ca>
> 
> The MDIO bus cannot be accessed at interrupt context, but on an FEC
> error, the fec_mpc52xx driver reset function also tries to reset the
> PHY.  Since the error is detected at IRQ context, and the PHY functions
> try to sleep, the kernel ends up panicking.
> 
> Resetting the PHY on an FEC error isn't even necessary.  This patch
> solves the problem by removing the PHY reset entirely.

There is also no need to free and re-allocate the RX buffers in
mpc52xx_fec_reset().

Wolfgang.
