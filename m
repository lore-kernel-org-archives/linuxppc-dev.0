Message-ID: <3C99801A.8070002@embeddededge.com>
Date: Thu, 21 Mar 2002 01:39:22 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
References: <0203210213.AA15856@ivan.Harhan.ORG>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov wrote:


> ......pass this magic info via
> bi_recs (now it's done either with a board #ifdef maze or .config options). I
> don't think there should be .config options for things that are fixed hard in
> PCB traces or in silicon, and board #ifdefs are ugly. bi_recs are the answer.

I don't agree.  I believe if you can't configure the software in the usual
way with configuration options, you can't do it cleanly with bi_recs, either.
There are pin multiplex configurations on 8xx that you just can't (or shouldn't
due to lots of complexity) define in a dynamic manner.  The purpose of the
current Linux configuration is to create a binary that fits a particular board
and architecture.  Not so long ago, we had great discussions over creating kernels
with lots of dynamic configuration that would boot on multiple boards and how
this wasn't suitable for embedded processors due to limited resources.  We
painstakingly made changes to #defines and rewrote software so the compiler
would apply optimizations to create binaries as small as possible.  I guess no
one remembers that anymore :-).  The config options are exactly for things that
are fixed by board and processor design.  The bi_recs are for only those things
that aren't fixed by board or processor design, like memory size, cpu speed,
MAC address.  I almost have to give into Wolfgang's request for flash details,
but I would still rather have mtd configurations for that :-).

Just take a look at and understand how some of this software has evolved, and
the 8xx is a great example.  Lots of boards use the same processor (and built in
peripherals) and are wired slightly different, but there is still a separate
configuration for all of them and it would be overly complex to not do this.
Yes, you _could_, but I don't see any value in doing so other than proving you
can do it.  It creates code that just consumes more resources.  Once you have
a configuration for the board, the variations are the things I keep mentioning..
...memory size, cpu speed, MAC address, console port baud rate.  It's been working
nicely for years, and it is conceptually consistent with other types of Linux
configuration on other platforms.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
