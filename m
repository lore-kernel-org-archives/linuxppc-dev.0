Message-ID: <3DAB41DA.96EB815C@opensource.se>
Date: Tue, 15 Oct 2002 00:14:50 +0200
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: Mark Hatle <fray@mvista.com>
Cc: Kumar Gala <kumar.gala@motorola.com>,
	Matt Porter <porter@cox.net>,
	Bret Indrelee <Bret.Indrelee@qlogic.com>,
	Linux PPC Embedded mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Binary Compatibility of various flavors of PPC
References: <816F7B3D-DFAF-11D6-A599-003065BFB10E@motorola.com> <3DAB2923.3060607@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> But as Matt said (and later reminded me) the 405 has errata that is 405
> specific, and the 8xx and 403 half smaller cacheline size.  So anything
> statically linked may not operator correctly....  but yes, if you switch the
> whole of userspace to soft-floating point then "in general" they should all be
> compatable.

I don't know if gcc generates any code that tweaks with the cache, but
if you
only consider applications/libraries that use assembly routines to
control the
cache then it should be possible to convert the assembly code to assume
16-byte
cachelines for all processors. That should work for processors with
larger
cachelines, with a performance penalty. I use a patch for glibc-2.1.3
that does
exactly that. But I've only used it on 8xx-series, so correct me if I'm
wrong.

Btw - does someone know what the status is for recent glibc versions -
do they work for 8xx out of the box?

Thanks /

magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
