Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id AA0D867C36
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 14:43:40 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k7O4hcew007427
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 21:43:38 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7O4hZ1m027516
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 23:43:37 -0500 (CDT)
Subject: Re: [PATCH ] powerpc:  pass UPIO_TSI flag to 8259 serial driver
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1156369941.8433.57.camel@localhost.localdomain>
References: <7EA18FDD2DC2154AA3BD6D2F22A62A0E26E532@zch01exm23.fsl.freescale.net>
	<1156304163.8433.19.camel@localhost.localdomain>
	<44EC15A1.4090807@freescale.com>
	<1156369941.8433.57.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1156394597.5310.42.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 24 Aug 2006 12:43:17 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-24 at 05:52, Benjamin Herrenschmidt wrote:
> On Wed, 2006-08-23 at 16:45 +0800, Zang Roy-r61911 wrote:
> > Benjamin Herrenschmidt wrote:
> > > On Wed, 2006-08-23 at 10:20 +0800, Zang Roy-r61911 wrote:
> > >   
> > >> The patch passes the UPIO_TSI flag to general 8259 serial driver
> > >>     
> > >
> > > Patch looks damaged to me... appart from that, what it does looks
> ok to
> > > me.
> > Sorry. It seems imported by my mail client. Please pick up the
> following 
> > one.
> 
> Seems to be damaged as well ! What mail client do you use ? 
> 
> Ben.
Evolution 1.2.2. I had found the reason and tested on my side.
Paul, if you do not modify it by hand, please select the following :-).
I will repost the mpic and mpc7448hph2 irq update patch.Very sorry for that.

Signed-off-by: Roy Zang       <tie-fei.zang@freescale.com> 

---
 arch/powerpc/kernel/legacy_serial.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 359ab89..07c2c00 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -115,6 +115,7 @@ static int __init add_legacy_soc_port(st
 	u64 addr;
 	u32 *addrp;
 	upf_t flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_SHARE_IRQ;
+	struct device_node *tsi = of_get_parent(np);
 
 	/* We only support ports that have a clock frequency properly
 	 * encoded in the device-tree.
@@ -134,7 +135,10 @@ static int __init add_legacy_soc_port(st
 	/* Add port, irq will be dealt with later. We passed a translated
 	 * IO port value. It will be fixed up later along with the irq
 	 */
-	return add_legacy_port(np, -1, UPIO_MEM, addr, addr, NO_IRQ, flags, 0);
+	if (tsi && !strcmp(tsi->type, "tsi-bridge"))
+		return add_legacy_port(np, -1, UPIO_TSI, addr, addr, NO_IRQ, flags, 0);
+	else 
+		return add_legacy_port(np, -1, UPIO_MEM, addr, addr, NO_IRQ, flags, 0);
 }
 
 static int __init add_legacy_isa_port(struct device_node *np,
@@ -464,7 +468,7 @@ static int __init serial_dev_init(void)
 			fixup_port_irq(i, np, port);
 		if (port->iotype == UPIO_PORT)
 			fixup_port_pio(i, np, port);
-		if (port->iotype == UPIO_MEM)
+		if ((port->iotype == UPIO_MEM) || (port->iotype == UPIO_TSI))
 			fixup_port_mmio(i, np, port);
 	}
 
-- 
1.4.0
