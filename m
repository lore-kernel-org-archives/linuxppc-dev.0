Date: Tue, 8 May 2001 01:28:02 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Dan Malek <dan@mvista.com>
Cc: Eli Chen <eli@routefree.com>, brian.kuschak@skystream.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: dcache BUG()
In-Reply-To: <3AF72CA8.52163E55@mvista.com>
Message-ID: <Pine.HPX.4.10.10105080120260.22253-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 7 May 2001, Dan Malek wrote:

> Gabriel Paubert wrote:
>
> > 10) swtcx. atomic_var, succeeds, but the variable has been modified in the
> >    meantime, chaos ensues
>
> How can this happen?  The reservation for the lwarx in 1) has
> long been broken, so this swtcx. will fail.....

Because the reservation has been set by the interrupt handler. Read the
scenario again, it's not the reservation from step 1), it's been cleared
twice, it's the stale reservation from an unmatched lwarx from step 6) in
a fainled down_trylock() in the interrupt handler.

Duh, I should go to bed, there is no step 7) in my mail :-)

What I claim is that the stwcx. in transfer_to_handler is useless (but
harmless) but we should always clear the reservation before an rfi in case
a dangling reservation was left by the handler and the return address of
the rfi is between a lwarx and its matching stwcx.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
