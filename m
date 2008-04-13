Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id E1A4EDE115
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 11:31:20 +1000 (EST)
Date: Sat, 12 Apr 2008 18:31:20 -0700 (PDT)
Message-Id: <20080412.183120.265079925.davem@davemloft.net>
To: sshtylyov@ru.mvista.com
Subject: Re: [PATCH] tg3: fix MMIO for PPC 44x platforms
From: David Miller <davem@davemloft.net>
In-Reply-To: <200804122101.22438.sshtylyov@ru.mvista.com>
References: <200804122101.22438.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Date: Sat, 12 Apr 2008 21:01:22 +0400

> The driver stores the PCI resource addresses into 'unsigned long' variable
> before calling ioremap_nocache() on them. This warrants kernel oops when the
> registers are accessed on PPC 44x platforms which (being 32-bit) have PCI
> memory space mapped beyond 4 GB.
> 
> The arch/ppc/ kernel has a fixup in ioremap() that creates an illusion that
> the PCI memory resource is mapped below 4 GB, but arch/powerpc/ code got rid
> of this trick, having instead CONFIG_RESOURCES_64BIT enabled.
> 
> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

Applied, thanks.

I added a bump of the driver version and release date for
the changeset.
