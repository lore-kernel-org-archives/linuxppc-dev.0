Date: Wed, 29 Sep 1999 09:40:33 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: Lou Langholtz <ldl@chpc.utah.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.990929021435.16135B-100000@ofey.inetnebr.com>
Message-ID: <Pine.GSO.4.10.9909290939220.328-100000@begonia.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 29 Sep 1999, Takashi Oe wrote:
> On Wed, 29 Sep 1999, Lou Langholtz wrote:
> > What might happen if a driver does:
> > 
> > save_flags(old_flags);
> > cli();
> > restore_flags(old_flags);
> > save_flags(new_flags);
> > cli();
> > restore_flags(new_flags);
> > /* can't we be interupted here? Assume yes, if so */
> > restore_flags(old_flags);
> > 
> > seems like this might introduce a bug if we could get interrupted after the
> > restore of the new_flags but before the second restore of old flags in such a
> > way such that the proper state of old_flags could change. I'm not comfortable
> > enough though with my understanding of interrupts and driver routines to be
> > certain one way or another. To be more specific, consider the case on just a
> > single processor system. If this strikes anyone else as a possible race
> > condition that could introduce a bug, then this is what we need to fix in
> > macserial.c's rs_write routine since this code can potentially happen.
> 
> I'm fairly certain it's a bug.  Good spotting.  The last restore_flags()
> shouldn't be there.

Or one of the others. The last restore_flags() may make me think there's
something wrong, but it cannot cause harm. If there's a real bug, it should be
related to the other flag manipulation calls.

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248648 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
