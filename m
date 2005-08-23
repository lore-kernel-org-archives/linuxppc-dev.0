Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C9C7680AD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Aug 2005 06:26:08 +1000 (EST)
Date: Tue, 23 Aug 2005 17:20:44 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: akpm@osdl.org
Message-ID: <20050823202044.GD13157@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32 8xx: fix m8xx_ide_init() #ifdef
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Be more precise on deciding whether to call m8xx_ide_init() at
m8xx_setup.c:platform_init().

Compilation fails if CONFIG_BLK_DEV_IDE is defined but
CONFIG_BLK_DEV_MPC8xx_IDE isnt.

Please apply.

Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

diff --git a/arch/ppc/syslib/m8xx_setup.c b/arch/ppc/syslib/m8xx_setup.c
--- a/arch/ppc/syslib/m8xx_setup.c
+++ b/arch/ppc/syslib/m8xx_setup.c
@@ -423,7 +423,7 @@ platform_init(unsigned long r3, unsigned
        ppc_md.find_end_of_memory       = m8xx_find_end_of_memory;
        ppc_md.setup_io_mappings        = m8xx_map_io;

-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
+#if defined(CONFIG_BLK_DEV_MPC8xx_IDE)
        m8xx_ide_init();
 #endif
 }
