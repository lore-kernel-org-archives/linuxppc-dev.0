Message-ID: <366EDF74.6EE17E0D@jlc.net>
Date: Wed, 09 Dec 1998 15:37:08 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Cort Dougan <cort@persephone.cs.nmt.edu>
CC: Troy Benjegerdes <hozer@drgw.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP RTC vs Decrementer accuracy...
References: <Pine.LNX.3.96.981208165142.11398A-100000@persephone.cs.nmt.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Cort Dougan wrote:

> Take a look at the decrementer code - I think it's possible to miss a decr
> when resetting it.  That could explain drift.

I finally had a look (after I saw my original message _finally_
got sent to the list :-).

We are either going to get it right, or miss a bunch.  If the
instructions fit in a cache line, I think we are OK because
nothing should affect the stream between the get_dec()
and set_dec().  If we have to do a cache line fill between
these, I think we are hosed........

This is why I used the PIT in my original port of the 8xx
stuff.  Since the hardware did the reload, there was no
timer drift that could be the result of the software (unless
you missed one of the imterrupts, which better not
happen :-).  I went back to the decrementer for the 8xx
because it presented an integration hassle....I may
now reconsider.....


    -- Dan




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
