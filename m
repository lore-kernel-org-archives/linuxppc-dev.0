Message-ID: <366F62CC.1C4B225E@shiresoft.com>
Date: Wed, 09 Dec 1998 21:57:32 -0800
From: "Guy G. Sotomayor, Jr." <ggs@shiresoft.com>
MIME-Version: 1.0
To: Dan Malek <dmalek@jlc.net>
CC: Cort Dougan <cort@persephone.cs.nmt.edu>,
        Troy Benjegerdes <hozer@drgw.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP RTC vs Decrementer accuracy...
References: <Pine.LNX.3.96.981208165142.11398A-100000@persephone.cs.nmt.edu> <366EDF74.6EE17E0D@jlc.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Dan Malek wrote:
> 
> Cort Dougan wrote:
> 
> > Take a look at the decrementer code - I think it's possible to miss a decr
> > when resetting it.  That could explain drift.
> 
> I finally had a look (after I saw my original message _finally_
> got sent to the list :-).
> 
> We are either going to get it right, or miss a bunch.  If the
> instructions fit in a cache line, I think we are OK because
> nothing should affect the stream between the get_dec()
> and set_dec().  If we have to do a cache line fill between
> these, I think we are hosed........
> 
> This is why I used the PIT in my original port of the 8xx
> stuff.  Since the hardware did the reload, there was no
> timer drift that could be the result of the software (unless
> you missed one of the imterrupts, which better not
> happen :-).  I went back to the decrementer for the 8xx
> because it presented an integration hassle....I may
> now reconsider.....
> 
Umm, but why are you keeping track of time with the decrementer?  Why
don't you use the timebase to keep track of time and the decrementer
to deliver periodic interrupts?  The two do not necessarily need to be
linked and solve the drift problem.

TTFN - Guy

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
