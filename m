Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A81BEDDDDF
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 11:59:53 +1100 (EST)
Date: Thu, 27 Nov 2008 03:59:49 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <8310162146.20081127035949@emcraft.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re[6]: [PATCH] katmai.dts: extend DMA ranges; add dma/sysace nodes
In-Reply-To: <1227746559.7356.1.camel@pasglop>
References: <200811131149.14715.yur@emcraft.com>
	<1226568352.7178.44.camel@pasglop>
	<1102187680.20081114074513@emcraft.com>
	<1226641289.7178.117.camel@pasglop>
	<1767195957.20081127032002@emcraft.com>
	<1351427808.20081127032633@emcraft.com>
	<1227746559.7356.1.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: sathya.prakash@lsi.com, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, linuxppc-dev@ozlabs.org,
	Ilya Yanok <yanok@emcraft.com>, Eric.Moore@lsi.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday, November 27, 2008 you wrote:

>>  I've implemented (2) (the code is below), and it works. But,=20
>> admittedly, this (working) looks strange to me because of the=20
>> following:
>>  To be able to use 64-bit PCI mapping on PPC32 I had to replace the
>> 'unsigned long' type of pci_dram_offset with 'resource_size_t', which=20
>> on ppc440spe is 'u64'. So, in dma_alloc_coherent() I put the 64-bit=20
>> value into the 'dma_addr_t' handle. I use 2.6.27 kernel for testing,=20
>> which has sizeof(dma_addr_t) =3D=3D sizeof(u32). Thus,=20
>> dma_alloc_coherent() cuts the upper 32 bits of PCI address, and returns=
=20
>> only low 32-bit part of PCI address to its caller. And, regardless of=20
>> this fact, the PCI device does operate somehow (this is the PCI-E LSI=20
>> disk controller served by the drivers/message/fusion/mptbase.c +=20
>> mptsas.c drivers).
>>=20
>>  I've verified that ppc440spe PCI-E bridge's BARs (PECFGn_BAR0L,H) are=
=20
>> configured with the new, 1TB, address value:

> Strange... when I look at pci4xx_parse_dma_ranges() I see it
> specifically avoiding PCI addresses above 4G ... That needs fixing.

 Right, it avoid. I guess you haven't read my e-mail to its end,=20
because my work-around patch, which I referenced there, fixes this :)

diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/sysdev/ppc4xx_=
pci.c
index afbdd48..f748c5b 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/sysdev/ppc4xx_pci.c
@@ -126,10 +126,8 @@ static int __init ppc4xx_parse_dma_ranges(struct pci_c=
ontroller *hose,
                if ((pci_space & 0x03000000) !=3D 0x02000000)
                        continue;

-               /* We currently only support memory at 0, and pci_addr
-                * within 32 bits space
-                */
-               if (cpu_addr !=3D 0 || pci_addr > 0xffffffff) {
+               /* We currently only support memory at 0 */
+               if (cpu_addr !=3D 0) {
                        printk(KERN_WARNING "%s: Ignored unsupported dma ra=
nge"
                               " 0x%016llx...0x%016llx -> 0x%016llx\n",
                               hose->dn->full_name,
@@ -179,18 +177,12 @@ static int __init ppc4xx_parse_dma_ranges(struct pci_=
controller *hose,
                return -ENXIO;
        }

-       /* Check that we are fully contained within 32 bits space */
-       if (res->end > 0xffffffff) {
-               printk(KERN_ERR "%s: dma-ranges outside of 32 bits space\n",
-                      hose->dn->full_name);
-               return -ENXIO;
-       }
  out:
        dma_offset_set =3D 1;
        pci_dram_offset =3D res->start;

-       printk(KERN_INFO "4xx PCI DMA offset set to 0x%08lx\n",
-              pci_dram_offset);
+       printk(KERN_INFO "4xx PCI DMA offset set to 0x%016llx\n",
+              (unsigned long long)pci_dram_offset);
        return 0;
 }

> To implement that trick you definitely need to make dma_addr_t 64 bits.

 Sure. The problem here is that the LSI (the PCI device I want to DMA=20
to/from 1TB PCI addresses) driver doesn't work with this (i.e. it's=20
broken in, e.g., 2.6.28-rc6) on ppc440spe-based platform. It looks=20
like there is no support for 32-bit CPUs with 64-bit physical=20
addresses in the LSI driver. E.g. the following mix in the=20
drivers/message/fusion/mptbase.h code points to the fact that the=20
driver supposes 64-bit dma_addr_t on 64-bit CPUs only:

#ifdef CONFIG_64BIT
#define CAST_U32_TO_PTR(x)      ((void *)(u64)x)
#define CAST_PTR_TO_U32(x)      ((u32)(u64)x)
#else
#define CAST_U32_TO_PTR(x)      ((void *)x)
#define CAST_PTR_TO_U32(x)      ((u32)x)
#endif


#define mpt_addr_size() \
        ((sizeof(dma_addr_t) =3D=3D sizeof(u64)) ? MPI_SGE_FLAGS_64_BIT_ADD=
RESSING : \
                MPI_SGE_FLAGS_32_BIT_ADDRESSING)



 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
