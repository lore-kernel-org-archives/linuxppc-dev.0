Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whmL11zdszDqLN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 19:17:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>
Cc: Alastair D'Silva <alastair@au1.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, stable@vger.kernel.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] cxl: Avoid double free_irq() for psl,slice interrupts
In-Reply-To: <20170602165648.18775-1-vaibhav@linux.vnet.ibm.com>
References: <20170602165648.18775-1-vaibhav@linux.vnet.ibm.com>
Date: Tue, 06 Jun 2017 19:17:28 +1000
Message-ID: <87bmq1qxuf.fsf@concordia.ellerman.id.au>
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

Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:

> During an eeh call to cxl_remove can result in double free_irq of
> psl,slice interrupts. This can happen if perst_reloads_same_image == 1
> and call to cxl_configure_adapter() fails during slot_reset
> callback. In such a case we see a kernel oops with following back-trace:
>
> Oops: Kernel access of bad area, sig: 11 [#1]
> Call Trace:
>   free_irq+0x88/0xd0 (unreliable)
>   cxl_unmap_irq+0x20/0x40 [cxl]
>   cxl_native_release_psl_irq+0x78/0xd8 [cxl]
>   pci_deconfigure_afu+0xac/0x110 [cxl]
>   cxl_remove+0x104/0x210 [cxl]
>   pci_device_remove+0x6c/0x110
>   device_release_driver_internal+0x204/0x2e0
>   pci_stop_bus_device+0xa0/0xd0
>   pci_stop_and_remove_bus_device+0x28/0x40
>   pci_hp_remove_devices+0xb0/0x150
>   pci_hp_remove_devices+0x68/0x150
>   eeh_handle_normal_event+0x140/0x580
>   eeh_handle_event+0x174/0x360
>   eeh_event_handler+0x1e8/0x1f0
>
> This patch fixes the issue of double free_irq by checking that
> variables that hold the virqs (err_hwirq, serr_hwirq, psl_virq) are
> not '0' before un-mapping and resetting these variables to '0' when
> they are un-mapped.
>
> Cc: stable@vger.kernel.org

When was the bug introduced? ie. what commit does this fix?

Was it the original submission? So:

  Fixes: f204e0b8cedd ("cxl: Driver code for powernv PCIe based cards for userspace access")

Or does it depend on perst_reloads_same_image, so:

  Fixes: 13e68d8bd05c ("cxl: Allow the kernel to trust that an image won't change on PERST.")

Or something else?

cheers
