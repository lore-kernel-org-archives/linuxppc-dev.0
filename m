Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C183067B5F
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 09:14:45 +1000 (EST)
Subject: Re: [PATCH] Prevent legacy io access on pmac
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20060911115354.GA23884@aepfle.de>
References: <20060911115354.GA23884@aepfle.de>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 09:14:25 +1000
Message-Id: <1158016465.15465.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-09-11 at 13:53 +0200, Olaf Hering wrote:
> The ppc32 common config runs also on PReP/CHRP, which uses PC style IO
> devices.  The probing is bogus, it crashes or floods dmesg.
> 
> ppc can boot one single binary on prep, chrp and pmac boards.
> ppc64 can boot one single binary on pseries and G5 boards.
> pmac has no legacy io, probing for PC style legacy hardware leads to a
> hard crash:
> 
> * add check for parport_pc, exit on pmac.
> 32bit chrp has no ->check_legacy_ioport, the probe is always called.
> 64bit chrp has check_legacy_ioport, check for a "parallel" node
> 
> * add check for isapnp, only PReP boards may have real ISA slots.
> 32bit PReP will have no ->check_legacy_ioport, the probe is always called.
> 
> * update code in i8042_platform_init. Run ->check_legacy_ioport first, always
> call request_region. No functional change. Remove whitespace before i8042_reset init.
> 
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

Looks good to me.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
