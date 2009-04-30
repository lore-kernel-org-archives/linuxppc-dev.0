Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8C10DDDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 07:44:45 +1000 (EST)
Subject: Re: [RFC][PATCH] add support to ppc32 to "use" pci_dn
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0904301604540.25174@localhost.localdomain>
References: <Pine.LNX.4.64.0904301604540.25174@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 01 May 2009 07:44:36 +1000
Message-Id: <1241127876.29501.45.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-04-30 at 16:07 -0500, Kumar Gala wrote:
> Ben,
> 
> This is my cut at unifying a bit of the ppc32 & ppc64 code.  I don't
> specifically intend to use all the OF bits on ppc32, but getting some of
> the structures the same so the non-OF related foo can be common is my
> goal.
> 
> This was all about trying to get pci_bus_to_hose() to be common.

I think a pre-req is to update the pci_dn code to use a similar
technique to ppc32 for linking the device nodes to the pci_dev's
(ie, walking level by level and only using the devfn and not the bus
number to go down in order to be agnostic to bus renumbering).

That way, you can completely switch over ppc32 to pci_dn incuding
pci_device_to_OF_node() etc... in one go.

Cheers,
Ben.
