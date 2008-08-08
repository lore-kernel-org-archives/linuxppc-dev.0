Return-Path: <mcarlson@broadcom.com>
Received: from mms2.broadcom.com (mms2.broadcom.com [216.31.210.18])
	by ozlabs.org (Postfix) with ESMTP id 3CE23DE1E7
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Aug 2008 04:03:24 +1000 (EST)
Date: Fri, 8 Aug 2008 11:43:59 -0700
From: "Matt Carlson" <mcarlson@broadcom.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: Strange tg3 regression with UMP fw. link reporting
Message-ID: <20080808184359.GB23249@HP-xw6200.broadcom.net>
References: <1218180939.24157.332.camel@pasglop>
	<31233EB5-037E-4615-95C9-7C816E510752@kernel.crashing.org>
	<1218187111.24157.336.camel@pasglop>
MIME-Version: 1.0
In-Reply-To: <1218187111.24157.336.camel@pasglop>
Content-Type: text/plain;
 charset=us-ascii
Cc: netdev <netdev@vger.kernel.org>, mcarlson@broadcom.com,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Nathan Lynch <ntl@pobox.com>, Michael Chan <mchan@broadcom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 08, 2008 at 07:18:31PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2008-08-08 at 10:58 +0200, Segher Boessenkool wrote:
> > > I don't know yet for sure what happens, but a quick look at the commit
> > > seems to show that the driver synchronously spin-waits for up to 2.5ms
> > 
> > That's what the comment says, but the code says 2.5 _seconds_:
> > 
> > +       /* Wait for up to 2.5 milliseconds */
> > +       for (i = 0; i < 250000; i++) {
> > +               if (!(tr32(GRC_RX_CPU_EVENT) & GRC_RX_CPU_DRIVER_EVENT))
> > +                       break;
> > +               udelay(10);
> > +       }
> > 
> > (not that milliseconds wouldn't be bad already...)
> 
> Right, indeed. I think we have a good candidate for the problem :-) I'll
> verify that on monday. Now, that leads to two questions:
> 
>  - What such a synchronous and potentially horribly slow code is
> going in a locked section or a timer interrupts ? Ie, the link
> watch should probably move to a workqueue if that is to remain,
> or the code turned into a state machine that periodically check for
> events, or whatever is more sane than the above.
> 
>  - The code should at least display some error and do something sane in
> case of timeout such as disabling the new UMP feature instead of
> repeatedly looping ...
> 
>  - If this is indeed our problem (timing out in the code above), why is
> our firmware not emitting the requested event -> maybe the PowerStations
> need a tg3 firmware update.
> 
> Matt, what's your take on this ?

Segher is right.  The code should be 2.5 milliseconds but is actually
much longer.  This fix is actually already in my patch queue and needs
to be sent upstream.

We really shouldn't be displaying any error messages in the event of a
timeout though.  Earlier versions of the UMP firmware did not support
the link update interface.  The best thing the driver can do for all
cases is give the firmware a chance to service the event but continue
as if the event were serviced if it did not get an explicit ACK.
