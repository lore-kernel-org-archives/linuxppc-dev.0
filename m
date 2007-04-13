Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BF907DDF58
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 12:43:57 +1000 (EST)
Subject: Re: qla_wxyz pci_set_mwi question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
In-Reply-To: <461EEDAA.7090503@oracle.com>
References: <20070411221507.69c97257.randy.dunlap@oracle.com>
	<20070412172038.GG10124@andrew-vasquezs-computer.local>
	<20070412185347.GL26692@parisc-linux.org>
	<20070412193713.GB14510@andrew-vasquezs-computer.local>
	<20070412200438.GM26692@parisc-linux.org>
	<1176431662.5764.56.camel@localhost.localdomain>
	<461EEDAA.7090503@oracle.com>
Content-Type: text/plain
Date: Fri, 13 Apr 2007 12:43:43 +1000
Message-Id: <1176432224.5764.59.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: scsi <linux-scsi@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>,
	gregkh <greg@kroah.com>, David Somayajulu <david.somayajulu@qlogic.com>,
	linuxppc-dev@ozlabs.org, Andrew Vasquez <andrew.vasquez@qlogic.com>,
	linux-driver@qlogic.com, PCI <linux-pci@atrey.karlin.mff.cuni.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Willy was referring to this from include/asm-powerpc/pci.h:
> 
> #ifdef CONFIG_PPC64
> 
> /*
>  * We want to avoid touching the cacheline size or MWI bit.
>  * pSeries firmware sets the cacheline size (which is not the cpu cacheline
>  * size in all cases) and hardware treats MWI the same as memory write.
>  */
> #define PCI_DISABLE_MWI
> 
> 
> which makes pci_set_mwi() do nothing other than return 0;

Interesting... I think I missed that we had that bit for some time :-)

Well, I suppose that on pSeries and probably pmac too, the firmware will
set the MWI bit for us anyway, but that's a bit dodgy to apply that to
all ppc64... they aren't all pSeries.

I'll have to look into that again one of these days.

Cheers,
Ben.
