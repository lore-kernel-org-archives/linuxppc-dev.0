Date: Fri, 21 Jan 2000 08:58:56 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
cc: Gabriel Paubert <paubert@iram.es>,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
In-Reply-To: <00012021232600.07340@localhost.localdomain>
Message-ID: <Pine.LNX.4.05.10001210858020.980-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 20 Jan 2000, Kevin Hendricks wrote:
> > I actually doubt that the eieio are necessary but then I'm not a
> > specialist on this kind of hardware. Every eieio is a bus broadcast
> > operation (except on 603, on G3 it is IIRC an option controlled by a bit
> > in HID0) and actually has a cost comparable to a write posted I/O access
> > but the other consequences (preventing bursts on the I/O bus) may actually
> > cause a significant performance hit.  So it should be used only when
> > necessary...
> >
> > > Please let me know how to change the above so that I get it right this time.
> >
> > Try to determine first whether the eieio are necessary; for access to the
> > frame buffer I'm almost sure that they are superfluous and potentially
> > very costly in terms of performance. For the MMIO I suspect that they may
> > be necessary at some places, but adding them systematically will have less
> > impact.
>
> Okay, I went and looked at the latest aty128fb.c code and it does not use eieio
> anywhere.  I looked at ealier verions of this file and it at one time had eieio
> but they have since been removed.

Perhaps they were replaced by the platform independent wmb()?

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
