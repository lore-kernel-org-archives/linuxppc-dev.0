Message-ID: <3D3DAA17.7070406@dslextreme.com>
Date: Tue, 23 Jul 2002 12:10:15 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: [RFC/Patch] ppc4xx_dma.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


While working on an ocp ide driver using the DMA channel with
mtdcr/mfdcr calls , it became clear to me that some changes need to
occur in the ppc4xx_dma.c code.

1) I moved the scatter/gather code used by the 440GP, 405gp, np405l and
np405h to a separate file (ppc4xx_sgdma.c) and is now built when one of
those cpus are configured.

2) I moved the inline api out of /asm-ppc/ppc4xx_dma.h to either
ppc4xx_sgdam.c or ppc4xx_dma.c

3) I needed to add a few more api's for the stbx25xxx and am in the
process of determining if those need to go into a ppc4xxx_stbdma.c file.

int clr_dma_status(unsigned int dmanr)

int map_dma_port(unsigned int dmanr, unsigned int ocp_dma,short dma_chan)

int disable_dma_port(unsigned int dmanr, unsigned int ocp_dma,short
dma_chan)

and possible more to follow

The common API's will stay in /kernel/ppc4xx_dma.c and the common
defines in asm-ppc/ppc4xx_dma.h

armin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
