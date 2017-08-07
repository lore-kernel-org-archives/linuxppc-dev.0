Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQnj16jzpzDqnQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 16:30:45 +1000 (AEST)
Message-ID: <1502087439.8488.4.camel@russell.cc>
Subject: Re: [PATCH v4] powerpc/powernv: Enable PCI peer-to-peer
From: Russell Currey <ruscur@russell.cc>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org, benh@kernel.crashing.org,
 brking@linux.vnet.ibm.com, clsoto@linux.vnet.ibm.com
Date: Mon, 07 Aug 2017 16:30:39 +1000
In-Reply-To: <20170804095514.11224-1-fbarrat@linux.vnet.ibm.com>
References: <20170804095514.11224-1-fbarrat@linux.vnet.ibm.com>
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

On Fri, 2017-08-04 at 11:55 +0200, Frederic Barrat wrote:
> P9 has support for PCI peer-to-peer, enabling a device to write in the
> mmio space of another device directly, without interrupting the CPU.
> 
> This patch adds support for it on powernv, by adding a new API to be
> called by drivers. The pnv_pci_set_p2p(...) call configures an
> 'initiator', i.e the device which will issue the mmio operation, and a
> 'target', i.e. the device on the receiving side.
> 
> P9 really only supports mmio stores for the time being but that's
> expected to change in the future, so the API allows to define both
> load and store operations.
> 
>     /* PCI p2p descriptor */
>     #define OPAL_PCI_P2P_ENABLE		0x1
>     #define OPAL_PCI_P2P_LOAD		0x2
>     #define OPAL_PCI_P2P_STORE		0x4
> 
>     int pnv_pci_set_p2p(struct pci_dev *initiator, struct pci_dev *target,
>     			   uint64_t desc)
> 
> It uses a new OPAL call, as the configuration magic is done on the
> PHBs by skiboot.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> ---

Reviewed-by: Russell Currey <ruscur@russell.cc>
