Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5766167A2E
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 17:40:23 +1000 (EST)
Subject: Re: pci_set_power_state() failure and breaking suspend
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux1394-devel@lists.sourceforge.net
In-Reply-To: <1161672898.10524.596.camel@localhost.localdomain>
References: <1161672898.10524.596.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 17:40:11 +1000
Message-Id: <1161675611.10524.598.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-10-24 at 16:54 +1000, Benjamin Herrenschmidt wrote:
> So I noticed a small regression that I think might uncover a deeper
> issue...
> 
> Recently, ohci1394 grew some "proper" error handling in its suspend
> function, something that looks like:
> 
>         err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
>         if (err)
>                 goto out;
> 
> First, it breaks some old PowerBooks where the internal OHCI had PM
> feature exposed on PCI (the pmac specific code that follows those lines
> is enough on those machines).

If I could type, the above would have read...

First, it breaks some old PowerBooks where the internal OHCI has no PM
feature exposed on PCI....

Ben.
