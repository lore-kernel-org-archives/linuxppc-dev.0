From: erik.teose@exgate.tek.com
Message-ID: <BA0E4392AD99D040885C414D992C24BE059741B8@us-bv-m11.bv.tek.com>
To: jjboor@aimsys.nl, jdboyer@m5t.com
Cc: wchyang_hn@sina.com, linuxppc-embedded@lists.linuxppc.org
Subject: RE: Can't set the schedual parameter of threads in linux
Date: Thu, 11 Mar 2004 11:39:26 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>> Your program logic is absolutely correct.
>> I ran it in my embedded PPC environment (as root) and got
>the following results:
>>
>> policy: 2       priority: 20
>>
>> The problem is elsewhere...
>
>RedHat 9 uses nptl, that is a difference.

And a big difference it is. Here's some bits of an email
conversation I recently had on this issue:

  >>RH9 introduces 'nptl', (locally known as 'non-portable threads
  >>library'), which is strictly SCHED_OTHER.  Any
  >>RTOS code which relies on prioritized scheduling to work reliably
  >>(including some of the v2pthreads emulation layer) will be broken with
  >>'nptl'....
  >>
  >Isn't 'nptl' also 'standard' in the new 2.6 kernel? Is it strictly
  >SCHED_OTHER in 2.6 also? Isn't that a severe blow to 'real-time'
  >embedded Linux? I don't understand...
  >
  Both statements are regrettably true. The developer(s) of 'nptl'
  regard regard real-time scheduling as 'nonsense' (that's what Ulrich
  Drepper called it!) and have no intentions of supporting it.
  Furthermore, their development priority is on scheduling efficiency
  rather than priority, and they believe it's okay to 'water down' the
  expectations of the applications programmer in order to boost
  performance.  Consequently I intend to personally take a look at their
  code to see what can be done to make it more desirable for the real-time
  applications community.  Drepper and crew don't see the shortcomings in
  their approach, so we in the real-time community will have to make any
  corrections ourselves.

So there we have it. The new 'nptl' threading library does not support
real-time scheduling. Comments?

Erik Teose
erik.teose@tek.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
