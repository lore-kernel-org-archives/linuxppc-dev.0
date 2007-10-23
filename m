Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D9100DDEAB
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 10:32:09 +1000 (EST)
Subject: Re: [PATCH 5/7] pci: Export the pci_restore_msi_state() function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20071023001307.GF4280@austin.ibm.com>
References: <1192829817.22064.559.camel@teletran1>
	<20071021.162131.43417026.davem@davemloft.net>
	<1193017764.10318.17.camel@concordia>
	<20071022181336.GC4280@austin.ibm.com>
	<1193088267.6745.108.camel@pasglop>
	<20071023001307.GF4280@austin.ibm.com>
Content-Type: text/plain
Date: Tue, 23 Oct 2007 10:29:24 +1000
Message-Id: <1193099364.6745.168.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, mcarlson@broadcom.com,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, mchan@broadcom.com,
	linux-pci@atrey.karlin.mff.cuni.cz, David Miller <davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > I don't know why you keep talking about powerpc laptops here ... 
> 
> Well, there are Apple laptops, right?  Aren't those the "powermac" 
> platform?  Now, I don't know if they support MSI, but if they do,
> I get the impression that they might not restore msi state correctly,
> after being put into hardware suspend.  But perhaps I'm mistaken;
> I was simply grepping for various msi-related functions in various
> arch subdirectories, comparing x86 to other arches, and noticed 
> that code that would restore msi state seems to be missing for
> most arches and most powerpc platforms.

Ah ok, i see. Well, platforms that use write_msi_msg() shouldn't need
anything special right ? So only pSeries is an issue here....

PowerBooks don't indeed have MSI support, though G5's do and some people
have been toying around with suspend/resume on them (hibernation only at
that stage) but it doesn't matter at this stage. We are specifically
talking about pSeries which is the "special" case here.

Ben.
