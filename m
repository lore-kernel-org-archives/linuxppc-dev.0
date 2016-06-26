Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rd6j41R8rzDqhC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 08:50:15 +1000 (AEST)
Message-ID: <1466981401.20278.29.camel@kernel.crashing.org>
Subject: Re: Proposed: Patch to fix boot on PA6T
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
Cc: Pat Wall <pjwall@mac.com>, matthew@a-eon.com, aperez@alexperez.com,
 "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Mon, 27 Jun 2016 08:50:01 +1000
In-Reply-To: <4863e2f8235.599ebfcf@auth.smtp.1and1.co.uk>
References: <4863e2f8235.599ebfcf@auth.smtp.1and1.co.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-06-26 at 18:42 +0100, Darren Stevens wrote:
> 
>     commit d6a9996e84ac4beb7713e9485f4563e100a9b03e
>     powerpc/mm: vmalloc abstraction in preparation for radix
> 
>     This commit introduced variables for some linux kernel addresses that had
> before been constants, unfortunately this stopped PaSemi PA6T systems(*) from
> booting as they call ioremap to map SoC registers before the mmu is initialised. The
> attached patch adds a hard-coded init of pci_io_base to the pas_init_early()
> function which which allows the kernel to boot normally.

Tell me more, when is that mapping done ? I'm changing things so that
platform probe is called much later so that might have an impact.

What consumes pci_io_base before it's been initialized ?

>     The value will be harmlessly set again once pci starts up.
> 
>     (*) At the moment this has only been tested on an AmigaOneX1000, but I
> expect PaSemi
>     reference systems to have been affected in the same way.
