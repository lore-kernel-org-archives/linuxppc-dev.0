Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 423gvf20YyzDrq8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Sep 2018 17:05:01 +1000 (AEST)
Subject: Re: [PATCH RFC] powerpc/kernel: Don't check for dev->dma_mask in
 fsl_set_dma_mask
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org,
 Christian Zigotzky <chzigotzky@xenosoft.de>,
 Julian Margetson <runaway@candw.ms>, Scott Wood <oss@buserror.net>
References: <4c7f98c86ad.343ea8c1@auth.smtp.1and1.co.uk>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <71880c75-1071-7fd3-d32d-26327a4aedde@c-s.fr>
Date: Mon, 3 Sep 2018 09:04:48 +0200
MIME-Version: 1.0
In-Reply-To: <4c7f98c86ad.343ea8c1@auth.smtp.1and1.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Your patch should be sent as part of the message text and not as an 
attached file.

By sending as an attached file, patchwork doesn't handle it properly 
(all compilation tests fail) https://patchwork.ozlabs.org/patch/965082/

For reference, see 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#no-mime-no-links-no-compression-no-attachments-just-plain-text

Christophe

Le 02/09/2018 à 13:30, Darren Stevens a écrit :
> To enable use of dma to all ram on a corenet generic system, we add the
> function fsl_pci_dma_set_mask, and link it into the ppc.md structure.
> 
> But this function checks for the presence of dev->dma_mask and dma_ops
> at entry, and fails if one or other are missing. Powerpc's dma_set_mask
> (which it is called from) doesn't check this until after it has set the
> dma_mask for pci devs, this difference shows up on a Cyrus (AmigaOne X5000)
> - a soundblaster live pci card, will works properly if memory is limited
> to <4G, but fail on probe with the following message if the memory is >=4G
> 
> [    4.646531] snd_emu10k1 1000:04:04.0: architecture does not support PCI
> busmaster DMA with mask 0x7fffffff
> 
> Remove the dev->mask tests to make the routines behave similarly.
> 
> Signed-off-by: Darren Stevens <darren@stevens-zone.net>
> 
> ---
> 
> This fix looks wrong to me, although it works. The test needs to be removed,
> moving it to the end of the function doesn't work either. This needs someone
> with more knowledge of what's going on to take a look.
> 
