Date: Wed, 5 Sep 2001 11:04:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 4xx - a question and a patch
Message-ID: <20010905110451.A599@zax>
References: <20010830175217.H858@zax> <3B95307D.1BE64A98@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B95307D.1BE64A98@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Sep 04, 2001 at 03:50:21PM -0400, Dan Malek wrote:
>
> David Gibson wrote:
> >
> > First the question: is there a good reason that set_dec() is a no-op
> > on 4xx, rather than setting the PIT?
>
> Yes.  The PIT is far from a perfect approximation of the decrementer.
> When you "set the PIT" you actually set the reload register, not the
> value that is decrementing.

The 405gp manual implies that an mtspr to the PIT writes both the
decrementing value and the reload register.  Is this a hardware /
documentation bug?  Could the PIT be used this way if auto-reload was
disabled?

> > Second a patch - the below adds floating point emulation to the 4xx.
>
> Got it.  Thanks.  Since we now have libraries built specially for
> processors without floating point, emulation isn't necessary.  Try
> them out.

Sure, but it's still useful to be able to run binaries copied from
"normal" PPC machines.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
