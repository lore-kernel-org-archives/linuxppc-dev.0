To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs 
In-Reply-To: Message from Dan Malek <dan@embeddededge.com>
   of "Wed, 20 Mar 2002 13:51:01 CDT." <3C98DA15.50302@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 21 Mar 2002 12:11:05 +1100
Message-ID: <22654.1016673065@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 20 Mar 2002 13:51:01 -0500, Dan Malek <dan@embeddededge.com> writes:
>If we want to be passing arbitrary information into the kernel
>for anyone to use, perhaps we should consider using the standard
>argc, argv, envp, like other architectures.  Just pass ASCII
>strings into the kernel as you would any other program, and have
>a function that can search for and parse 'param=value' strings.

I like this idea (a lot), but I'm not sure you were serious. The problem with
this method starts when you have a lot of information to pass - it gets unwieldy
and becomes almost as unreadable as a hex dump (anyone ever had to read the
output from a make of the gcc compiler to decipher what went wrong? with all
those command line options passed to each invocation of the compiler, the real
information gets lost).

I don't think the method matters a lot, as long as there is only one way to do
it (that is unlimited, flexible, extensible), not the three different methods
we have today (command line, bd_t struct and bi_recs).

Oh, and for the record - I vote for b). The stuff posted by benh is a very
good start for this - I really like the idea of bi_recs within bi_recs - this
gives you effectively unlimited flexibility, but handlers at the top level can
just skip/pass the entire record without worrying about its content. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
