Date: Wed, 5 Jun 2002 10:02:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Porter <porter@cox.net>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: More details on the telnet with CONFIG_PIN_TLB problems
Message-ID: <20020605000239.GA17752@zax>
References: <20020603075322.GI6765@zax> <15612.47259.378190.93509@argo.ozlabs.ibm.com> <20020604095720.A15252@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020604095720.A15252@home.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 04, 2002 at 09:57:20AM -0700, Matt Porter wrote:
>
> On Tue, Jun 04, 2002 at 10:54:51PM +1000, Paul Mackerras wrote:
> >
> > Looks like Ben and I have found the problem; Ben added an isync and a
> > sync to set_context() after setting the PID register and that seems to
> > have fixed it.  It makes sense, as isync invalidates the shadow DTLB
> > and ITLB.  (The sync may be unnecessary.)
>
> Makes sense, I was telling some folks at work that it had to be a
> 40x specific code problem.  The 440 has had an isync in set_context()
> and doesn't see this problem (and by default uses pinned TLBs).

Heh, well not only uses them by default, but must use them since
translation is always on.

> Changing the PID is a context changing event that requires a context
> synchronization.  The sync shouldn't be necessary per the UM and
> seems to be true in practice from my 440 testing.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
