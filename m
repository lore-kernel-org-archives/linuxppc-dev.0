Date: Wed, 5 Jun 2002 00:39:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: More details on the telnet with CONFIG_PIN_TLB problems
Message-ID: <20020604143949.GS2762@zax>
References: <20020603075322.GI6765@zax> <15612.47259.378190.93509@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15612.47259.378190.93509@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 04, 2002 at 10:54:51PM +1000, Paul Mackerras wrote:
>
> Looks like Ben and I have found the problem; Ben added an isync and a
> sync to set_context() after setting the PID register and that seems to
> have fixed it.  It makes sense, as isync invalidates the shadow DTLB
> and ITLB.  (The sync may be unnecessary.)

Aha, that makes some sense.  I hadn't thought of this, partly because
I was assuming that the Shadow [ID]TLB entries would act more-or-less
like full UTLB entries, and so obey the PID etc.

However on re-examination the manual says that an isync (or rfi)
should be performed after any change to translations - including
tlbwe, of course, but also changes to PID, ZPR and MSR.  Presumably
without large pages the context switch itself was (nearly always)
hitting enough kernel pages to flush the shadow TLBs (it would only
need 4 ITLB and 4 DTLB misses).

We never change ZPR after its initial setup, but we should check for
any problems with changing MSR.  Usualy this won't be an issue since
mostly we only change RI and DI with an rfi, which implicitly flushes
the shadow TLBs.  However there might be one or two spots (critical
exception exit in 2.5?) where we use mtmsr and may need an explicit
isync.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
