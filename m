Message-ID: <3E89CA89.20808@embeddededge.com>
Date: Tue, 01 Apr 2003 12:21:13 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel hangs after printing "Calibrating delay loop ..." on mpc860
References: <IGEFJKJNHJDCBKALBJLLCEKEFLAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> Every now and then my kernel gets stuck after printing "Calibrating delay loop ..."
> and I have to press the reset button to recover.

> Someone else has experienced this on a 8260 board. This board did not have a RTC
> and the fix was to add a set_tb(0,0) early in arch/ppc/kernel/time.c/time_init

The RTC is only used to keep track of time of day.  It plays no role in
calibrating or timing anything.  The time_init function makes an attempt
to synchronize the RTC second boundary with the decrementer.

> Our board has a RTC but it gets initialized very late(after the Calibrating
> delay loop stuff).

Then you are likely to simply see the "Warning: real time clock seems stuck!"
message early in setup.

> Either one of us can't understand why this would fix the problem and since I can't
> repeat the problem at will I can't verify if a set_tb(0,0) will fix anything.

We also do this on 4xx.

> Can anybody explain why(or why not) a set_tb(0,0) will make a difference?

I think the problem is the function tb_delta() returns an 'int', while
the rest of the arithmetic is unsigned.  If you happen to get the tbl to
wrap before you get the first decrementer interrupt, I suspect the arithmetic
in these functions goes awry.  The 'set_tb()' ensures the tbl doesn't wrap
around.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
