Message-ID: <3A82C466.5DB031B6@tei.ericsson.se>
Date: Thu, 08 Feb 2001 17:08:07 +0100
From: Borlizzi Giacomo <giacomo.borlizzi@tei.ericsson.se>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: get_pgd_slow() function
References: <3A811BA3.C2793FA3@tei.ericsson.se> <3A81B333.D638A423@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using an 860 processor running at 80MHz.
The problem that I have is that the shell don't start.

During the debugging phase made on the 2.2.13
the code executed the function exec_mmap(). Inside on it was
executed the macro SET_PAGE_DIR and after this execution the code
was crashed.
Investigating on that I discovered that code was crash immediately when
the
MTWB register was changed.
.....
That because MMU interrupt routine was accessing to some bad memory area.

Investigating on reasons for that I have made the Hypothesis that MMU
table was not well initialized, from this I made some changes on the
get_pgd_slow function.

Some day ago during the porting on linux-2.4.1 the same problem happens
so now it is time to resolve and understand why it happen

I like your hypothesis on cache, I have the cache configured with
COPYBACK
disabled so:

# CONFIG_8xx_COPYBACK is not set

and I'll try to change it....

But many doubt remaining....

Ciao,
/Giacomo

Dan Malek wrote:

> Borlizzi Giacomo wrote:
>
> > but I've modified with:
>
> What made you think you need to do this?
> Something isn't right.  The 'memcpy' you added just copies zero values
> from the init pgd into the new pgd, which the 'memset' already did
> for you.  Either the 'memset' you are using isn't correct, or the
> act of copying that much data flushed cache lines.  What kind of
> processor do you have?
>
>         -- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
