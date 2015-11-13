Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 526061A09E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 11:23:54 +1100 (AEDT)
Message-ID: <1447374203.3081.12.camel@kernel.crashing.org>
Subject: Re: [PATCH v7 39/50] powerpc/powernv: Fundamental reset in
 pnv_pci_reset_secondary_bus()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Axtens <dja@axtens.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, mpe@ellerman.id.au,
 aik@ozlabs.ru, bhelgaas@google.com, grant.likely@linaro.org,
 robherring2@gmail.com, panto@antoniou-consulting.com,
 frowand.list@gmail.com
Date: Fri, 13 Nov 2015 11:23:23 +1100
In-Reply-To: <87fv0azrpe.fsf@gamma.ozlabs.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-40-git-send-email-gwshan@linux.vnet.ibm.com>
 <87fv0azrpe.fsf@gamma.ozlabs.ibm.com>
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

On Fri, 2015-11-13 at 11:08 +1100, Daniel Axtens wrote:
> Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
> 
> >  void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
> >  {
> > -> > 	> > pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
> > +> > 	> > int option, freset = 0;
> > +
> > +> > 	> > if (dev->subordinate)
> > +> > 	> > 	> > pci_walk_bus(dev->subordinate,
> > +> > 	> > 	> > 	> >      pnv_pci_dev_reset_type, &freset);
> > +
> > +> > 	> > option = freset ? EEH_RESET_FUNDAMENTAL : EEH_RESET_HOT;
> > +> > 	> > pnv_eeh_bridge_reset(dev, option);
> 
> According to the skiboot sources, fundamental reset isn't supported on
> p5ioc2. As far as I can tell from your corresponding skiboot patches,
> this is still the case after they are applied. Do we need a fallback to
> EEH_RESET_HOT in this case? Otherwise there will be no reset performed
> at all.

We don't really care that much about what happens on p5ioc2 :-)

> Likewise, if the FUNDAMENTAL reset fails for any reason, should we fall
> back to a HOT reset?

Probably.

Cheers,
Ben.
