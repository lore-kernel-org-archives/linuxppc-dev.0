Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F5A81A01EC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 05:30:15 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Mon, 7 Mar 2016 11:30:11 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id C6D821FF004B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 11:18:17 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u27IU8P039976996
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 11:30:08 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u27IU5Tg029039
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 11:30:07 -0700
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 1/7] cxlflash: Simplify PCI registration
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1457128520-53056-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Date: Mon, 7 Mar 2016 12:30:01 -0600
Cc: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Message-Id: <00C55C63-2A27-4F3D-AECB-B5D677BE90B5@linux.vnet.ibm.com>
References: <1457128424-53017-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1457128520-53056-1-git-send-email-ukrishn@linux.vnet.ibm.com>
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Mar 4, 2016, at 3:55 PM, Uma Krishnan <ukrishn@linux.vnet.ibm.com> =
wrote:
>=20
> From: "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
>=20
> The calls to pci_request_regions(), pci_resource_start(),
> pci_set_dma_mask(), pci_set_master() and pci_save_state() are all
> unnecessary for the IBM CXL flash adapter since data buffers
> are not required to be mapped to the device's memory.
>=20
> The use of services such as pci_set_dma_mask() are problematic on
> hypervisor managed systems as the IBM CXL flash adapter is operating
> under a virtual PCI Host Bridge (virtual PHB) which does not support
> these services.
>=20
> cxlflash 0001:00:00.0: init_pci: Failed to set PCI DMA mask rc=3D-5
>=20
> The resolution is to simplify init_pci(), to a point where it does the
> bare minimum (pci_enable_device). Similarly, remove the call the
> pci_release_regions() from cxlflash_remove().
>=20
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>

Acked-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
