Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 99BB4B6F7D
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2011 04:41:45 +1100 (EST)
Received: from mail76-ch1 (localhost [127.0.0.1])	by mail76-ch1-R.bigfish.com
 (Postfix) with ESMTP id B5DAD4A0172	for <linuxppc-dev@ozlabs.org>;
 Mon, 28 Nov 2011 17:42:34 +0000 (UTC)
Received: from CH1EHSMHS016.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.246])	by mail76-ch1.bigfish.com (Postfix) with ESMTP id
 966C1300046
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Nov 2011 17:42:32 +0000 (UTC)
Message-ID: <4ED3C7D0.2040508@freescale.com>
Date: Mon, 28 Nov 2011 11:41:36 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: do not force PHYS_64BIT on the P1022DS
References: <1320349099-22594-1-git-send-email-timur@freescale.com>
 <C0BC3E1D-5FCF-42EC-A030-4F86EC1D76F3@freescale.com>
In-Reply-To: <C0BC3E1D-5FCF-42EC-A030-4F86EC1D76F3@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> If you want me to apply this please also provided a 32-bit .dts for
> p1022ds.  This should be pretty trivial based on my recent .dts
> cleanups.

I think I found another bug in the 36-bit DTS.  Looking at U-Boot, I see this:

#ifdef CONFIG_PHYS_64BIT
#define CONFIG_SYS_PCIE2_MEM_BUS	0xe0000000
#define CONFIG_SYS_PCIE2_MEM_PHYS	0xc20000000ull
#else
#define CONFIG_SYS_PCIE2_MEM_BUS	0xa0000000
#define CONFIG_SYS_PCIE2_MEM_PHYS	0xa0000000
#endif

But the 36-bit DTS has this:

pci0: pcie@ffe09000 {
	reg = <0x0 0xffe09000 0 0x1000>;
	ranges = <0x2000000 0x0 0xa0000000 0xc 0x20000000 0x0 0x20000000
		  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;

I don't think these match.  I think the first 'ranges' line should have 0xe0000000 instead of 0xa0000000.

I see the same problem with the other two PCI busses.  It looks like the physical address is correct, but the BUS address is wrong (it's using the 32-bit bus address instead of the 36-bit bus address).

-- 
Timur Tabi
Linux kernel developer at Freescale
