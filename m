Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id C46C5679A6
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Mar 2006 00:51:39 +1100 (EST)
Date: Thu, 9 Mar 2006 14:51:37 +0100 (MET)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: linuxppc-dev@ozlabs.org,debian-powerpc@lists.debian.org
MIME-Version: 1.0
Subject: Unmapping pages from the linear addressing without HIGHMEM support
Message-ID: <15153.1141912297@www026.gmx.net>
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm trying to implement non-coherent DMA for PPC desktop systems (like the
AmigaOne with G3/G4 CPU). For this I want to use the code in
arch/ppc/kernel/dma-mapping.c. The DMA memory allocation function
implemented in this file allocates pages with alloc_pages() and maps them to
its own linear address space, but without unmapping the allocated pages from
the kernel linear addressing. Due to this the pages are mapped twice, which
results in a conflict between the different WIMG settings of the pages.

Is there an API that can be used to unmap the allocated pages from the
kernel linear addressing? I thought about using kunmap() and
flush_all_zero_pkmaps(), but I'm not sure if this is the right approach and
HIGHMEM doesn't work on the AmigaOne too (the highmem base is occupied by
the PCI/ISA I/O space!). Wouldn't it be possible to just clear the valid (V)
bit of the PTE and do a TLB cache flush?

Any suggestions?

Thanks!

Regards,

Gerhard

-- 
"Feel free" mit GMX FreeMail!
Monat für Monat 10 FreeSMS inklusive! http://www.gmx.net
