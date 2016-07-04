Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjbjg5LqSzDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 15:51:19 +1000 (AEST)
In-Reply-To: <4867f9385a2.1e1ca6c1@auth.smtp.1and1.co.uk>
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Pat Wall <pjwall@mac.com>, aperez@alexperez.com, matthew@a-eon.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>, Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: [v2,RFC] pasemi: Fix boot failure on 4.7-rc1
Message-Id: <3rjbjg4fyfz9sXx@ozlabs.org>
Date: Mon,  4 Jul 2016 15:51:19 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-29-06 at 20:06:28 UTC, Darren Stevens wrote:
> Commit:d6a9996e84ac4beb7713e9485f4563e100a9b03e (powerpc/mm:
>     vmalloc abstraction in preparation for radix) turned kernel memory
>     and IO addresses from #defined constants to variables initialised
>     at runtime.
>     
>     On PA6T systems the setup_arch machine call initialises the onboard
>     PCI-e root-ports, and uses pci_io_base to do this, which is now before
>     its value has been set resulting in a panic right after 'booting 
>     linux via __start()'
> 
>     Move the pci_io_base initialisation to the same place as vmalloc
>     ranges are set (hash__early_init_mmu()/radix__early_init_mmu())
>     
>     Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
>     Signed-off-by: Darren Stevens <darren@stevens-zone.net>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/bfa37087aa04e45f56c41142df

cheers
