To: Cort Dougan <cort@persephone.cs.nmt.edu>
Cc: Troy Benjegerdes <hozer@drgw.net>, Dan Malek <dmalek@jlc.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP RTC vs Decrementer accuracy...
References: <Pine.LNX.3.96.981209012238.14552A-100000@persephone.cs.nmt.edu> <m2btlcnaaj.fsf@wf-rch.cirr.com>
Reply-To: minyard@acm.org
From: Corey Minyard <minyard@acm.org>
Date: 09 Dec 1998 22:20:20 -0600
In-Reply-To: Corey Minyard's message of 09 Dec 1998 17:52:04 -0600
Message-ID: <m2d85sk4qj.fsf@wf-rch.cirr.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Corey Minyard <minyard@acm.org> writes:

> Cort Dougan <cort@persephone.cs.nmt.edu> writes:
> 
> > No, this would tend to make it slower if anything.
> > 
> > }Okay, would this cause the clock to be fast? (mine was about 45 minutes
> > }fast) (And, is it feasable to make it 'impossible' to miss a decr?)
> > 
> > Rebooting a lot would affect it.  Are you running the code that sync's the
> > rtc with the system clock every 11 minutes?  If so, turning it off and
> > seeing which clock was accurate after a while would be a useful
> > experiment.
> > 
> > }I have also rebooted the machine quite a bit.. This may also be the
> > }reason.
> > 
> 
> I'm having this same problem on an MVME2700 (233MHZ 750).  With the
> default configuration the clock gains about 1.5 seconds every 30
> minutes.  LinuxPPC on my PowerMac keeps great time.
> 
> I removed the hardcoding of the decrementer setting but the computed
> values stayed pretty much the same.  I have modified the hardcoded
> frequency value to be 999950000 (after some experimentation with
> xntpd) from the old value of 998700000.  This keeps time pretty well
> (<16ppm error) and the stability is very good.
> 
> Also, I'm not seeing the time being written to the RTC at all.  I just
> left my card up all day and it made no difference in the time in the
> RTC, it is about 600 seconds off (and that value is growing quite
> rapidly, probably 30 seconds a day, which might explain why the
> calculated value is so far off).  But why isn't the RTC being written?
> Maybe I'll look at this tomorrow.
> 

I done some more research.  From the looks of things, the MK48T59 is
not register-compatible (even with mapping) with the MC146818.  Most
of the control bits are not in the same place.  I'm going to try to
rewrite this, but...

I would like to make things in the arch/ppc/kernel directory more
"polymorphic", meaning I'd like to have a table of function pointers
that point to the various procedures to handle things, much like a
device driver or filesystem entry.  The detection code would fill in
all the proper functions, and there would be no more checks all over
the place for various architectures.  I think it would make the code
much cleaner and make it much easier to add new boards.

Cort, who would I contact for more info on this?

-- 
Corey Minyard               Internet:  minyard@acm.org
  Work: minyard@nortel.ca       UUCP:  minyard@wf-rch.cirr.com

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
