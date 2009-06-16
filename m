Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A1626B715B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 13:27:32 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 068EFDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 13:27:31 +1000 (EST)
Subject: Re: UIO: uio_mem does not handle devices above 4 GB address
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Steven A. Falco" <sfalco@harris.com>
In-Reply-To: <49D4BB9F.8050903@harris.com>
References: <49D4BB9F.8050903@harris.com>
Content-Type: text/plain
Date: Tue, 16 Jun 2009 13:25:58 +1000
Message-Id: <1245122758.12400.52.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, hjk@linutronix.de,
	"Herrera-Bendezu, Luis" <lherrera@harris.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-04-02 at 09:20 -0400, Steven A. Falco wrote:

> struct uio_mem {
> 	phys_addr_t		addr;
> 	phys_addr_t		size;
> 	int			memtype;
> 	void __iomem		*internal_addr;
> 	struct uio_map		*map;
> };
> 
> A few other changes would be needed.  We'd have to use something
> other than

Use a struct resource instead.

> 	return sprintf(buf, "0x%lx\n", mem->addr);
> 

The struct resource has a printk format string.

Cheers,
Ben.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
