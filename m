Date: Thu, 13 Sep 2001 17:51:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Some more 4xx exception fixes
Message-ID: <20010913175139.A3851@zax>
References: <20010912133344.S4823@zax> <3B9F8260.DA1C7EA@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B9F8260.DA1C7EA@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 12, 2001 at 11:42:24AM -0400, Dan Malek wrote:
>
> David Gibson wrote:
>
> > The problem was that the DSI handler would not call do_page_fault()
> > for zone protection faults which were writes
>
> The real problem is the zone protection isn't set up properly
> on the kernel space.  The normal logic of the DSI will work
> correctly without testing specifically for a zone protection error
> if the zone is properly configured.  I noticed this error the other
> day while fixing the other MMU problems, but it wasn't detrimental
> to simply making the kernel run, so I'm fixing it today.

Sorry, can you elaborate on that?  I don't see how we can detect the
case of user writes to kernel (writable) pages without checking the
ESPRN_DIZ bit.

> > The wart is that the ISI handler passed SRR1 (i.e. saved MSR) to
> > do_page_fault(), whereas the comment above do_page_fault() says that
> > do_page_fault() should be passed 0 for instruction faults on 4xx.
>
> I guess....this is left over from a common exception handler I
> suppose.  The only bit position tested is ESR_DST, which for the
> last few years has always been reserved and zero in the MSR.  This
> is a larger problem on other processors, where we overload this
> code into the fault handler with bits that do mean something......

No argument there, but it seems better to make the exception handler
match the documentation on do_page_fault(), given that I can't see any
disadvantage to the changed version.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
