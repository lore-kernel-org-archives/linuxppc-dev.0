Message-ID: <3E54F2EF.2080601@embeddededge.com>
Date: Thu, 20 Feb 2003 10:23:27 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Gary Thomas <gary@mlbassoc.com>,
	Brian Waite <waite@skycomputers.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Disable cache on 74xx
References: <Pine.GSO.4.21.0302201507510.27212-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> There may be a different behavior for `disabling the data cache globally' and
> `using e.g. dcbf on uncached memory' (with the data cache enabled globally).

I decided to take a diversion and read some processor manuals.  :-)

The behavior of the cache instructions on areas that are not cacheable
for any reason depends upon the cache instruction used.  Some have
no effect, some have unpredictable behavior, some cause alignment/access
traps.  It all depends upon how they would translate/access the cache
and the operation they would perform on a cache line.  We use all
instructions in Linux that would trigger any of the behavior. :-)

The bottom line appears to be you really don't want to execute cache
instructions on areas that are not cached.  This includes global disable
or any method of marking pages uncached.

For Brian, I'm also curious why you think running Linux with disabled caches
will assist in debugging memory controller problems?  If you are looking for
such fine control of the bus cycles for debugging it seems a simple
memory diagnostic used in conjuction with hardware debug tools is a
better approach.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
