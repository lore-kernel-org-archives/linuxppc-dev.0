Date: Fri, 26 Nov 1999 10:42:03 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
cc: Dan Malek <dan@netx4.com>, Christian Zankel <chris@mvista.com>,
        cort@fsmlabs.com, linuxppc-dev@lists.linuxppc.org,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
In-Reply-To: <Pine.GSO.4.10.9911261005360.29385-100000@dandelion.sonytel.be>
Message-ID: <Pine.LNX.4.10.9911261032590.22448-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > >     if (has_feature_a) {
> > >         ...
> > >     }
> > > 
> > > instead of
> > > 
> > >     #if defined(CONFIG_x) || defined(CONFIG_y) || defined(CONFIG_z)
> > >     ...
> > >     #endif
> > 
> > Yes, but one of the things I am trying to do is reduce the
> > code size and instructions to execute.  On a 500 MHz G4 with
> > a Gigabyte of memory, a few extra instructions is no big deal.
> > On a 33 MHz 8xx with 8 Mbytes of memory, you watch all of this
> > pretty closely :-).
> 
> So what's wrong with the approach above? All unused code will be optimized away
> by the compiler. There's no difference between the first and the second
> version, except that the first one is more readable.

Plus it has the added benefit that you can still build kernels that
support a range of hardware (by making has_feature_a not const 0 or 1 but
something like feature_present(a) :-) If you don't need this, both are
equivalent though. 

Worried about wasting a few cycles on the branch? I've never noticed a
difference between m68k kernels supporting one, two or three machine types
(m68k uses the method proposed by Geert). That's been with 16 MHz 030. 
Even code size didn't increase that much compared to the generic Linux
kernel feature bloat between 2.0 and now :-)  

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
