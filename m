Message-ID: <3B9F8260.DA1C7EA@mvista.com>
Date: Wed, 12 Sep 2001 11:42:24 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Some more 4xx exception fixes
References: <20010912133344.S4823@zax>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> The problem was that the DSI handler would not call do_page_fault()
> for zone protection faults which were writes

The real problem is the zone protection isn't set up properly
on the kernel space.  The normal logic of the DSI will work
correctly without testing specifically for a zone protection error
if the zone is properly configured.  I noticed this error the other
day while fixing the other MMU problems, but it wasn't detrimental
to simply making the kernel run, so I'm fixing it today.

> The wart is that the ISI handler passed SRR1 (i.e. saved MSR) to
> do_page_fault(), whereas the comment above do_page_fault() says that
> do_page_fault() should be passed 0 for instruction faults on 4xx.

I guess....this is left over from a common exception handler I
suppose.  The only bit position tested is ESR_DST, which for the
last few years has always been reserved and zero in the MSR.  This
is a larger problem on other processors, where we overload this
code into the fault handler with bits that do mean something......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
