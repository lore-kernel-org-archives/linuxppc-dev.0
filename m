Mime-Version: 1.0
Message-Id: <p04330105b7ace1e4c4c7@[66.57.12.104]>
In-Reply-To: <20010821081547.5029@smtp.wanadoo.fr>
References: <p04330104b7a79e11b8be@[24.25.18.209]>
 <20010821081547.5029@smtp.wanadoo.fr>
Date: Sat, 25 Aug 2001 01:12:34 -0400
To: <linuxppc-dev@lists.linuxppc.org>
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: 2.4.9-bk and X on 6500, not so good
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:15 AM +0200 8/21/01, Benjamin Herrenschmidt wrote:

>  >I have a stock 6500/300, on which I just compiled and installed the
>>ppc.bitkeeper linuxppc_2_4 (2.4.9) kernel. In console mode (RL3) it
>>works just fine.
>>
>>But whenever I launch X (Gnome for example, or a plain window
>>manager), about 70% of the time it breaks into the mon debugger
>>before X has fully launched.
>>
>>Problem is, there is no keyboard response at this point, and I can't
>>even restart with the 3-fingered approach (no response). Only thing
>>that works is power down, and restart.
>>
>>Any suggestions? To create a backtrace appears impossible...
>
>You can at least get the PC and LR values displayed by xmon and
>lookup them in your System.map.

pc = C0182544
lr = C0182444

from System.map:

c01821ec t unix_stream_data_wait
c01822dc t unix_stream_recvmsg
c018279c t unix_shutdown

>  Eventually, you can hack xmon
>entry point to do a backtrace automatically.

I was looking at xmon.c to do this, but I'm afraid I'm unclear on
where to try to make this happen at the break. I tried naively to
place the backtrace(excp) command right after the mon> printf
statement, but this didn't work when the crash happened.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
