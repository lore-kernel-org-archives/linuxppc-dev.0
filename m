To: Tom Rini <trini@kernel.crashing.org>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH and RFC] Remove request_8xxirq 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 20 Jun 2002 13:34:55 PDT."
             <20020620203455.GG16052@opus.bloom.county>
Date: Thu, 20 Jun 2002 23:16:50 +0200
Message-Id: <20020620211651.0A6811030B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020620203455.GG16052@opus.bloom.county> Tom Rini wrote:
>
> The following two patches remove request_8xxirq and redesign how we
> handle interrupts.  There's patches both against 2.5 (For inclusion
> first, mainly for comment tho) and for 2.4 (which has been tested but is
> intended for inclusion much later, probably 2.4.21 time-frame).
>
> The new interrupt handling scheme allows all 8xx interrupt handlers to be
> installed via the standard request_irq() function.  This required a
> "flattened" representation of the interrupt vectors from all interrupt
> controllers so that we can uniquely identify any interrupt source with a
> single integer.  The interrupt vector numbers used by request_irq() are:
>
>         request_irq vector      interrupt source
>         ------------------      ----------------
>         0 - 15                  SIU interrupt vectors 0 to 15
>         16 - 47                 CPM interrupt vectors 0 to 31
>         48 - 63                 8259 interrupt vectors 0 to 15 (MBX only)
...
> The bulk of this work was done by Andy Lowe and then moved up to current
> kernels and expanded slightly by myself.

Isn't this more or less  the  same  idea  as  presented  by  Wolfgang
Grandegger more than half a year ago? See

> Date: Sun, 28 Oct 2001 23:04:48 +0100
> From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
> To: Tom Rini <trini@kernel.crashing.org>
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Multi-level CPM Interrupts

By then there was a common agreement that it was a bad idea from  the
beginning (although we need and use it for RTAI anyway).


It's amusing to see how ideas get recycled again and again.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A conservative is a man who believes that nothing should be done for
the first time.                                   - Alfred E. Wiggam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
