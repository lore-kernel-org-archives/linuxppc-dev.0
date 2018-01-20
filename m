Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zNtKS31XRzF0kK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jan 2018 20:52:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, andrew.donnellan@au1.ibm.com,
 alastair@au1.ibm.com
Subject: Re: [PATCH 02/13] powerpc/powernv: Set correct configuration space
 size for opencapi devices
In-Reply-To: <386af9b4afde2a0f9cd699d79b0fdf3e4fc0e2d7.1513608243.git.fbarrat@linux.vnet.ibm.com>
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
 <386af9b4afde2a0f9cd699d79b0fdf3e4fc0e2d7.1513608243.git.fbarrat@linux.vnet.ibm.com>
Date: Sat, 20 Jan 2018 20:52:29 +1100
Message-ID: <87607wc0wy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> From Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
> The configuration space for opencapi devices doesn't have a PCI
> Express capability, therefore confusing linux in thinking it's of an
> old PCI type with a 256-byte configuration space size, instead of the
> desired 4k. So add a PCI fixup to declare the correct size.
>
>
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index c37b5d288f9c..b8ec76aa266f 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -4079,6 +4079,16 @@ void __init pnv_pci_init_npu2_opencapi_phb(struct device_node *np)
>  	pnv_pci_init_ioda_phb(np, 0, PNV_PHB_NPU_OCAPI);
>  }
>  
> +static void pnv_npu2_opencapi_cfg_size_fixup(struct pci_dev *dev)
> +{
> +	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> +	struct pnv_phb *phb = hose->private_data;
> +
> +	if (phb->type == PNV_PHB_NPU_OCAPI)
> +		dev->cfg_size = PCI_CFG_SPACE_EXP_SIZE;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pnv_npu2_opencapi_cfg_size_fixup);

