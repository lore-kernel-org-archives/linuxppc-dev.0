Return-Path: <bhelgaas@google.com>
Received: from mail-vb0-f74.google.com (mail-vb0-f74.google.com
 [209.85.212.74])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A49512C0145
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 09:12:13 +1000 (EST)
Received: by vbnl22 with SMTP id l22so630817vbn.3
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2012 16:12:11 -0700 (PDT)
Date: Mon, 16 Jul 2012 17:12:07 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 0/7] minimal alignment for p2p bars
Message-ID: <20120716231207.GA32203@google.com>
References: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1340949637.git.shangw@linux.vnet.ibm.com>
Cc: yinghai@kernel.org, linux-pci@vger.kernel.org, linuxram@us.ibm.com,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 16, 2012 at 11:30:23PM +0800, Gavin Shan wrote:
> v1 -> v2:
> 	* Shorten the varaible names so that they looks more short.
> 	* Changelog adjustment so that they looks more meaningful.
> 
> v2 -> v3:
> 	* Rebase to 3.5.RC4
> 
> v3 -> v4:
> 	* Merge Yinghai's patches.
> 
> v3 -> v4:
> 	* Split patch for easy review.
> 	* Add function to retrieve the minimal alignment of p2p bridge. 
> 
> v4 -> v5:
> 	* Rebase to 3.5.RC7
> 	* Introduce weak function pcibios_window_alignment() to retrieve
> 	  I/O and memory alignment for P2P bridges.
> 	* Introduce pcibios_window_alignment() for ppc to override the
> 	  PCI function.
> 	* Add ppc_md.pcibios_window_alignment() for specific platform like
> 	  powernv can override ppc's pcibios_window_alignment().

You don't have to rebase your patches -- I can take care of merging
them with previous patches I've applied -- but if you *do* rebase,
the most convenient target would be my "next" branch, since it
already contains the things I would have to merge with.

> Lu Yinghai(3):
>   pci: change variable name for find_pci_host_bridge
>   pci: argument pci_bus for find_pci_host_bridge
>   pci: fiddle with conversion of pci and CPU address

I think the above patches are not needed for the ones below, are they?

> Gavin Shan(4)
>   pci: weak function returns alignment
>   pci: resource assignment based on p2p alignment
>   ppc/pci: override pcibios_window_alignment
>   ppc/pnv: I/O and memory alignment for p2p bridges
> 
> 
> arch/powerpc/include/asm/machdep.h        |    3 ++
> arch/powerpc/kernel/pci-common.c          |   20 +++++++++++
> arch/powerpc/platforms/powernv/pci-ioda.c |   41 ++++++++++++++++++++++
> drivers/pci/host-bridge.c                 |   52 ++++++++++++++++++++++-------
> drivers/pci/setup-bus.c                   |   22 ++++++++----
> include/linux/pci.h                       |    7 +++-
> 6 files changed, 125 insertions(+), 20 deletions(-)
> 
> Thanks,
> Gavin
> 
