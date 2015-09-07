Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA32D1A2513
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Sep 2015 19:19:10 +1000 (AEST)
Message-ID: <1441617549.8979.5.camel@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/powernv/pci-ioda: fix kdump with
 non-power-of-2 crashkernel=
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Hari Bathini <hbathini@in.ibm.com>, Gavin Shan
 <gwshan@linux.vnet.ibm.com>,  Alexey Kardashevskiy <aik@ozlabs.ru>, Ben
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>, Wei Yang
 <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Jan Stancek
 <jstancek@redhat.com>
Date: Mon, 07 Sep 2015 19:19:09 +1000
In-Reply-To: <20150904182252.GN47557@linux.vnet.ibm.com>
References: <20150904182252.GN47557@linux.vnet.ibm.com>
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

On Fri, 2015-09-04 at 11:22 -0700, Nishanth Aravamudan wrote:
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
> 
> Michael, I kept this as a follow-on patch to my previous one. If you'd
> rather I made a v3 of that patch with the two fixes combined, I can
> resend.

No that's fine. I guess they could have been a single fix, but it's not a big deal.

> Also, I fixed up the context on my end to be u64, but not sure
> if that will match your tree (next doesn't have my prior patch applied
> yet, that I can see).

next isn't open yet, because we're still in the merge window, ie. rc1 hasn't
come out yet.

This is a fix so it'll go to my fixes branch. Whether I send that to Linus
before or after rc1 depends on how urgent the fixes people send me are. Sounds
like you'd like these two to go in asap?

cheers
