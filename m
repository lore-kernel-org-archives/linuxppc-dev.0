To: "Stephan Linke" <Stephan.Linke@epygi.de>
Cc: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Why isn't there an validate_dcache_range() function?
References: <FCEAKDJJAPHPLJFINDAJOEHFCKAA.Stephan.Linke@epygi.de>
From: Roland Dreier <roland@topspin.com>
Date: 28 Oct 2002 08:25:09 -0800
In-Reply-To: <FCEAKDJJAPHPLJFINDAJOEHFCKAA.Stephan.Linke@epygi.de>
Message-ID: <52pttuh6oq.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "Stephan" == Stephan Linke <Stephan.Linke@epygi.de> writes:

    Stephan> I just got stuck with that question and shurely whoun't
    Stephan> find the answer: If I am using invalidate_dcache_range()
    Stephan> for the data area of an skb shouldn't I enable caching
    Stephan> for that area after the the skb is no longer assigned to
    Stephan> the CPM module? There's no validate_dchace_range() so I
    Stephan> can't.  Why?  There's shurely a reason for that. But I
    Stephan> think using an skb like this will disable caching for
    Stephan> most of the memory areas in a long term view...  Is there
    Stephan> any solution?

invalidate_dcache_range() does not turn off caching for a memory
range.  It just tells the CPU to discard any data for that range that
is currently in the cache.  Future accesses to the range will again
pull data into the CPU cache.  This means that simply using the memory
range again serves the purpose of "validate_dcache_range()" (which as
you note does not actually exist).  However it also means you have to
be careful not to touch the memory range before your external bus
master has finished writing to it (otherwise you could bring invalid
data back into the cache).

Best,
  Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
