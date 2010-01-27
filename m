Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 66F30B7CF4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Jan 2010 09:00:43 +1100 (EST)
Subject: Re: [RFC PATCH] PCI-E broken on PPC (regression)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
In-Reply-To: <20100127082624.4a91323a@jbarnes-piketon>
References: <4B5D9FC5.5070600@linux.vnet.ibm.com>
	<20100125123849.111fa2d1@jbarnes-piketon>
	<20100125175025.4c74f412@jbarnes-piketon>
	<1264558256.3601.153.camel@pasglop>
	<20100127082624.4a91323a@jbarnes-piketon>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 28 Jan 2010 09:00:12 +1100
Message-ID: <1264629612.3601.176.camel@pasglop>
Mime-Version: 1.0
Cc: Linux PCI <linux-pci@vger.kernel.org>, Jay Vosburgh <fubar@us.ibm.com>,
	David Miller <davem@davemloft.net>, Ron Mercer <ron.mercer@qlogic.com>,
	kaneshige.kenji@jp.fujitsu.com, linuxppc-dev@lists.ozlabs.org,
	Breno Leitao <leitao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-01-27 at 08:26 -0800, Jesse Barnes wrote:
> 
> Thanks Ben.  Any refactoring we need to handle this stuff better is
> fine with me too.  I guess on some platforms calling pci_setup_device
> may cause problems with special platform devices? 

Well, we don't call pci_setup_device() because part of the deal is to
avoid all of that config space reading that it does :-) Especially in
the case of some of the IBM EADS bridges which don't let you access
everything we may want.

Cheers,
Ben.