On my Power8 PowerVM LPAR:

  [    0.096846] PCI: Probing PCI hardware
  [    0.096878] PCI host bridge to bus 0015:70
  [    0.096883] pci_bus 0015:70: root bus resource [mem 0x3fc0c0000000-0x3fc0cfffffff] (bus address [0xc0000000-0xcfffffff])
  [    0.096888] pci_bus 0015:70: root bus resource [mem 0x301800000000-0x301bffffffff] (bus address [0x3d01800000000-0x3d01bffffffff])
  [    0.096892] pci_bus 0015:70: root bus resource [bus 70-ff]
  [    0.097523] Unable to handle kernel paging request for data at address 0x00000008
  [    0.097526] Faulting instruction address: 0xc0000000000b3330
  [    0.097530] Oops: Kernel access of bad area, sig: 11 [#1]
  [    0.097532] LE SMP NR_CPUS=2048 NUMA pSeries
  [    0.097536] Modules linked in:
  [    0.097539] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc2-gcc7x-gf93b9d8 #1
  [    0.097543] task: 000000007ef679b5 task.stack: 00000000c7c0b3f9
  [    0.097546] NIP:  c0000000000b3330 LR: c00000000067ee78 CTR: c0000000000b3300
  [    0.097549] REGS: 0000000012013889 TRAP: 0380   Not tainted  (4.15.0-rc2-gcc7x-gf93b9d8)
  [    0.097552] MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 88000842  XER: 2000000f
  [    0.097559] CFAR: c00000000067ee74 SOFTE: 0 
  [    0.097559] GPR00: c00000000067ee78 c0000003f7583980 c00000000103f000 c0000003fd619800 
  [    0.097559] GPR04: c000000000d9c0e0 c000000000d9c7a0 ffff0a01ffffff10 0000000000000030 
  [    0.097559] GPR08: 0000000000000000 0000000000000000 000000000000ffff c000000000ba3428 
  [    0.097559] GPR12: c0000000000b3300 c00000000fd40000 c00000000000d938 0000000000000000 
  [    0.097559] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
  [    0.097559] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
  [    0.097559] GPR24: c000000000e7b380 0000000000000000 0000000000000000 c0000000010d0088 
  [    0.097559] GPR28: 000000000000ffff c000000000d9c7a0 c0000003fd619800 c0000003fd619800 
  [    0.097595] NIP [c0000000000b3330] pnv_npu2_opencapi_cfg_size_fixup+0x30/0x60
  [    0.097599] LR [c00000000067ee78] pci_do_fixups+0xd8/0x140
  [    0.097602] Call Trace:
  [    0.097605] [c0000003f7583980] [c0000000000607a8] pci_dev_pdn_setup+0x58/0x70 (unreliable)
  [    0.097609] [c0000003f75839b0] [c00000000067ee78] pci_do_fixups+0xd8/0x140
  [    0.097613] [c0000003f7583a00] [c000000000064334] of_create_pci_dev+0x1d4/0x910
  [    0.097617] [c0000003f7583ab0] [c000000000064b98] __of_scan_bus+0x128/0x1e0
  [    0.097621] [c0000003f7583b20] [c00000000006225c] pcibios_scan_phb+0x22c/0x260
  [    0.097625] [c0000003f7583bc0] [c000000000e11648] pcibios_init+0x8c/0xe4
  [    0.097629] [c0000003f7583c40] [c00000000000d6b8] do_one_initcall+0x68/0x1e0
  [    0.097633] [c0000003f7583d00] [c000000000e04534] kernel_init_freeable+0x280/0x36c
  [    0.097636] [c0000003f7583dc0] [c00000000000d95c] kernel_init+0x2c/0x160
  [    0.097640] [c0000003f7583e30] [c00000000000bae8] ret_from_kernel_thread+0x5c/0x74
  [    0.097643] Instruction dump:
  [    0.097646] 3c4c00f9 3842bd00 7c0802a6 fbe1fff8 f8010010 f821ffd1 7c7f1b78 60000000 
  [    0.097652] 60000000 e93f0010 e92900d0 e9290280 <81290008> 2f890003 409e000c 39201000 
  [    0.097659] ---[ end trace 57e6a876df59eda0 ]---


And Power8 KVM guest:

  [    0.271653] PCI: Probing PCI hardware
  [    0.272640] PCI host bridge to bus 0000:00
  [    0.272897] pci_bus 0000:00: root bus resource [io  0x10000-0x1ffff] (bus address [0x0000-0xffff])
  [    0.273127] pci_bus 0000:00: root bus resource [mem 0x100a0000000-0x1101fffffff] (bus address [0x80000000-0xfffffffff])
  [    0.273346] pci_bus 0000:00: root bus resource [bus 00-ff]
  [    0.273610] Unable to handle kernel paging request for data at address 0x00000008
  [    0.273752] Faulting instruction address: 0xc0000000000b0030
  [    0.273878] Oops: Kernel access of bad area, sig: 11 [#1]
  [    0.273972] LE SMP NR_CPUS=2048 NUMA pSeries
  [    0.274068] Modules linked in:
  [    0.274140] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.15.0-rc2-gcc5x-gf93b9d8 #1
  [    0.274283] task: 000000001f3d5330 task.stack: 00000000f3462ef5
  [    0.274405] NIP:  c0000000000b0030 LR: c00000000064aed8 CTR: c0000000000b0000
  [    0.274549] REGS: 000000000ef1a4d9 TRAP: 0380   Not tainted  (4.15.0-rc2-gcc5x-gf93b9d8)
  [    0.274692] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28000222  XER: 20000000
  [    0.274838] CFAR: c00000000064aed4 SOFTE: 0 
  [    0.274838] GPR00: c00000000064aed8 c0000000fea87970 c000000000feec00 c0000000fe184108 
  [    0.274838] GPR04: c000000000d4bbf8 00000000ffffffff 0000000000000008 0000000098968000 
  [    0.274838] GPR08: 0000000000000038 0000000000000000 0000000000000000 0000000000000001 
  [    0.274838] GPR12: c0000000000b0000 c00000000fd40000 c00000000000d798 0000000000000000 
  [    0.274838] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
  [    0.274838] GPR20: 0000000000000000 0000000000000000 0000000000000000 c000000000d987b8 
  [    0.274838] GPR24: c000000000db3894 0000000000000000 c000000000ca7d28 c000000001080088 
  [    0.274838] GPR28: 000000000000ffff c000000000d4c2b8 c0000000fe184108 c0000000fe184108 
  [    0.276032] NIP [c0000000000b0030] pnv_npu2_opencapi_cfg_size_fixup+0x30/0x60
  [    0.276178] LR [c00000000064aed8] pci_do_fixups+0xd8/0x130
  [    0.276269] Call Trace:
  [    0.276317] [c0000000fea87970] [c00000000005eb78] pci_dev_pdn_setup+0x58/0x70 (unreliable)
  [    0.276458] [c0000000fea879a0] [c00000000064aed8] pci_do_fixups+0xd8/0x130
  [    0.276575] [c0000000fea879f0] [c000000000062608] of_create_pci_dev+0x1d8/0x420
  [    0.276715] [c0000000fea87aa0] [c000000000062974] __of_scan_bus+0x124/0x1f0
  [    0.276831] [c0000000fea87b10] [c0000000000604dc] pcibios_scan_phb+0x24c/0x280
  [    0.276967] [c0000000fea87bb0] [c000000000dc16c4] pcibios_init+0x90/0xe8
  [    0.277078] [c0000000fea87c30] [c00000000000d5f8] do_one_initcall+0x138/0x1d0
  [    0.277208] [c0000000fea87cf0] [c000000000db45e8] kernel_init_freeable+0x298/0x378
  [    0.277341] [c0000000fea87dc0] [c00000000000d7bc] kernel_init+0x2c/0x160
  [    0.277454] [c0000000fea87e30] [c00000000000bae8] ret_from_kernel_thread+0x5c/0x74
  [    0.277591] Instruction dump:
  [    0.277662] 3c4c00f4 3842ec00 7c0802a6 fbe1fff8 f8010010 f821ffd1 7c7f1b78 60000000 
  [    0.277804] 60000000 e93f0010 e92900d0 e9290280 <81290008> 2f890003 409e000c 39201000 
  [    0.277950] ---[ end trace df10e6159ca0c179 ]---

cheers
