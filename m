Return-Path: <olof@lixom.net>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B7A8DB6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2012 14:54:56 +1100 (EST)
Received: by pbcwy12 with SMTP id wy12so753701pbc.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Mar 2012 19:54:54 -0800 (PST)
Date: Sun, 4 Mar 2012 19:54:51 -0800
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 09/11] powerpc/PCI: replace pci_probe_only with
 pci_flags
Message-ID: <20120305035451.GB32675@quad.lixom.net>
References: <20120222181556.27513.9413.stgit@bhelgaas.mtv.corp.google.com>
 <20120222181948.27513.96215.stgit@bhelgaas.mtv.corp.google.com>
 <1329946899.20389.9.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329946899.20389.9.camel@pasglop>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 23, 2012 at 08:41:39AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2012-02-22 at 11:19 -0700, Bjorn Helgaas wrote:
> >  int maple_pci_get_legacy_ide_irq(struct pci_dev *pdev, int channel)
> > diff --git a/arch/powerpc/platforms/pasemi/pci.c
> > b/arch/powerpc/platforms/pasemi/pci.c
> > index b6a0ec4..b27d886 100644
> > --- a/arch/powerpc/platforms/pasemi/pci.c
> > +++ b/arch/powerpc/platforms/pasemi/pci.c
> > @@ -231,7 +231,7 @@ void __init pas_pci_init(void)
> >         pci_devs_phb_init();
> >  
> >         /* Use the common resource allocation mechanism */
> > -       pci_probe_only = 1;
> > +       pci_add_flags(PCI_PROBE_ONLY);
> >  }
> 
> Olof, do you remember why you used to set that on pasemi ?

Oops, going through email backlog. Sorry for the slow response.

> I would have expected it to be clear, so the kernel can re-assign things
> if needed. We really only want it set for pseries because of the
> hypervisor being a PITA :-)

Well, we did have some hypervisor work done at PA Semi too, and chances
are it's from there. But it's unlikely since I think we booted pseries
(PAPR) kernels under rHype.

I suspect we just went with it for whatever legacy reasons and didn't
revisit later -- since our firmware enumerated busses reliably there
was no reason to redo it from the kernel.

I've booted a system with pci_probe_only off here, and it seems happy
enough. I'll send you a patch.

Bjorn, that means you can drop this chunk of the patch, I suppose.


-Olof
