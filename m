Return-Path: <SRS0+7cfff2985c2512d6f44d+1401+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C111DDE45
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 15:53:17 +1000 (EST)
Date: Mon, 25 Jun 2007 06:53:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] pcmcia: ppc64 needs 32-bit ioaddr_t
Message-ID: <20070625055304.GA1057@infradead.org>
References: <20070625005439.GA31289@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070625005439.GA31289@lixom.net>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org,
	paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jun 24, 2007 at 07:54:39PM -0500, Olof Johansson wrote:
> ppc64 really needs ioaddr_t to be 32-bit, since I/O addresses really are
> MMIO addresses, and remapped at an offset that's well above 16 bits in
> some cases.
> 
> While the type is exported to userspace, there hasn't been any platforms
> with PCMCIA on 64-bit powerpc until now, so changing it won't regress
> any existing users.

Drivers should be using kio_addr_t, please fix up the remaining drivers
to do this instead of chaning the user-visible type.
