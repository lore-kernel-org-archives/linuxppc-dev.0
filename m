Date: Wed, 29 Sep 1999 09:11:42 +0200 (MET DST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Lou Langholtz <ldl@chpc.utah.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
In-Reply-To: <37F1AD4B.585E99AB@chpc.utah.edu>
Message-ID: <Pine.GSO.4.10.9909290910240.328-100000@begonia.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 29 Sep 1999, Lou Langholtz wrote:
> What might happen if a driver does:

point A

> save_flags(old_flags);
> cli();
> restore_flags(old_flags);
> save_flags(new_flags);
> cli();
> restore_flags(new_flags);

point B

> /* can't we be interupted here? Assume yes, if so */
> restore_flags(old_flags);

point C

> seems like this might introduce a bug if we could get interrupted after the
> restore of the new_flags but before the second restore of old flags in such a
> way such that the proper state of old_flags could change. I'm not comfortable
> enough though with my understanding of interrupts and driver routines to be
> certain one way or another. To be more specific, consider the case on just a
> single processor system. If this strikes anyone else as a possible race
> condition that could introduce a bug, then this is what we need to fix in
> macserial.c's rs_write routine since this code can potentially happen.
> 
> Opinions??? Please clue me in anyway... this stuff's a kick! :-)

The interrupt mask register has the same contents at points A, B and C. Hence,
if we could be interrupt a point A, we can be interrupt at points B and C.

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248648 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
