Date: Wed, 13 Oct 1999 09:59:30 -0500
From: Grant Erickson <grant@lcse.umn.edu>
To: daniel.n.nilsson@home.se
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Support for IBM CPU's ?
In-Reply-To: <199910131144.NAA12845@smtp2.home.se>
Message-ID: <Pine.SGI.4.10.9910130949280.12784-100000@brule.lcse.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 13 Oct 1999 daniel.n.nilsson@home.se wrote:
> I have a question regarding the IBM 403GCX, is this CPU supported by
> linuxppc?

At present, no. However, with ever so halting and slow progress (not due
to difficulty, just general lack of time and resources), I'm trying to add
in support for the 403GCX.

> If not, what is an estimate for the porting effort? Any suggestions
> on other operting systems for this CPU?

The major issues with the port are:

1) There's no FPU on the 403GCX; however, this should prove no more
   troublesome than the MPC8XXs and, in fact, this port should be able
   to leverage the FPU work from that port.

2) The interrupt / exception structure is slightly* different in that
   they are further subdivided into critical and non-critical interrupts \
   exceptions with a different register set and return mechanism from each
   (fairly trivial stuff).

3) The virtual memory and cache interface is entirely different, meaning
   that NONE of the 6xx, 7xx, or 8xx work can be leveraged here.

4) On-processor serial-port driver. The interface for this is really
   simple, so this should* be a non-issue.

I've submitted some VERY seminal patches to Cort; hopefully, these will be
showing up in the vger tree sometime in the near future (?). In a week or
two, hopefully, I'll have some more substantial patches to submit to Cort.

Regards,

Grant Erickson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
