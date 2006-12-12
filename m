Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 72FE167EFA
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 22:46:19 +1100 (EST)
Date: Tue, 12 Dec 2006 20:45:33 +0900 (JST)
Message-Id: <200612121145.kBCBjX3b011783@toshiba.co.jp>
To: sfr@canb.auug.org.au
Subject: Re: [PATCH 14/15] powerpc: avoid claiming some PCI bus
In-Reply-To: <20061212163220.b17d83cd.sfr@canb.auug.org.au>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> On Tue, 12 Dec 2006 13:39:23 +0900 (JST) Ishizaki Kou <kou.ishizaki@toshiba.co.jp> wrote:
> >
> > +#ifdef CONFIG_PPC_MULTIPLATFORM
> > +	    list_for_each_entry(b, &pci_root_buses, node) {
> > +				   if (!machine_is(celleb) ||
> > +				          ppc_md.pci_probe_mode(b) == PCI_PROBE_DEVTREE)
> > +								      pcibios_claim_one_bus(b);
> > +								      }
> > +#else
> >	list_for_each_entry(b, &pci_root_buses, node)
> >			       pcibios_claim_one_bus(b);
> > +#endif
> 
> All 64 bit platforms now have CONFIG_PPC_MULTIPLATFORM set, I think.

Thanks, we will remove #ifdef from this patch.

Best regards,
Kou Ishizaki
