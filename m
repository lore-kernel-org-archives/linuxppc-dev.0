Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BD4E8DDE40
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Sep 2007 04:22:31 +1000 (EST)
Message-ID: <46F80049.2030509@freescale.com>
Date: Mon, 24 Sep 2007 13:22:01 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH4/4] [POWERPC] Fix cpm_uart driver
References: <46F6C9DC.90008@scram.de> <46F7DE85.7000401@freescale.com>
	<46F7EE95.1040509@scram.de>
In-Reply-To: <46F7EE95.1040509@scram.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jochen Friedrich wrote:
> Scott Wood schrieb:
>> Jochen Friedrich wrote:
>>>
>>> In cpm_uart_core, functions cpm_uart_init_bd and cpm_uart_init_scc
>>> an offset into DP RAM is calculated by substracting a physical
>>> memory constant from an virtual address. This patch fixes the
>>> problem by converting the virtual address into a physical
>>> first.
>>
>> Huh?  DPRAM_BASE is a virtual address.  With this patch, you'd be 
>> subtracting a virtual address from a physical address.
> 
> Thanks for pointing me to it. So the bug is in cpm_uart_cpm1.h assigning 
> a physical memory to DPRAM_BASE (at least on ARC=ppc). cpm_uart_cpm2.h 
> seems to be correct though. I'll submit a new patch for this.

cpmp is a physical address on arch/ppc?
/me looks at arch/ppc/8xx_io/commproc.c

Yikes.  Please don't change cpm_uart_cpm1.h, as it's correct for 
arch/powerpc, and there are numerous other places that assume cpmp is 
virtual (including in the very same function that assigns it a physical 
address).

You could fix arch/ppc if you want, though it may be easier to wait for 
it to die, and insist on identity maps in the meantime. :-)

-Scott
