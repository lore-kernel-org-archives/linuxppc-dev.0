To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Wait queue question
References: <3A8A9EB2.660A7A2D@raleigh.ibm.com>
From: Roland Dreier <roland@topspincom.com>
Date: 14 Feb 2001 09:30:18 -0800
In-Reply-To: Ralph Blach's message of "Wed, 14 Feb 2001 10:05:22 -0500"
Message-ID: <52snlh41g5.fsf@love-boat.topspincom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Ralph> If I have a wait queue thats I am using to wake up a device
    Ralph> driver read from an interrupt service routine.  If I get
    Ralph> three interrupt and three wake_up_interrables, will I need
    Ralph> to execute three sleep_ons to get the wait queue back to
    Ralph> the null state, or is it just back after the first
    Ralph> sleep_on?

You really don't want to use sleep_on() any more (Linux wants to
remove it out for 2.5).  Take a look at

<http://lwn.net/2001/0201/a/sleep-fix.php3>

for a safer way to sleep, or use the wait_event macro (in
linux/sched.h).

Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
