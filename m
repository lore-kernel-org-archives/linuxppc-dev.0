Message-ID: <39895E55.E7659D16@wanadoo.fr>
Date: Thu, 03 Aug 2000 13:58:13 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
References: <200008030957.KAA17120@hyperion.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
> and the 2.2.17pre15 dmesg contains the lines:
>
> ====
> Linux version 2.2.17pre15-ben1-snd (root@athena) (gcc version 2.95.2
> 19991024 (release/franzo)) #2 Wed Aug 2 23:16:52 BST 2000
> [...]
> pmac nvram is core99: 0
> System has 64 possible interrupts
> GMT Delta read from XPRAM: 60 minutes, DST: on
>
> ====
>
> which, as I said, works as long as RTC is -not- involved.
> are we applying a correct twice?

This is my impression, too. My clock is set to localtime (according to
MacOS, clock -r, and hwclock -r --localtime). Pre-rtc 2.2.x and
2.4.0-test5 give the same system time as MacOS, but 2.2.17pre13 with
Ben's patch is 2 hours early, that is, it sets system time to UTC. It is
not surprising that 2.2.17-pre13-bk and 2.4.0-test5 don't give the same
result, because the former contains Ben's offset patch and the latter
doesn't. The question is only which one is right.

Another observation from /var/log/messages (since Ben was talking about
the early system time before rc.sysinit does its job): In the
2.4.0-test5 boot messages, I see a few that have the wrong time
(localtime+2 hours). These are the actions done by rc.sysinit before the
clock gets set (mounting /proc and setting kernel parameters). On the
other hand, all kernel messages show the correct time. In the boot
messages from 2.2.17, with or without Ben's patch, there are no messages
with a wrong time (except when all of them have the wrong time :-)).

But then I admit don't understand what the timestamps in log/messages
mean. They certainly don't indicate the time when the actions happened.
The kernel messages have later timestamps than the rc.sysinit actions.
And in 2.4.x the order of these messages is completely different from
the one in 2.2.x.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
