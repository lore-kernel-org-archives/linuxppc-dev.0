Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7DRC5z8gzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 08:39:51 +1000 (AEST)
Message-ID: <1499899179.2865.42.camel@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/powernv: Enable PCI peer-to-peer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 brking@linux.vnet.ibm.com, clsoto@linux.vnet.ibm.com
Date: Thu, 13 Jul 2017 08:39:39 +1000
In-Reply-To: <20170626180855.28238-1-fbarrat@linux.vnet.ibm.com>
References: <20170626180855.28238-1-fbarrat@linux.vnet.ibm.com>
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

On Mon, 2017-06-26 at 20:08 +0200, Frederic Barrat wrote:
> +       if (desc & OPAL_PCI_P2P_ENABLE) {
> +               pe_init->p2p_initiator_count++;
> +       } else {
> +               if (pe_init->p2p_initiator_count > 0) {
> +                       pe_init->p2p_initiator_count--;
> +                       if (!pe_init->p2p_initiator_count)
> +                               pnv_pci_ioda2_set_bypass(pe_init, true);
> +               }

So you have the initiator refcounting in Linux and the target
refcounting in OPAL ... any reason for that ?

Cheers,
Ben.
