Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 14AB267C6D
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Aug 2006 08:50:36 +1000 (EST)
Subject: Re: [PATCH] powerpc: Support for "weird" MPICs and fixup mpc7448_hpc2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <1156492062.7107.26.camel@localhost.localdomain>
References: <1156479390.8433.293.camel@localhost.localdomain>
	<1156492062.7107.26.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 26 Aug 2006 08:50:13 +1000
Message-Id: <1156546214.8433.331.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-08-25 at 15:47 +0800, Zang Roy-r61911 wrote:
> On Fri, 2006-08-25 at 12:16, Benjamin Herrenschmidt wrote:
> > This patch is a slightly cleaned up version of Zang Roy's support for
> > the TSI108 MPIC variant. It also fixes up MPC7448_hpc2 to use the new
> > version of the type macros and changes the way MPIC is selected in
> > Kconfig to better match what is done for other system devices.
> > 
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com> 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> > 
> > Zang Roy, please verify that it still works for you. I've tested it on
> > an Apple G5 with and without CONFIG_MPIC_WEIRD .
> > 
> 
> It works OK on my mpc7448hpc2 board. 
> There is a sequence for the patch applying.
> 
> (1) patch for IRQ update for mpc7448hpc2:
> http://ozlabs.org/pipermail/linuxppc-dev/2006-August/025559.html
> 
> (2) the weird mpic patch repost by your mail.
> (3) the following minor patch to build mpic.o for CONFIG_MPIC_WEIRD

The later shouldn't be needed.

CONFIG_MPIC_WEIRD is an _addition_ to CONFIG_MPIC. That is, for example,
your HPC2 platform should define both CONFIG_MPIC and CONFIG_MPIC_WEIRD

Ben.
