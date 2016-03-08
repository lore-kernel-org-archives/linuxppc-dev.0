Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C1131A00BC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 04:54:52 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Tue, 8 Mar 2016 10:54:49 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 04DC71FF0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 10:42:55 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u28HsjZE43974760
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Mar 2016 10:54:45 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u28HsiVU016999
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Mar 2016 10:54:45 -0700
Subject: Re: [PATCH 1/7] cxlflash: Simplify PCI registration
To: linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
References: <1457128424-53017-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1457128520-53056-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Message-ID: <56DF11E6.2010907@linux.vnet.ibm.com>
Date: Tue, 8 Mar 2016 11:54:46 -0600
MIME-Version: 1.0
In-Reply-To: <1457128520-53056-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3/4/2016 3:55 PM, Uma Krishnan wrote:
> From: "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
>
> The calls to pci_request_regions(), pci_resource_start(),
> pci_set_dma_mask(), pci_set_master() and pci_save_state() are all
> unnecessary for the IBM CXL flash adapter since data buffers
> are not required to be mapped to the device's memory.
>
> The use of services such as pci_set_dma_mask() are problematic on
> hypervisor managed systems as the IBM CXL flash adapter is operating
> under a virtual PCI Host Bridge (virtual PHB) which does not support
> these services.
>
> cxlflash 0001:00:00.0: init_pci: Failed to set PCI DMA mask rc=-5
>
> The resolution is to simplify init_pci(), to a point where it does the
> bare minimum (pci_enable_device). Similarly, remove the call the
> pci_release_regions() from cxlflash_remove().
>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>

Reviewed-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
