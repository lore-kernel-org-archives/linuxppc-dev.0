Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7828867B6D
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Nov 2006 09:14:41 +1100 (EST)
Subject: Re: [PATCH 14/16] Resource assignments for PCI devices on Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200611171014.kAHAEPKA011876@toshiba.co.jp>
References: <200611171014.kAHAEPKA011876@toshiba.co.jp>
Content-Type: text/plain
Date: Sat, 18 Nov 2006 09:14:59 +1100
Message-Id: <1163801699.5826.35.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

\
> This is a temporary workaround for following problem.
>    
> On Celleb, values of PCI base addresses of PCI devices which are not
> described in device tree are not initialized before linux starts. So
> we use pci_bus_assign_resources() later to assign resources for them 
> at ppc_md.pcibios_fixup(). But by original code, when
> ppc_md.pcibios_fixup() is called, resources are already claimed and
> pci_bus_assign_resource() does not work to assign resources.
> 
> It may not be a good idea to call pci_bus_assign_resources() at the
> timing of ppc_md.pcibios_fixup(), but we did not find an alternative
> idea.

Hrm.. not everything should be claimed... there should be some space
left to assign remaining devices. I need to look into it. There are
several non resolved issues unfortunately with the ppc64 PCI code vs.
assigning resources. (Well, the issues are with the generic code in fact
which is what ppc64 uses. It tends to not work very well on setups where
some resources have already been assigned and some not).

Ben.
