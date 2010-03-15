Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1E234B7D86
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 16:55:32 +1100 (EST)
Subject: Re: Problem with PCI bus rescan on 460EX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
In-Reply-To: <1268632006.2335.10.camel@pasglop>
References: <4B8E6FA3.70503@embedded-sol.com>
	<20100310225100.GB27324@ldl.fc.hp.com>	<4B98A0CB.8090103@embedded-sol.com>
	<4B9A07D2.4060801@jp.fujitsu.com> <4B9AC885.3010107@embedded-sol.com>
	<4B9DC820.2060100@jp.fujitsu.com>  <1268632006.2335.10.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Mar 2010 16:54:44 +1100
Message-ID: <1268632484.2335.18.camel@pasglop>
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, Felix Radensky <felix@embedded-sol.com>,
	Alex Chiang <achiang@hp.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-03-15 at 16:46 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2010-03-15 at 14:39 +0900, Kenji Kaneshige wrote:
> > 
> > > Yes, with these lines removed bridge memory window is properly
> > allocated.
> > 
> > These lines are to prevent updating IO or memory windows when there
> > are
> > some devices working behind the bridge. So please note that removing
> > these lines is just for debugging.
> 
> This is not a very good way to do so though. Many firmwares will leave
> those enabled even when the bridges -do- have to be reconfigured.

Bah, my bad ... pci_is_enabled() is confusing... At first sight I would
have thought it would return whether the device command register MEM or
IO enable are set. Instead, it returns whether pci_enable_device() has
been called.

In any case, Felix bridge looks a tad weird. It should really be handled
by a specific hotplug driver imho.

Cheers,
Ben.
