Message-ID: <3B95A796.248A0E99@mvista.com>
Date: Wed, 05 Sep 2001 00:18:30 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 4xx - a question and a patch
References: <20010830175217.H858@zax> <3B95307D.1BE64A98@mvista.com> <20010905110451.A599@zax>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:

> The 405gp manual implies that an mtspr to the PIT writes both the
> decrementing value and the reload register.  Is this a hardware /
> documentation bug?

Well, the point is that it writes the reload register.  When it
gets to zero, it reloads with this register, which is wrong.

> .....  Could the PIT be used this way if auto-reload was
> disabled?

No, because the PIT doesn't count down past zero.  If they would
have allowed this, we could have disabled the auto-reload and
treated it just like the decrementer.

The best I could come up with is just allow the PIT run with a
proper and fixed reload value.  It isn't a decrementer and we
can't treat it like one.


> Sure, but it's still useful to be able to run binaries copied from
> "normal" PPC machines.

Just remember that you can't be mixing float emulation and in-line
floating point software.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
