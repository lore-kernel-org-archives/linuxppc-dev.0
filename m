Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 476BEDDEBC
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 05:05:58 +1000 (EST)
Date: Fri, 24 Aug 2007 13:11:04 -0500
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] [02/10] pasemi_mac: Stop using the pci config space
	accessors for register read/writes
Message-ID: <20070824181104.GA17171@lixom.net>
References: <20070817205413.548020000@lixom.net>
	<20070822141248.GC16830@lixom.net>
	<20070823181310.GB31882@lixom.net>
	<20070824140531.ff7d66bf.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070824140531.ff7d66bf.sfr@canb.auug.org.au>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 24, 2007 at 02:05:31PM +1000, Stephen Rothwell wrote:
> On Thu, 23 Aug 2007 13:13:10 -0500 Olof Johansson <olof@lixom.net> wrote:
> >
> >  out:
> > -	pci_dev_put(mac->iob_pdev);
> > -out_put_dma_pdev:
> > -	pci_dev_put(mac->dma_pdev);
> > -out_free_netdev:
> > +	if (mac->iob_pdev)
> > +		pci_dev_put(mac->iob_pdev);
> > +	if (mac->dma_pdev)
> > +		pci_dev_put(mac->dma_pdev);
> 
> It is not documented as such (as far as I can see), but pci_dev_put is
> safe to call with NULL. And there are other places in the kernel that
> explicitly use that fact.

Some places check, others do not. I'll leave it be for now but might take
care of it during some future cleanup. Thanks for point it out though.


-Olof
