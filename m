Message-ID: <3B72D188.4080902@humboldt.co.uk>
Date: Thu, 09 Aug 2001 19:08:08 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: "Justin (Gus) Hurwitz" <ghurwitz@dyndns.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: I want to break softirq.c to fix broken hardware
References: <Pine.LNX.4.33.0108091722020.11077-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Justin (Gus) Hurwitz wrote:

 > #else
 >         __asm__ __volatile__("\n\
 > 1:      lwzx    %0,0,%3\n\
 >         add     %0,%2,%0\n\
 >         stwx    %0,0,%3"
 >         : "=&r" (t), "=m" (v->counter)
 >         : "r" (a), "r" (v), "m" (v->counter)
 >         : "cc");
 > #endif /* CONFIG_NO_ATOMICS */

Last time this came up I pointed out that lwarx/stwcx are for locking
against interrupts as well as against other CPUs. You don't seem to have
anything in your atomic routine to prevent interrupts occurring between
the load and the store.

--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
