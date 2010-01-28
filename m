Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id D6BEEB7CFC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Jan 2010 11:01:10 +1100 (EST)
Date: Wed, 27 Jan 2010 16:01:21 -0800 (PST)
Message-Id: <20100127.160121.71577531.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [RFC PATCH] PCI-E broken on PPC (regression)
From: David Miller <davem@davemloft.net>
In-Reply-To: <1264629612.3601.176.camel@pasglop>
References: <1264558256.3601.153.camel@pasglop>
	<20100127082624.4a91323a@jbarnes-piketon>
	<1264629612.3601.176.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-pci@vger.kernel.org, fubar@us.ibm.com, jbarnes@virtuousgeek.org,
	ron.mercer@qlogic.com, kaneshige.kenji@jp.fujitsu.com,
	linuxppc-dev@lists.ozlabs.org, leitao@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 28 Jan 2010 09:00:12 +1100

> On Wed, 2010-01-27 at 08:26 -0800, Jesse Barnes wrote:
>> 
>> Thanks Ben.  Any refactoring we need to handle this stuff better is
>> fine with me too.  I guess on some platforms calling pci_setup_device
>> may cause problems with special platform devices? 
> 
> Well, we don't call pci_setup_device() because part of the deal is to
> avoid all of that config space reading that it does :-) Especially in
> the case of some of the IBM EADS bridges which don't let you access
> everything we may want.

Same problem on sparc64, it's not safe to poke config space
arbitrarily.  Some PCI controllers even have bugs which cause them to
hang if you try to access some parts of the host controller's PCI
config space.
