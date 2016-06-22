Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZTQX6TJtzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 01:43:32 +1000 (AEST)
Message-ID: <1466610203.11733.8.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/3] powerpc/pnv/pci: Fix incorrect PE reservation
 attempt on some 64-bit BARs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 23 Jun 2016 01:43:23 +1000
In-Reply-To: <20160622103219.GA5978@gwshan>
References: <1466580379.4089.27.camel@kernel.crashing.org>
 <20160622103219.GA5978@gwshan>
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

On Wed, 2016-06-22 at 20:32 +1000, Gavin Shan wrote:
> In pci_read_bridge_mmio_pref(), no prefetchable window (64bits+pref)
> is populated if bit PCI_PREF_RANGE_TYPE_64 (0x1) isn't set on PCI
> config register (PCI_PREF_MEMORY_BASE, 0x24). During the resource
> resizing and assigning stage in PCI core, all resources including
> 64-bits prefetchable resources will be covered by 32-bits bridge
> window.

Yeah ok, that's it, thanks !

Cheers,
Ben.
