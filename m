Message-ID: <38F287EB.BE201D4@embeddededge.com>
Date: Mon, 10 Apr 2000 22:03:23 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Jeff Millar <jeff@wa1hco.mv.com>
CC: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>,
        Pavel Roskin <pavel_roskin@geocities.com>,
        "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Software Emulation Exception...
References: <Pine.LNX.4.21.0004071011570.19406-100000@sunapee.transcept.com> <38EE0267.FB881499@embeddededge.com> <kfywvm6s3dz.fsf@kieraypc01.p.y.ki.era.ericsson.se> <38F200CF.B4A07187@embeddededge.com> <001001bfa35e$cb0021a0$0201a8c0@home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jeff Millar wrote:

> ....  So, is it a
> problem with the RPX board or the Sandisk?

Like I said before.  I can't guess, and neither should you.  The fact
is the software emulation trap is caused by fetching an instruction
that can't be properly decoded.  We need to determine what it fetched
and where that came from.  These are some fundamental engineering
skills we are trying to use here.  Why aren't we using them?

The PCMCIA interfaces have their timing requirements.  On the 8xx,
these are all very programmable.  Look at the card specifications and
the values programmed.  Do they seem reasonable?  Don't simply run
maximum, excessively long timing on the PCMCIA.  This can be just as
bad on some cards or other external devices as running too fast.
Attach a logic analyzer.  Does the timing on the 8xx bus look reasonable?
Use one of the GPIO pins to trigger the analyzer when you trap the fault
(as early as possible).  Look at the bus signals.  What really happened?


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
