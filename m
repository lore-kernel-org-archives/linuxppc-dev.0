Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxfX69WkzF0Rs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:10:28 +1000 (AEST)
In-Reply-To: <99f78122-cd53-100f-4f58-be5bf7927d4e@xenosoft.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Darren Stevens <darren@stevens-zone.net>, Bjorn Helgaas <helgaas@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: SB600 for the Nemo board has non-zero devices on non-root bus
Message-Id: <40zxfX40gMz9s08@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-12-06 at 11:03:52 UTC, Christian Zigotzky wrote:
> On 06 December 2017 at 09:37AM, Christian Zigotzky wrote:
>  > On 03 December 2017 at 10:43AM, Christian Zigotzky wrote:
>  > >
>  > > On 3. Dec 2017, at 00:02, Olof Johansson <olof@lixom.net> wrote:
>  > >>
>  > >> Typo, should be ';', not ':'. I obviously didn't even try 
> compiling this. :)
>  > >>
>  > >>
>  > >> -Olof
>  > >
>  > > Hi Olof,
>  > >
>  > > Thanks a lot for your patch! I will test it on Wednesday.
>  > >
>  > > Cheers,
>  > > Christian
>  >
>  >
>  > Hi Olof,
>  >
>  > I tested your patch today. Unfortunately the kernel 4.15-rc2 doesn't 
> compile with your patch.
>  >
>  > Error messages:
>  >
>  >                        ^~~~~~~~~
>  > arch/powerpc/platforms/pasemi/pci.c: In function ‘pas_pci_init’:
>  > arch/powerpc/platforms/pasemi/pci.c:298:2: error: implicit 
> declaration of function ‘pci_set_flag’ 
> [-Werror=implicit-function-declaration]
>  >   pci_set_flag(PCI_SCAN_ALL_PCIE_DEVS);
>  >   ^~~~~~~~~~~~
>  > cc1: some warnings being treated as errors
>  >
>  > ---
>  >
>  > I figured out that we need 'pci_set_flags' instead of 'pci_set_flag'. 
> I modified your patch and after that the kernel compiles. Please find 
> attached the new patch.
>  >
>  > Cheers,
>  > Christian
> 
> Hi Olof,
> 
> Many thanks for your patch! :-) The RC2 of kernel 4.15 boots without any 
> problems on my P.A. Semi Nemo board (A-EON AmigaOne X1000). I don’t need 
> the additional boot argument 'pci=pcie_scan_all' anymore.
> 
> Is it possible to merge it via the powerpc tree?
> 
> Thanks,
> Christian
> 
> arch/powerpc/platforms/pasemi/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
> index 5ff6108..ea54ed2 100644
> --- a/arch/powerpc/platforms/pasemi/pci.c
> +++ b/arch/powerpc/platforms/pasemi/pci.c
> @@ -224,6 +224,8 @@ void __init pas_pci_init(void)
>  		return;
>  	}
>  
> +	pci_set_flags(PCI_SCAN_ALL_PCIE_DEVS);
> +
>  	for (np = NULL; (np = of_get_next_child(root, np)) != NULL;)
>  		if (np->name && !strcmp(np->name, "pxp") && !pas_add_bridge(np))
>  			of_node_get(np);

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/eff06ef0891d200eb0ddd156c6e96c

cheers
