From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
Date: Thu, 20 Jan 2000 21:19:34 -0500
Content-Type: text/plain
Cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
References: <Pine.HPX.4.10.10001210151470.18916-100000@gra-ux1.iram.es>
In-Reply-To: <Pine.HPX.4.10.10001210151470.18916-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Message-Id: <00012021232600.07340@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> I actually doubt that the eieio are necessary but then I'm not a
> specialist on this kind of hardware. Every eieio is a bus broadcast
> operation (except on 603, on G3 it is IIRC an option controlled by a bit
> in HID0) and actually has a cost comparable to a write posted I/O access
> but the other consequences (preventing bursts on the I/O bus) may actually
> cause a significant performance hit.  So it should be used only when
> necessary...
>
> > Please let me know how to change the above so that I get it right this time.
>
> Try to determine first whether the eieio are necessary; for access to the
> frame buffer I'm almost sure that they are superfluous and potentially
> very costly in terms of performance. For the MMIO I suspect that they may
> be necessary at some places, but adding them systematically will have less
> impact.

Okay, I went and looked at the latest aty128fb.c code and it does not use eieio
anywhere.  I looked at ealier verions of this file and it at one time had eieio
but they have since been removed.

I also looked and the endian conversion routines do not use the output
contraint approach you took but do include the memory clobber on the writes.

I think I will go with the output constraint version given above without the
eieio until or unless the kernel driver begins to use them too.

Thanks for all of your help with this everyone.  I have learned alot.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
