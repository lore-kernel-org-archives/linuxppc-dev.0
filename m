Message-ID: <3BFC0C87.30658419@linux-m68k.org>
Date: Wed, 21 Nov 2001 21:20:24 +0100
From: Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
To: Armin Kuster <akuster@mvista.com>
Cc: ppcdevel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New API for non cache coherent ppc cpu's
References: <Pine.LNX.4.33.0111211152230.6681-100000@serv> <3BFBF277.A05245D6@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Armin Kuster wrote:

> mapping = pci_map_page(pdev,
>                                virt_to_page(cmd->request_buffer),

This is the problem, virt_to_page doesn't work kmap'ed highmem pages.

> > - I think it was never defined, what should be done if offset/size isn't
> > cache line aligned. That's especially a problem in the invalidate only
> > case. I'd prefer to make this illegal, as it's mostly not a problem for
> > drivers.
>
> wouldn't it also be a problem for consistent_sync?  we don't check for
> offset/size are cache line aligned.

Yes, same problem.

bye, Roman

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
