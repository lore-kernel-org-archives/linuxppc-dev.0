Message-ID: <20021009005255.13254.qmail@web11507.mail.yahoo.com>
Date: Tue, 8 Oct 2002 17:52:55 -0700 (PDT)
From: Khai Trinh <kqtrinh@yahoo.com>
Subject: DMA support for ppc440
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi folks,

There is a problem in the ppc4xx dma implementation.
After I configured the kernel to build for the ppc440,
the CONFIG_PPC4XX_DMA flag is set to 1 in
include/linux/autoconf.h and include/config/ppc4xx/
dma.h. However, when invoking some of the DMA
functions such as request_dma, free_dma,
cleain_dma_lock, clear_dma_ff, and release_dma_lock in
my driver, they don't exist in the kernel and the
compiler complained with the following errors:

pcip.c: In function `pcip_open':
pcip.c:160: warning: implicit declaration of function
`request_dma'
pcip.c: In function `pcip_dma_start':
pcip.c:931: warning: implicit declaration of function
`claim_dma_lock'
pcip.c:936: warning: implicit declaration of function
`clear_dma_ff'
pcip.c:952: warning: implicit declaration of function
`release_dma_lock'
pcip.c: In function `pcip_cleanup':
pcip.c:983: warning: implicit declaration of function
`free_dma'

I went and searched the kernel tree for a ppc4xx
version of the above DMA functions but couldn't find
any. None of the above functions are implmented in
ppc4xx_dma.h or ppc4xx_dma.c

As far as I know, these functions are required for
doing DMA for ppc4xx processors and they are not
implemented. Any ideas when will they be avail?

Please advice ...

Regards,
--Khai


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
