To: David Jander <david.jander@protonic.nl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RTC for MPC8xx with Linux ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 19 Jun 2003 15:37:28 +0200."
             <200306191537.28949.david.jander@protonic.nl>
Date: Thu, 19 Jun 2003 18:29:15 +0200
Message-Id: <20030619162920.A9495C5FD7@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear David,

in message <200306191537.28949.david.jander@protonic.nl> you wrote:
>
> Thanks for all the answers I got over experience with the MPC852T.
> One other thing I was investigating is the RTC.
> What RTC solutionts are known for easy interfacing with MPC8xx processors,
> that work under linux ? What's the standard ?

There is no standard. The choice  is  made  by  product  requirements
(price, accuracy, battery lifetime, etc). Then the driver is dapted -
which usually is pretty trivial.

> There are a number of PC-compatible RTC chips out there, but I don't seem to
> like them much, because they're generally quite expensive, have a lot of
> functionality which might be nice, but is not really needed in my case.
> Any experience with smaller 1-bit (or SPI) RTC's under linux ? I'm looking
> basically for a Battery-backuped time-keeping counter.

See the existing driver; for example, in our kernel  trees  you  will
find support for the PCF8563, M41T11, DS12887 and similar RTCs.o

This is not a big deal. Be careful though when running  NTP  on  your
system,  especially  when  using a RTC with I2C or SPI interface. You
will have to disable the  11  minute  mode  (see  "man  hwclock"  for
details).


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"It is better to have tried and failed than to have  failed  to  try,
but the result's the same."                           - Mike Dennison

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
