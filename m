Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 77112B708C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  2 Aug 2009 17:51:05 +1000 (EST)
Subject: Re: [PATCH] Stop pci_set_dma_mask() from failing when RAM doesn't
	exceed the mask anyway
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1249117220.20192.1083.camel@macbook.infradead.org>
References: <1249069310.20192.220.camel@macbook.infradead.org>
	<1249079105.1509.95.camel@pasglop>
	<1249113285.20192.961.camel@macbook.infradead.org>
	<1249113656.1509.125.camel@pasglop>
	<1249117220.20192.1083.camel@macbook.infradead.org>
Content-Type: text/plain
Date: Sun, 02 Aug 2009 17:50:37 +1000
Message-Id: <1249199437.12047.11.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-08-01 at 10:00 +0100, David Woodhouse wrote:
> I'm not sure. Losing 16MiB on a machine which only has 512MiB anyway
> doesn't seem ideal, and we'll want to make the no-iommu code DTRT
> _anyway_, surely?
>
> So we might as well let the DART keep its existing logic (which is
> only
> to bother if we have more than 1GiB of RAM; 

Ah right, so when do we enable the DART ? Above 1G ? I though it was
above 2G but we may well have moved that down to 1G just for b43 indeed.

I definitely agree on the fix to the mask so it only compares to the
available RAM. I'll check that in when I'm back from the snow fields 
on tuesday :-)

Cheers,
Ben,
