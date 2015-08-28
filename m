Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 033381A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 11:32:41 +1000 (AEST)
Message-ID: <1440725560.8076.0.camel@ellerman.id.au>
Subject: Re: [1/2] powerpc/pseries: Fix corrupted pdn list
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Fri, 28 Aug 2015 11:32:40 +1000
In-Reply-To: <20150828010905.GA21981@gwshan>
References: <1440648757-23359-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20150828005535.5B29814018C@ozlabs.org> <20150828010905.GA21981@gwshan>
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

On Fri, 2015-08-28 at 11:09 +1000, Gavin Shan wrote:
> On Fri, Aug 28, 2015 at 10:55:35AM +1000, Michael Ellerman wrote:
> >On Thu, 2015-27-08 at 04:12:36 UTC, Gavin Shan wrote:
> >> Commit cca87d30 ("powerpc/pci: Refactor pci_dn") introduced pdn
> >> list for SRIOV VFs. It means the pdn is be put into the child list
> >> of its parent pdn when the pdn is created. When doing PCI hot
> >> unplugging on pSeries, the PCI device node as well as its pdn are
> >> released through procfs entry "powerpc/ofdt". Some one else grabs
> >> the memory chunk of the pdn and update it accordingly. At the same
> >> time, the pdn is still tracked in the child list of parent pdn. It
> >> leads to corrupted child list in the parent pdn.
> >> 
> >> This fixes above issue by removing the pdn from the child list of
> >> its parent pdn when the device node is detached from the system.
> >> Note the pdn is free'd when the device node is released if the
> >> device node is dynamic one. Otherwise, the device node as well
> >> as the pdn won't be released.
> >> 
> >> Fixes: cca87d30 ("powerpc/pci: Refactor pci_dn")
> >
> >That went into 4.1, so this should presumably go to stable?
> 
> Yeah, This should be put into 4.1 stable.

OK thanks.

I've added:

  Cc: stable@vger.kernel.org # 4.1

cheers
