Message-Id: <200012062348.eB6NluV01036@denx.local.net>
To: Dan Malek <dan@mvista.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.4.0-test11 - MPC860T FEC question. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 06 Dec 2000 17:11:49 EST."
             <3A2EB9A5.65311F2E@mvista.com>
Date: Thu, 07 Dec 2000 00:47:56 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan,

in message <3A2EB9A5.65311F2E@mvista.com> you wrote:
>
> I don't like the queue_task stuff (this wasn't my doing).  The MII/link
> interrupt should be handled as part of the interrupt handler like it
> used to be (until the late 2.3.99 code when this was changed).

Well, I just spent more than an hour to back-port the  FEC  stuff  to
the  2.2.14  kernel  because I needed a working FEC driver there, and
fast.

> The 8260 is very incomplete.  The problem is the MII control/status
> is disconnected from the ethernet controller.  The 860T FEC would
> generate an interrupt when the bit shifting was done, but the 8260
> requires software to do this.  The 8260 is going to get one of two
> equally ugly solutions, either a tasklet that runs for the purpose of
> managing the MII, or to simply to software shift and poll the MII in
> line with other functions.  I stared with the FEC driver on the 8260,

I don't like the idea of having completely different code in  several
places for dealing with essentially the same thing.

Now we have the FEC code for the 8xx in 2.2.14, for the 8xx in 2.4.x,
and for the 82xx in 2.4.x - and it's difficult  to  recognize  common
parts.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Wagner's music is better than it sounds."               - Mark Twain

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
