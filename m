Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 03ACDDDEE9
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 16:03:42 +1000 (EST)
Subject: Re: [PATCH] powerpc: Fix warning in pci_64.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20070515143042.987cba34.sfr@canb.auug.org.au>
References: <20070515041705.CCC00DDFC9@ozlabs.org>
	<20070515143042.987cba34.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Tue, 15 May 2007 16:03:33 +1000
Message-Id: <1179209013.32247.147.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-15 at 14:30 +1000, Stephen Rothwell wrote:
> On Tue, 15 May 2007 14:16:35 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> >  void pcibios_add_platform_entries(struct pci_dev *pdev)
> >  {
> > -	device_create_file(&pdev->dev, &dev_attr_devspec);
> > +	int rc = device_create_file(&pdev->dev, &dev_attr_devspec);
> > +	WARN_ON(rc != 0);
> 
> If we really don't care if the file is not created, then it is probably
> worth a comment as to why ...

Well, if it's not created, then something is badly wrong thus a
WARN_ON ... Do you think I should do more ?

Ben.
