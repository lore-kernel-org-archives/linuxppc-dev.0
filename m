Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vs9D22pgkzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 21:26:10 +1100 (AEDT)
Message-ID: <1490610350.3177.71.camel@kernel.crashing.org>
Subject: Re: [PATCH v9 2/3] PCI: Add a macro to set default alignment for
 all PCI devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Bjorn Helgaas <helgaas@kernel.org>,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alex.williamson@redhat.com,
 gwshan@linux.vnet.ibm.com, aik@ozlabs.ru, paulus@samba.org,
 zhong@linux.vnet.ibm.com
Date: Mon, 27 Mar 2017 21:25:50 +1100
In-Reply-To: <8737dzf2gu.fsf@concordia.ellerman.id.au>
References: <1487141106-2503-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1487141106-2503-3-git-send-email-xyjxie@linux.vnet.ibm.com>
 <20170323205342.GB23612@bhelgaas-glaptop.roam.corp.google.com>
 <8737dzf2gu.fsf@concordia.ellerman.id.au>
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

On Mon, 2017-03-27 at 21:17 +1100, Michael Ellerman wrote:
> > If so, is it acceptable to force that kernel to user 64K alignment
> > even
> > when it's running on non-PowerNV systems?
> 
> Probably, but I'm not sure TBH. Benh will know, I'll try and get his
> attention.

Can we make the alignment PAGE_SIZE ? I think that should be ok as long
as it doesn't try to re-allocate BARs for devices that have already
been properly allocated by firmware (ie, PowerMac, if you mess around
with the MacIO chip on these, bad things will happen).

Cheers,
Ben.
