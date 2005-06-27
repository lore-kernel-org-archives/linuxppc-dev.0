Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BEFEE67A77
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Jun 2005 07:07:53 +1000 (EST)
Date: Mon, 27 Jun 2005 12:28:57 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Kumar Gala <galak@freescale.com>, Pantelis Antoniou <panto@intracom.gr>,
	Dan Malek <dan@embeddededge.com>
Message-ID: <20050627152857.GA10005@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: cpm_uart: use dpram for early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Panto, Kumar,

Can something semantically equivalent to this be merged please.

m8xx_cpm_hostalloc() can't rely on using the coherent DMA allocator
early on boot because the VM is not fully up yet.

The current code relies on the "bootmem_page" allocated by 
m8xx_cpm_reset(), which must be killed.

--- cpm_uart_cpm1.c.orig        2005-06-27 17:51:53.000000000 -0300
+++ cpm_uart_cpm1.c     2005-06-27 17:55:45.000000000 -0300
@@ -155,7 +155,7 @@
        memsz = L1_CACHE_ALIGN(pinfo->rx_nrfifos * pinfo->rx_fifosize) +
            L1_CACHE_ALIGN(pinfo->tx_nrfifos * pinfo->tx_fifosize);
        if (is_con) {
-               mem_addr = (u8 *) m8xx_cpm_hostalloc(memsz);
+               mem_addr = (u8 *) cpm_dpram_addr(cpm_dpalloc(memsz, 8));
                dma_addr = 0;
        } else
                mem_addr = dma_alloc_coherent(NULL, memsz, &dma_addr,
