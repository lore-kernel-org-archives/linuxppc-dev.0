Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5DEB92C0350
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 11:37:20 +1000 (EST)
Message-ID: <500DFC47.3090509@freescale.com>
Date: Mon, 23 Jul 2012 20:37:11 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: add ZONE_NORMAL zone for 64 bit kernel
References: <1342786906-12634-1-git-send-email-Shaohui.Xie@freescale.com>
 <1343023569.2957.19.camel@pasglop>	<500D7921.6060804@freescale.com>
 <1343082030.2957.38.camel@pasglop>
 <CAOZdJXXd6GuLAed_Z4zNMjDN+DBBXHdd0yVRHof+BJ_eiUMbqQ@mail.gmail.com>
 <1343085145.2957.44.camel@pasglop> <500DDB1B.9030900@freescale.com>
 <1343086186.2957.46.camel@pasglop> <1343086215.2957.47.camel@pasglop>
In-Reply-To: <1343086215.2957.47.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Xie Shaohui-B21989 <B21989@freescale.com>,
 Hu Mingkai-B21284 <B21284@freescale.com>,
 Chen Yuanquan-B41889 <B41889@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2012 06:30 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2012-07-24 at 09:29 +1000, Benjamin Herrenschmidt wrote:
> 
>> The layers in between, not the well behaved drivers. Again, we have
>> ZONE_DMA32 specifically for the purpose, why use something else ?
>>
>> In any case, make the whole thing at the very least a config option, I
>> don't want sane HW to have to deal with split zones.
> 
> Or if possible a flag set by machine probe()

I suggested making the threshold configurable by platform code.  Sane
hardware would leave it at its default of infinity (~0ULL), and you
wouldn't have a split zone.  Our hardware would set it at 31-bit.

It looks like this is already sort-of done for ISA_DMA_THRESHOLD for
32-bit non-coherent-DMA platforms (amigaone sets a 24-bit threshold),
though I don't see where ZONE_DMA is limited accordingly.

We'd add an additional threshold for ZONE_DMA32, make it actually affect
the zone definition, and make the standard alloc_coherent() honor it.

-Scott
