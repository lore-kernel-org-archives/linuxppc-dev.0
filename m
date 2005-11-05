Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 66C92686A0
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  6 Nov 2005 07:05:37 +1100 (EST)
Date: Sat, 5 Nov 2005 13:07:49 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051105150749.GC6577@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32 8xx: m8xx_pcmcia_set_iomap() must support MAP_AUTOSZ
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


From: Vitaly Bordug <vbordug@ru.mvista.com>

This fixes misconfiguration that could result in odd work of some old CF
cards.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

diff --git a/drivers/pcmcia/m8xx_pcmcia.c b/drivers/pcmcia/m8xx_pcmcia.c
--- a/drivers/pcmcia/m8xx_pcmcia.c
+++ b/drivers/pcmcia/m8xx_pcmcia.c
@@ -1041,8 +1041,7 @@ static int m8xx_set_io_map(struct pcmcia
 		if(io->flags & MAP_WRPROT)
 			reg |= M8XX_PCMCIA_POR_WRPROT;
 
-		/*if(io->flags & (MAP_16BIT | MAP_AUTOSZ))*/
-		if(io->flags & MAP_16BIT)
+		if(io->flags & (MAP_16BIT | MAP_AUTOSZ))
 			reg |= M8XX_PCMCIA_POR_16BIT;
 
 		if(io->flags & MAP_ACTIVE)
