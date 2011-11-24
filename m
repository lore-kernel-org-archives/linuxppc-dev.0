Return-Path: <B11780@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 016581007EE
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2011 19:25:51 +1100 (EST)
Subject: Re: [PATCH] [v3] powerpc/fsl_msi: add support for the fsl,
 msi property in PCI nodes
MIME-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1320098795-7658-1-git-send-email-timur@freescale.com>
Date: Thu, 24 Nov 2011 02:25:42 -0600
Message-ID: <B57C188D-C613-4583-83EB-D81CAD462432@freescale.com>
References: <1320098795-7658-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: miltonm@bga.com, michael@ellerman.id.au, linuxppc-dev@ozlabs.org,
 scottwood@freescale.com, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 31, 2011, at 5:06 PM, Timur Tabi wrote:

> On Freescale parts with multiple MSI controllers, the controllers are
> combined into one "pool" of interrupts.  Whenever a device requests an =
MSI
> interrupt, the next available interrupt from the pool is selected,
> regardless of which MSI controller the interrupt is from.  This works
> because each PCI bus has an ATMU to all of CCSR, so any PCI device can
> access any MSI interrupt register.
>=20
> The fsl,msi property is used to specify that a given PCI bus should =
only
> use a specific MSI device.  This is necessary, for example, with the
> Freescale hypervisor, because the MSI devices are assigned to specific
> partitions.
>=20
> Ideally, we'd like to be able to assign MSI devices to PCI busses =
within
> the MSI or PCI layers.  However, there does not appear to be a =
mechanism
> to do that.  Whenever the MSI layer wants to allocate an MSI interrupt =
to
> a PCI device, it just calls arch_setup_msi_irqs().  It would be nice =
if we
> could register an MSI device with a specific PCI bus.
>=20
> So instead we remember the phandles of each MSI device, and we use =
that to
> limit our search for an available interrupt.  Whenever we are asked to
> allocate a new interrupt for a PCI device, we check the fsl,msi =
property
> of the PCI bus for that device.  If it exists, then as we are looping =
over
> all MSI devices, we skip the ones that don't have a matching phandle.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>=20
> v3: added check for invalid fsl,msi phandles
>=20
> arch/powerpc/sysdev/fsl_msi.c |   39 =
+++++++++++++++++++++++++++++++++++++++
> arch/powerpc/sysdev/fsl_msi.h |    3 +++
> 2 files changed, 42 insertions(+), 0 deletions(-)

applied to next

- k=
