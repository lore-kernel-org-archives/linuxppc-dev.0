To: Ralph Blach <rcblach@raleigh.ibm.com>
Cc: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: WaitQueues.
References: <3A894F05.AAFB7427@raleigh.ibm.com>
From: Roland Dreier <roland@topspincom.com>
Date: 13 Feb 2001 08:22:11 -0800
In-Reply-To: Ralph Blach's message of "Tue, 13 Feb 2001 10:13:09 -0500"
Message-ID: <521yt25z9o.fsf@love-boat.topspincom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Ralph> Is there anyway to contionally initialize a wait queue. I
    Ralph> want to test a wait queue to see if has been initialized
    Ralph> not initialize it.  If not, how do I serialize an access to
    Ralph> a set location so that I can atomically test and increment
    Ralph> that location?

I'm not sure about doing init_waitqueue_head() conditionally, but as
for atomic test and increment, you could use atomic_t (look at
asm/atomic.h).  That gives you atomic_inc_and_test_greater_zero()
among other things.  If you just want to set a flag,
test_and_set_bit() may be simpler.

Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
