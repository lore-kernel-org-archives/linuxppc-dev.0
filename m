To: "Embedded Linux list" <linuxppc-embedded@lists.linuxppc.org>
Cc: =?iso-8859-1?q?K=E1ri_Dav=ED=F0sson?= <kd@flaga.is>
Subject: Re: Going to sleep atomically
References: <EADB10BAC266A14A85ECBF8686A73E3108AFB6@kolkrabbi.flaga.is>
From: Roland Dreier <roland@topspincom.com>
Date: 08 Mar 2001 08:42:26 -0800
In-Reply-To: =?iso-8859-1?q?K=E1ri_Dav=ED=F0sson's?= message of "Thu, 8 Mar 2001 14:12:43 -0000"
Message-ID: <52ae6wnrf1.fsf@love-boat.topspincom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    KD> Like in blocking read() and poll() etc?
    KD> interruptable_sleep_on() or sleep_on()

No!!  Do _not_ use sleep_on() in new code.  It isn't atomic (there is
a race condition where you will miss the wakeup).  In an earlier post
to this mailing list
(<http://lists.linuxppc.org/listarcs/linuxppc-embedded/200102/msg00093.html>)
I gave the following good advice:

    You really don't want to use sleep_on() any more (Linus wants to
    remove it for 2.5).  Take a look at

    <http://lwn.net/2001/0201/a/sleep-fix.php3>

    for a safer way to sleep, or use the wait_event macro (in
    linux/sched.h).

Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
