Date: Wed, 31 Jul 2002 10:52:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: __cli on 4xx - MSR:CE?
Message-ID: <20020731005244.GA27711@zax>
References: <1028054814.13540.131.camel@granite.austin.ibm.com> <3D46E96B.1020504@dslextreme.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D46E96B.1020504@dslextreme.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 30, 2002 at 12:30:51PM -0700, akuster wrote:
>
> Hollis Blanchard wrote:
> >Shouldn't __cli on 4xx disable the MSR CE bit as well as EE?
> >
> >-Hollis
>
> It should.  Critical interrupts are currently not enabled in the kernel
>
> armin

No, that isn't clear.

As Armin says, (external) critical interrupts are not supported at the
moment in the 4xx kernel, so at the moment this is irrelevant.

However if someone ever did implement the use of critical external
interrupts on a board, this would surely be because interrupts from
the relevant hardwware are, well, critical, and require extremely low
latency processing.  It therefore seems sensible that such routines
should run even when normal interrupts are disabled.  Obvioulsy the
critical interrupt handlers would have to be written very carefully to
avoid interfering with interrupted code.

If critical interrupts are disabled everywhere that normal interrupts
are disabled, there seems little point in having them.

I believe the interrupt handling code (head_4xx.S and entry.S) in 2.5
should be able to cope with critical external interrupts.  When
transferring to a critical interrupt handler critical interrupts will
remain disabled until the handler has completed.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
