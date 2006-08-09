Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 03CBE67B93
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 01:41:39 +1000 (EST)
Subject: Re: [PATCH][0/2] RTAS MSI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1155119228.6949.24.camel@localhost.localdomain>
References: <1154024154.29826.229.camel@goblue>
	<1154062599.21801.40.camel@localhost.localdomain>
	<802085A1-AA37-4787-A2D6-B619C6BE7AB4@kernel.crashing.org>
	<1155090210.7087.4.camel@localhost.localdomain>
	<F5E5EF18-6452-4E9D-8A43-6D1CE9C3E43E@kernel.crashing.org>
	<1155119228.6949.24.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 17:41:24 +0200
Message-Id: <1155138084.17187.53.camel@localhost.localdomain>
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

> So I think we could have pci_enable_msi(dev), which would enable a
> single MSI _or_ MSI-X vector, depending on what's available. That'd be
> used by drivers that just want a simple replacement for LSI. And then
> pci_enable_multi_msi(dev, num_irqs) which would give the driver num_irqs
> MSI or MSI-X vectors.

You cannot lie and have pci_enable_msi() enable an MSI-X vector. Some
cards need additional tweaking when enabling MSI or MSI-X and if the
system enables MSI-X while the driver thinks it's MSI, bad things might
happen.

pci_enable_msi() should call the firmware to reconfigure for only one
MSI and enable just that. MSI-X is the only really sexy thing anyway
(that and a way to spread MSI-X accross CPUs from the kernel but that's
another topic)

Ben.
