Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9C421B7C7E
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Feb 2010 07:41:18 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o1PKf0HR018949
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 13:41:10 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o1PKlWWY023087
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2010 14:47:32 -0600 (CST)
Message-ID: <4B86E05A.1080705@freescale.com>
Date: Thu, 25 Feb 2010 14:40:58 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: CONFIG_ISA_DMA_API without CONFIG_GENERIC_ISA_DMA
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I tried building a kernel using mpc85xx_smp_defconfig, but with all 
platforms but p4080ds removed.  This was the result:

>   LD      .tmp_vmlinux1
> sound/built-in.o: In function `claim_dma_lock':
> /home/scott/git/fsl/linux/upstream/arch/powerpc/include/asm/dma.h:179: undefined reference to `dma_spin_lock'
> /home/scott/git/fsl/linux/upstream/arch/powerpc/include/asm/dma.h:179: undefined reference to `dma_spin_lock'
> /home/scott/git/fsl/linux/upstream/arch/powerpc/include/asm/dma.h:179: undefined reference to `dma_spin_lock'
> /home/scott/git/fsl/linux/upstream/arch/powerpc/include/asm/dma.h:179: undefined reference to `dma_spin_lock'
> /home/scott/git/fsl/linux/upstream/arch/powerpc/include/asm/dma.h:179: undefined reference to `dma_spin_lock'
> sound/built-in.o:/home/scott/git/fsl/linux/upstream/arch/powerpc/include/asm/dma.h:179: more undefined references to `dma_spin_lock' follow
> make: *** [.tmp_vmlinux1] Error 1

Commit fb4f0e8832e0075849b41b65f6bb9fdfa7593b99 (Enable GENERIC_ISA_DMA 
if FSL_ULI1575 to fix compile issue) tries to deal with this, but it 
ties it to CONFIG_FSL_ULI1575, which is not selected in a p4080ds-only 
config.

It seems that ULI isn't really relevant to the actual problem, which is 
that we enable ISA DMA API support without selecting an implementation. 
  Whether a certain chip is on the board that has an actual ISA 
interface is irrelevant to the build breakage.

Where did the dependency list for GENERIC_ISA_DMA come from?  Are there 
any legitimate cases on powerpc where we want to select ISA_DMA_API but 
not GENERIC_ISA_DMA (i.e. we have an alternate implementation)?

-Scott
