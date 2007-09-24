Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 69039DDE2B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Sep 2007 03:06:39 +1000 (EST)
Message-ID: <46F7EE95.1040509@scram.de>
Date: Mon, 24 Sep 2007 19:06:29 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH4/4] [POWERPC] Fix cpm_uart driver
References: <46F6C9DC.90008@scram.de> <46F7DE85.7000401@freescale.com>
In-Reply-To: <46F7DE85.7000401@freescale.com>
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

Scott Wood schrieb:
> Jochen Friedrich wrote:
>>
>> In cpm_uart_core, functions cpm_uart_init_bd and cpm_uart_init_scc
>> an offset into DP RAM is calculated by substracting a physical
>> memory constant from an virtual address. This patch fixes the
>> problem by converting the virtual address into a physical
>> first.
>
> Huh?  DPRAM_BASE is a virtual address.  With this patch, you'd be 
> subtracting a virtual address from a physical address.

Thanks for pointing me to it. So the bug is in cpm_uart_cpm1.h assigning 
a physical memory to DPRAM_BASE (at least on ARC=ppc). cpm_uart_cpm2.h 
seems to be correct though. I'll submit a new patch for this.

Thanks,
Jochen
