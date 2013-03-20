Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 3DDBF2C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 16:40:07 +1100 (EST)
Message-ID: <1363757987.18880.31.camel@pasglop>
Subject: Re: [PATCHv2 3/3] ppc64: implemented pcibios_get_speed_cap_mask
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
Date: Wed, 20 Mar 2013 06:39:47 +0100
In-Reply-To: <1363757079-23550-4-git-send-email-lucaskt@linux.vnet.ibm.com>
References: <1363757079-23550-1-git-send-email-lucaskt@linux.vnet.ibm.com>
 <1363757079-23550-4-git-send-email-lucaskt@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Brian King <brking@linux.vnet.ibm.com>,
 Thadeu Cascardo <cascardo@linux.vnet.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Alex Deucher <alexander.deucher@amd.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-03-20 at 02:24 -0300, Lucas Kannebley Tavares wrote:
> Implementation of a architecture-specific pcibios_get_speed_cap_mask.
> This implementation detects bus capabilities based on OF
> ibm,pcie-link-speed-stats property.

The problem with your approach is that it's not a runtime detection...

If the pseries machine is compiled into the kernel binary, it will
override pcibios_get_speed_cap_mask() using the device-tree, regardless
of whether the machine is currently booted on a pseries machine or not.

This wouldn't be a big problem if the pseries
pcibios_get_speed_cap_mask() was capable of doing a fallback to the
generic one if the device-tree property is absent but that isn't the
case.

I think what you need to do is:

  - Make it so the generic one can be called by the override. This can
look a bit tricky but it's better that way. One way to do it is to have
the actual implementation be in a __pci_* variant called by the weak
pcibios_* variant

  - Move the powerpc on to arch/powerpc/kernel/pci-common.c and make
it call a ppc_md.pcibios_get_speed_cap_mask(). If the hook is absent
(NULL), make it call the generic one

  - pseries can then populate the hook in ppc_md. with its custom
variant.

Cheers,
Ben.
