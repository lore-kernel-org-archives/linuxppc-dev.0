Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0DDBF2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 04:08:47 +1000 (EST)
Message-ID: <1375985244.4514.21.camel@snotra.buserror.net>
Subject: Re: [RFC PATCH 1/1] powerpc/embedded6xx: Add support for
 Motorola/Emerson MVME5100.
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 8 Aug 2013 13:07:24 -0500
In-Reply-To: <B7B7FD2F-8272-487C-B946-154107EF7C09@kernel.crashing.org>
References: <OFBCFBBD51.E4ECB0DF-ONCA257BC0.0083C866-CA257BC1.0000531E@csc.com>
 <B7B7FD2F-8272-487C-B946-154107EF7C09@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: paulus@samba.org, Stephen N Chivers <schivers@csc.com.au>,
 linuxppc-dev@lists.ozlabs.org, Chris Proctor <cproctor@csc.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-08 at 10:30 -0500, Kumar Gala wrote:
> On Aug 7, 2013, at 7:03 PM, Stephen N Chivers wrote:
> 
> > Add support for the Motorola/Emerson MVME5100 Single Board Computer.
> > 
> > The MVME5100 is a 6U form factor VME64 computer with:
> > 
> >        - A single MPC7410 or MPC750 CPU
> >        - A HAWK Processor Host Bridge (CPU to PCI) and
> >          MultiProcessor Interrupt Controller (MPIC)
> >        - Up to 500Mb of onboard memory
> >        - A M48T37 Real Time Clock (RTC) and Non-Volatile Memory chip
> >        - Two 16550 compatible UARTS
> >        - Two Intel E100 Fast Ethernets
> >        - Two PCI Mezzanine Card (PMC) Slots
> >        - PPCBug Firmware
> > 
> > The HAWK PHB/MPIC is compatible with the MPC10x devices.
> > 
> > There is no onboard disk support. This is usually provided by installing a 
> > PMC
> > in first PMC slot.
> > 
> > This patch revives the board support, it was present in early 2.6
> > series kernels. The board support in those days was by Matt Porter of
> > MontaVista Software.
> > 
> > CSC Australia has around 31 of these boards in service. The kernel in use
> > for the boards is based on 2.6.31. The boards are operated without disks
> > from a file server. 
> > 
> > This patch is based on linux-3.11-rc4 and has been boot tested.
> > 
> > Signed-off-by: Stephen Chivers <schivers@csc.com>
> > ---
> > arch/powerpc/boot/dts/mvme5100.dts            |  195 ++
> > arch/powerpc/boot/mvme5100.c                  |   28 +
> > arch/powerpc/configs/mvme5100_defconfig       | 2597 
> > +++++++++++++++++++++++++
> > arch/powerpc/platforms/embedded6xx/mvme5100.c |  288 +++
> > 4 files changed, 3108 insertions(+), 0 deletions(-)
> 
> Please look at fixing the white space issues you seem to have throughout this patch.
> 
> Also, we don't take full defconfigs in the tree, look at 'make savedefconfig'

Why does this board need its own defconfig at all?  Just add it to
ppc6xx_defconfig.

-Scott
