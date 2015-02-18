Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 117FB1A04E0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 11:30:44 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 538FD1401DE
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2015 11:30:42 +1100 (AEDT)
Message-ID: <1424219432.21410.113.camel@kernel.crashing.org>
Subject: Re: [PATCH RESEND v2 7/7] PCI/hotplug: PowerPC PowerNV PCI hotplug
 driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Wed, 18 Feb 2015 11:30:32 +1100
In-Reply-To: <20150218001620.GA22042@shangw>
References: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1424157203-691-8-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150217220916.GA26424@google.com> <20150218001620.GA22042@shangw>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@ozlabs.org,
 linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-02-18 at 11:16 +1100, Gavin Shan wrote:
> >What is vm_unmap_aliases() for?  I see this is probably copied from
> >rpaphp_core.c, where it was added by b4a26be9f6f8 ("powerpc/pseries:
> Flush
> >lazy kernel mappings after unplug operations").
> >
> >But I don't know whether:
> >
> >  - this is something specific to powerpc,
> >  - the lack of vm_unmap_aliases() in other hotplug paths is a bug,
> >  - the fact that we only do this on powerpc is covering up a
> >    powerpc bug somewhere
> >
> 
> Yes, I copied this piece of code from rpaphp_core.c. I think Ben might
> help to answer the questions as he added the patch. I had very quick
> check on mm/vmalloc.c and it's reasonable to have vm_unmap_aliases()
> here to flush TLB entries for ioremap() regions, which were unmapped
> previously. if I'm correct. I don't think it's powerpc specific.

It's specific to running under the PowerVM hypervisor, and thus doesn't
affect PowerNV, just don't copy it over.

It comes from the fact that the generic ioremap code nowadays delays
TLB flushing on unmap. The TLB flushing code is what, on powerpc,
ensures that we remove the translations from the MMU hash table (the
hash table is essentially treated as an extended in-memory TLB), which
on pseries turns into hypervisor calls.

When running under that hypervisor, the HV ensures that no translation
still exists in the hash before allowing a device to be removed from
a partition. If translations still exist, the removal fails.

So we need to force the generic ioremap code to perform all the TLB
flushes for iounmap'ed regions before we "complete" the unplug operation
from a kernel perspective so that the device can be re-assigned to
another partition.

This is thus useless on platforms like powernv which do not run under
such a hypervisor.

Cheers,
Ben.
