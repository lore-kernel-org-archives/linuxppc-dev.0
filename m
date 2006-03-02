Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C348679FD
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Mar 2006 10:35:46 +1100 (EST)
Subject: Re: incorrect rmo_top handling in prom_init
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20060302185509.GA14235@suse.de>
References: <20060302185509.GA14235@suse.de>
Content-Type: text/plain
Date: Fri, 03 Mar 2006 10:35:40 +1100
Message-Id: <1141342541.13565.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-03-02 at 19:55 +0100, Olaf Hering wrote:
> My iBook1 has 2 memory regions in reg. Depending on how I boot it
> (vmlinux+initrd) or zImage.initrd, it will not boot with current Linus
> tree.
> rmo_top should be 160MB instead of 32MB.

Does that fix it ?

Index: linux-work/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/prom_init.c	2006-03-01 11:48:27.000000000 +1100
+++ linux-work/arch/powerpc/kernel/prom_init.c	2006-03-03 10:34:30.000000000 +1100
@@ -978,7 +978,7 @@
 			if (size == 0)
 				continue;
 			prom_debug("    %x %x\n", base, size);
-			if (base == 0)
+			if (base == 0 && (RELOC(of_platform) & PLATFORM_LPAR))
 				RELOC(rmo_top) = size;
 			if ((base + size) > RELOC(ram_top))
 				RELOC(ram_top) = base + size;
