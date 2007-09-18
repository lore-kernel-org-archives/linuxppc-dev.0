Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B8A33DDEAB
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 07:41:45 +1000 (EST)
Subject: Re: [PATCH] [RFC][POWERPC] Merge 32 and 64 bit
	pci_process_bridge_OF_ranges() instances
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vitaly Bordug <vitb@kernel.crashing.org>
In-Reply-To: <20070911224952.9838.46644.stgit@localhost.localdomain>
References: <20070911224952.9838.46644.stgit@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 19 Sep 2007 07:41:38 +1000
Message-Id: <1190151698.6403.114.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-09-12 at 02:49 +0400, Vitaly Bordug wrote:
> We are having 2 different instances of pci_process_bridge_OF_ranges(),
> which makes describing 64-bit physical addresses in non PPC64 case
> impossible.
> 
> This approach inherits pci space parsing, but has a new way to behave
> equally good in both 32bit and 64bit environments. This approach uses
> of_translate_address(), so implies proper ranges <> definition in
> devicetree, where PCI node has its reg on soc bus, and its ranges
> effectively belong to LAW addresses.

Sorry for the delay, I was travelling.

NAK the bits with struct ranges_pci. Don't map structures to those DT
entries. Use a "cursor" pointer and some getter function, like
prom_parse does (maybe export the ones in prom_parse).

Ben.
