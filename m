Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnW092f37zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 22:33:13 +1100 (AEDT)
In-Reply-To: <20170223032726.943-1-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 frederic.barrat@fr.ibm.com, Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Ian Munsie <ianmunsi@au1.ibm.com>, Andrew Donnellan <andonnel@au1.ibm.com>,
 Gregory Kurz <KURZGREG@fr.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [RESEND] cxl: Route eeh events to all slices for
 pci_channel_io_perm_failure state
Message-Id: <3vnW091trtz9s7t@ozlabs.org>
Date: Tue, 21 Mar 2017 22:33:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-02-23 at 03:27:26 UTC, Vaibhav Jain wrote:
> Fix a boundary condition where in some cases an eeh event with
> state == pci_channel_io_perm_failure wont be passed on to a driver
> attached to the virtual pci device associated with a slice. This will
> happen in case the slice just before (n-1) doesn't have any vPHB bus
> associated with it, that results in an early return from
> cxl_pci_error_detected callback.
> 
> With state==pci_channel_io_perm_failure, the adapter will be removed
> irrespective of the return value of cxl_vphb_error_detected. So we now
> always return PCI_ERS_RESULT_DISCONNECTED for this case i.e even if
> the AFU isn't using a vPHB (currently returns PCI_ERS_RESULT_NONE).
> 
> Fixes: e4f5fc001a6("cxl: Do not create vPHB if there are no AFU configuration records")
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/07f5ab6002a4f0b633f3495157166f

cheers
