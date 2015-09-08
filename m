Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C37A1A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 22:05:02 +1000 (AEST)
In-Reply-To: <20150904182252.GN47557@linux.vnet.ibm.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Hari Bathini <hbathini@in.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Jan Stancek <jstancek@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [v2] powerpc/powernv/pci-ioda: fix kdump with non-power-of-2
 crashkernel=
Message-Id: <20150908120502.4219C140307@ozlabs.org>
Date: Tue,  8 Sep 2015 22:05:02 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-09 at 18:22:52 UTC, Nishanth Aravamudan wrote:
> The 32-bit TCE table initialization relies on the DMA window having a
> size equal to a power of 2 (and checks for it explicitly). But
> crashkernel= has no constraint that requires a power-of-2 be specified.
> This causes the kdump kernel to fail to boot as none of the PCI devices
> (including the disk controller) are successfully initialized.
> 
> After this change, the PCI devices successfully set up the 32-bit TCE
> table and kdump succeeds.
> 
> Fixes: aca6913f5551 ("powerpc/powernv/ioda2: Introduce helpers to allocate TCE pages")
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Cc: stable@vger.kernel.org # 4.2
> Tested-by: Jan Stancek <jstancek@redhat.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/fa14486979b3a47307bcdb10

cheers
