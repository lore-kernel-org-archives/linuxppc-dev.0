Date: Fri, 2 Aug 2002 16:23:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: symbol card with orinoco_cs on mpc823
Message-ID: <20020802062324.GD5012@zax>
References: <20020729040824.GA2351@zax> <20020729100009.A23843@flint.arm.linux.org.uk> <20020729144408.GA11206@opus.bloom.county> <00a801c239ea$191a9c20$43ba459b@ntu.edu.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <00a801c239ea$191a9c20$43ba459b@ntu.edu.sg>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Aug 02, 2002 at 02:01:52PM +0800, shaowei dai wrote:
>
> Hello,
>
> Has anybody tried orinodo_cs 0.11b or 0.12b with success on symbol
> Spectrum24 High rate11M card on mpc platform?
> I've tried 2.4.18-pre3 and 2.4.19-rc3 kernel with orinoco driver. It works
> fine with intersil card. But
> when i try it on symbol card, it always crashes. After tracing down i find
> it is caused by hermes_init(). It seems the
> call to hermes_write_regn(hw,INTEN,0)  cause the crash. The ksymoops also
> suggest this function. It is just an io write. What can be wrong? And most
> strange thing is why it doesn't cause any trouble in normal intersil  card.

That's wierd - it is just a register write, so this sounds like a
low-level problem.  Is something about the card confusing the PCMCIA
system so it's reporting the wrong IO addresses?  Or maybe the timing
is a little bit different and something in the slot driver can't cope.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
