Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvL625R9qzDqC4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 10:13:30 +1100 (AEDT)
Date: Thu, 30 Mar 2017 18:13:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alex.williamson@redhat.com, gwshan@linux.vnet.ibm.com,
 aik@ozlabs.ru, paulus@samba.org, zhong@linux.vnet.ibm.com
Subject: Re: [PATCH v9 2/3] PCI: Add a macro to set default alignment for all
 PCI devices
Message-ID: <20170330231326.GB2496@bhelgaas-glaptop.roam.corp.google.com>
References: <1487141106-2503-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1487141106-2503-3-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20170323205342.GB23612@bhelgaas-glaptop.roam.corp.google.com>
 <8737dzf2gu.fsf@concordia.ellerman.id.au>
 <1490610350.3177.71.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1490610350.3177.71.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 27, 2017 at 09:25:50PM +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2017-03-27 at 21:17 +1100, Michael Ellerman wrote:
> > > If so, is it acceptable to force that kernel to user 64K alignment
> > > even
> > > when it's running on non-PowerNV systems?
> > 
> > Probably, but I'm not sure TBH. Benh will know, I'll try and get his
> > attention.
> 
> Can we make the alignment PAGE_SIZE ? I think that should be ok as long
> as it doesn't try to re-allocate BARs for devices that have already
> been properly allocated by firmware (ie, PowerMac, if you mess around
> with the MacIO chip on these, bad things will happen).

I think this *will* change BARs even if they've already been allocated
by firmware, because it affects this path that is used for every
device:

  pci_device_add
    pci_reassigndev_resource_alignment
      pci_specified_resource_alignment
        align = PCIBIOS_DEFAULT_ALIGNMENT

I'm looking for an update that fixes the minor comment issues and
possibly addresses this PowerMac question.

Bjorn
