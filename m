Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CED98DDEAB
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 20:18:16 +1100 (EST)
Message-Id: <0472C239-D0C8-43FE-9996-1C28584EFBAD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20071130061155.41D71DDF5F@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 12/24] powerpc: 4xx PLB to PCI Express support
Date: Fri, 30 Nov 2007 03:18:09 -0600
References: <20071130061155.41D71DDF5F@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 30, 2007, at 12:10 AM, Benjamin Herrenschmidt wrote:

> This adds to the previous 2 patches the support for the 4xx PCI  
> Express
> cells as found in the 440SPe revA, revB and 405EX.
>
> Unfortunately, due to significant differences between these, and other
> interesting "features" of those pieces of HW, the code isn't as simple
> as it is for PCI and PCI-X and some of the functions differ  
> significantly
> between the 3 implementations. Thus, not only this code can only  
> support
> those 3 implementations for now and will refuse to operate on any  
> other,
> but there are added ifdef's to avoid the bloat of building a fairly  
> large
> amount of code on platforms that don't need it.
>
> Also, this code currently only supports fully initializing root  
> complex
> nodes, not endpoint. Some more code will have to be lifted from the
> arch/ppc implementation to add the endpoint support, though it's  
> mostly
> differences in memory mapping, and the question on how to represent
> endpoint mode PCI in the device-tree is thus open.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> 440SPeA is untested, 440SPeB is slightly tested (with a sky2 network  
> card on
> port 0 only for now) and 405EX is untested.
>
> arch/powerpc/Kconfig             |    1
> arch/powerpc/sysdev/Kconfig      |    8
> arch/powerpc/sysdev/ppc4xx_pci.c |  927 +++++++++++++++++++++++++++++ 
> +++++++++-
> arch/powerpc/sysdev/ppc4xx_pci.h |  237 +++++++++
> 4 files changed, 1172 insertions(+), 1 deletion(-)

Is it intentional that you dont support ppc_md.pci_exclude_device()?

- k
