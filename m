Subject: Re: /dev/watchdog for onchip MPC860 watchdog?
To: tania@centurysys.co.jp (Tania Boak)
Date: Thu, 13 Jul 2000 17:47:11 +1000 (EST)
Cc: massin@col.bsf.alcatel.fr, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <396D6EC3.CAF4201B@centurysys.co.jp> from "Tania Boak" at Jul 13, 2000 04:24:51 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000713074711.9FEC8F@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tania Boak writes:
> But I don't know how to guarantee that the application will be able to
> service the watchdog in any given interval of time.  How do you
> distinguish between the case where the system has stopped working and
> the case where the system is busy but still functioning?

Your system needs to have some periodic task which you can guarantee will
run sufficiently often during normal operation, and hopefully will clag if
something catastrophic happens.  If you're doing simple regular data
aquisition, that's reasonably easy, but if it's a more complex system, there
may not be such a periodic task.  In this case you can run a real-time thread
at high priority which sleeps most of the time, just to tickle the watchdog;
but it still won't guarantee that the lower priority threads are running OK.
Still, some protection may be better than none, depending on your application.

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
