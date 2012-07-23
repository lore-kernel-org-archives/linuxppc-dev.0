Return-Path: <B04825@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 257F92C035E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 09:36:32 +1000 (EST)
Message-ID: <500DDFF3.3000408@freescale.com>
Date: Mon, 23 Jul 2012 18:36:19 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: add ZONE_NORMAL zone for 64 bit kernel
References: <1342786906-12634-1-git-send-email-Shaohui.Xie@freescale.com>
 <1343023569.2957.19.camel@pasglop>	<500D7921.6060804@freescale.com>
 <1343082030.2957.38.camel@pasglop>
 <CAOZdJXXd6GuLAed_Z4zNMjDN+DBBXHdd0yVRHof+BJ_eiUMbqQ@mail.gmail.com>
 <1343085145.2957.44.camel@pasglop> <500DDB1B.9030900@freescale.com>
 <1343086186.2957.46.camel@pasglop>
In-Reply-To: <1343086186.2957.46.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Hu Mingkai-B21284 <B21284@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xie Shaohui-B21989 <B21989@freescale.com>,
 Chen Yuanquan-B41889 <B41889@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

> No, but dma_alloc_coherent would under the hood.

Which is what Shaohui's patch does.  Well, it does it for GFP_DMA instead
of GFP_DMA32, but still.

When you said, "Drivers who know about a 32-bit limitations use
GFP_DMA32", I thought you meant that drivers should *set* GFP_DMA32.

>> I don't understand why a driver would set GFP_DMA32 if it has already set
>> the mask.
> 
> The layers in between, not the well behaved drivers. Again, we have
> ZONE_DMA32 specifically for the purpose, why use something else ?
> 
> In any case, make the whole thing at the very least a config option, I
> don't want sane HW to have to deal with split zones.

The DMA zone only kicks in if the DMA mask is set to a size smaller that
available physical memory.  Sane HW should set the DMA mask to
DMA_BIT_MASK(36).  And we have plenty of sane HW on our SOCs, but not
every device is like that.

The whole point behind this patch is that some drivers are setting a DMA
mask of 32, but still getting memory above 4GB.

-- 
Timur Tabi
Linux kernel developer at Freescale
