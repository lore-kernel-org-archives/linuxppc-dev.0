Message-ID: <36b714c804080306175c5dc3f6@mail.gmail.com>
Date: Tue, 3 Aug 2004 09:17:49 -0400
From: Brian Waite <linwoes@gmail.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH] Workaround for 745x data corruption bug
Cc: Adrian Cox <adrian@humboldt.co.uk>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <410E85EE.8050707@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <1091291276.987.57.camel@localhost> <410E85EE.8050707@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Well that sucks (the bug, not the patch :).  Many people like to turn
> off coherency when using Marvell host bridges b/c they struggle
> performance-wise with coherency on (at least on some versions).
>
> One change to the patch, though.  According to the 7447/7457 errata doc,
> rev 1.2 doesn't have the bug.  The attached patch accounts for that.
>
> Mark
> --

Mark,

Looking at this errata, I don't think poeple using Marvell chips will
be affected by this errata.
I don't see this as impacting the IO subsystem only the internal MPX system. IE
using a 2 74xx system and not using the M bit. This race can also
occur on a single processor system with the M disabled, as it is in
Linux, but it has nothing to do with the memory controller mapping its
PCI<->mem windows as non cacheable. You should be able to boost the IO
throughput using non coherency without this errata impacting you any
more than it already is.

Anyone please correct me if I am wrong because I need to know.

Thanks
Brian

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
