From: Frank Smith <smith@amirix.com>
To: Dan Malek <dan@netx4.com>
cc: "Mark S. Mathews" <mark@absoval.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can't mmap the top 1MB of /dev/mem?
In-Reply-To: <39525D02.AA611102@embeddededge.com>
Message-Id: <00Jun22.160620adt.7305@dragon.appliedmicro.ns.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Date: Thu, 22 Jun 2000 16:06:17 -0300
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 22 Jun 2000, Dan Malek wrote:

>
> Frank Smith wrote:
>
> > Wouldn't this account for it?
>
>
> No.  Those are virtual address calculations in that file........

Oops. Upon thinking about this a bit more, the problem we were having
was that we were trying to get physical 0xfe000000 mapped to virtual
0xfe000000.

The board we're using has firmware that we want to be able to call
after Linux is up and running. The FW runs from 0x3000-0x60000, but
refers to data up in 0xfe space. Our first naive attempts were to
use mmap from userland, but we ended up putting stuff in the kernel
and mapping flash directly with remap_page_range().


Frank.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
