Message-ID: <3CFF9903.9000203@embeddededge.com>
Date: Thu, 06 Jun 2002 13:16:51 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: Ppc Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 8260 Network Performance update
References: <NCBBIINEHIPFGJPLBEIFCEECDIAA.acurtis@onz.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Allen Curtis wrote:

> There is a slight improvement when you increase the number of buffers from
> 16 (default) to 32. There does not appear to be any benefit beyond that.

That isn't the number of buffers, it's the number of buffer pages, so don't
go overboard allocating these.  The 8260 is going to fill buffers and shove
packets up the IP stack as fast as they appear on the wire.  Adding buffers
at the driver level will just cover up processing latencies by the application.

> I am guessing that the problem is not in the driver unless the driver is
> suppose to enforce some soft of fair usage algorithm. Is there a network
> usage scheduler of some kind?

The only thing that will happen is the IP stack will start tossing packets
if there is a memory shortfall.

> ..... I do not have this problem on a x86 RedHat
> system...

Are you doing _exactly_ the same thing?  It still looks like you have a
hardware configuration problem on the link, because I know other boards
will operate with the same software at the limit of the 10 or 100 Mbit
throughput.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
