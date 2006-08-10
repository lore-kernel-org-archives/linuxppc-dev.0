Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71A3F67B60
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 19:23:23 +1000 (EST)
Subject: Re: [PATCH][0/2] RTAS MSI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1155198129.9801.92.camel@localhost.localdomain>
References: <1154024154.29826.229.camel@goblue>
	<1154062599.21801.40.camel@localhost.localdomain>
	<802085A1-AA37-4787-A2D6-B619C6BE7AB4@kernel.crashing.org>
	<1155090210.7087.4.camel@localhost.localdomain>
	<F5E5EF18-6452-4E9D-8A43-6D1CE9C3E43E@kernel.crashing.org>
	<1155119228.6949.24.camel@localhost.localdomain>
	<1155138084.17187.53.camel@localhost.localdomain>
	<1155198129.9801.92.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 11:23:10 +0200
Message-Id: <1155201790.17187.138.camel@localhost.localdomain>
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


> Hmm. As I read the PAPR the firmware calls may do just that (pp 122).
> ie. it doesn't differentiate between MSIs and MSI-Xs as far as I can
> tell. So if we implement pci_enable_msi() via the RTAS calls we might be
> violating that constraint.

It's pretty screwed up .... I don't know what is a proper way out there.

> > pci_enable_msi() should call the firmware to reconfigure for only one
> > MSI and enable just that. MSI-X is the only really sexy thing anyway
> > (that and a way to spread MSI-X accross CPUs from the kernel but that's
> > another topic)
> 
> And the current implementation doesn't do that either, so we should fix
> it to only allocate 1 MSI, regardless of what firmware has set.

Yes.

Ben.
