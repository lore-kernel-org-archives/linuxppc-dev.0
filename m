To: Eugene Surovegin <ebs@ebshome.net>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: set_rtc_time() cleanup / normalization 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 13 May 2003 16:33:50 PDT."
             <5.1.0.14.2.20030513161846.03805338@mail.ebshome.net>
Date: Wed, 14 May 2003 02:08:15 +0200
Message-Id: <20030514000820.B3397C6092@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <5.1.0.14.2.20030513161846.03805338@mail.ebshome.net>
Eugene Surovegin wrote:
>
> >The consensus so far seems to be that we shouldn't call set_rtc_time
> >in the timer interrupt handler.  Is anyone willing to speak up with a
> >reason why we should keep it?
>
> Because there are systems which rely on this behavior?
> For example, all our embedded systems use this feature.
>
> Wolfgang said that "... many embedded systems run in a configuration
> where they use a high precision RTC chip...".
>
> All embedded systems I saw used cheap RTC parts with poor accuracy.
>
> I think we mix two different issues here:
>
> 1) call set_rtc_time() from timer interrupt every 11 min if clock is
> synched (e.g. by NTP)
>     I don't see any problems with this.

There are many problems with this approch, for a summary see
http://lists.linuxppc.org/linuxppc-dev/200305/msg00034.html

The main reason to remove it is thatit's broken (i. e. causes  kernel
crashes) on many hardware configurations.

> 2) set_rtc_time() implementation for concrete RTC device *maybe* slow or
> just cannot
>     be called from the interrupt context.
>     Why just don't fix actual RTC code in each case ?
>     It may be useful to provide some *generic* facility for such cases.

Do you have any recommendation HOW to implement such a "fix"?

The argument to put the set_rtc_time() call into the timer  interrupt
was  accuracy;  if  you  have to remove it from interrupt context the
only solution I've seen so far is to pay  for  an  additional  kernel
thread - more overhead, and you just removed the only argument to put
it into the timer interrupt at all.

It just makes no sense to me.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Far back in the mists of ancient time, in the great and glorious days
of the former Galactic Empire, life was wild, rich  and  largely  tax
free.         - Douglas Adams, _The Hitchhiker's Guide to the Galaxy_

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
