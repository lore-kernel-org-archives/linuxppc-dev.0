From: Darin.Johnson@nokia.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-2"
Subject: RE: kernel/timer.c
Date: Fri, 11 Apr 2003 14:25:12 -0700
Message-ID: <F0B628F30F48064289D8CCC1EE21B7A80C486A@mvebe001.americas.nokia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> From: ext Joakim Tjernlund [mailto:joakim.tjernlund@lumentis.se]
> Sent: Friday, April 11, 2003 7:39 AM
>
> hmm, why not just:
>    expire = timespec_to_jiffies(&t);
> if tv_sec and tv_sec are zero, do you need to sleep at all?

Trying to sleep for 0 time periods is difficult in many timer systems,
and this is probably true for Linux also. Ie, time "t" has already
passed by the time this routine is executed, but time "t+1" has not.

The decision is whether to make the delay 1 in this case, or to just
schedule the next ready thread.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
