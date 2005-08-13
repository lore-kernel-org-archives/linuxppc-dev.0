Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id 644C867EF1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 13 Aug 2005 13:33:38 +1000 (EST)
Date: Fri, 12 Aug 2005 20:33:35 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050812203335.K30033@cox.net>
References: <c3d0340b0508121811e7b6fc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b0508121811e7b6fc2@mail.gmail.com>;
	from shawnxjin@gmail.com on Fri, Aug 12, 2005 at 06:11:14PM -0700
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: writel(), readl() in <asm-ppc/io.h>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Aug 12, 2005 at 06:11:14PM -0700, Shawn Jin wrote:
> Hi,
> 
> In <asm-ppc/io.h>, writew(), readw(), writel(), and readl() are
> defined to little endian access for all platforms unless either
> CONFIG_APUS or CONFIG_8260_PCI9 is defined.
> 
> Why? Aren't they correct in big endian systems, are they? Maybe I miss
> something here.

I'm not sure what your qustion is but I'll take a stab at an answer. :)

read*()/write*() are accessors for PCI and PCI only.  PCI is little
endian. PPC is big endian.  All platforms must byte swap on access
to PCI memory space except in special cases.  The two exceptions
must byte swap in hardware. Looks like it is due to errata in the
8260 PCI bridge case. APUS is probably byte swapping in hardware
because APUS is simply odd.

-Matt
