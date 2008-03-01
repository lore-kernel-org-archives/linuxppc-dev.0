Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 42657DDE25
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 22:22:05 +1100 (EST)
Date: Sat, 1 Mar 2008 12:21:47 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 3/3 update] firewire: fw-ohci: shut up false compiler warning
	on PPC32
To: linux1394-devel@lists.sourceforge.net
In-Reply-To: <47C90F83.3030700@s5r6.in-berlin.de>
Message-ID: <tkrat.0428557bce5b81da@s5r6.in-berlin.de>
References: <tkrat.ac97915a5b51e35b@s5r6.in-berlin.de>
	<tkrat.ee238048a5a50184@s5r6.in-berlin.de>
	<20080301141741.172013ba.sfr@canb.auug.org.au>
	<47C90F83.3030700@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Shut up two "may be used uninitialised in this function" warnings due to
PPC32's implementation of dma_alloc_coherent().

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/firewire/fw-ohci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.25-rc3/drivers/firewire/fw-ohci.c
===================================================================
--- linux-2.6.25-rc3.orig/drivers/firewire/fw-ohci.c
+++ linux-2.6.25-rc3/drivers/firewire/fw-ohci.c
@@ -544,7 +544,7 @@ static int
 context_add_buffer(struct context *ctx)
 {
 	struct descriptor_buffer *desc;
-	dma_addr_t bus_addr;
+	dma_addr_t uninitialized_var(bus_addr);
 	int offset;
 
 	/*
@@ -1334,7 +1334,7 @@ ohci_set_config_rom(struct fw_card *card
 	unsigned long flags;
 	int retval = -EBUSY;
 	__be32 *next_config_rom;
-	dma_addr_t next_config_rom_bus;
+	dma_addr_t uninitialized_var(next_config_rom_bus);
 
 	ohci = fw_ohci(card);
 

-- 
Stefan Richter
-=====-==--- --== ----=
http://arcgraph.de/sr/
