Message-ID: <001401c2f87e$1bcf3f90$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Dan Malek" <dan@embeddededge.com>
Cc: "Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>
References: <IGEFJKJNHJDCBKALBJLLCEKEFLAA.joakim.tjernlund@lumentis.se> <3E89CA89.20808@embeddededge.com>
Subject: Re: kernel hangs after printing "Calibrating delay loop ..." on mpc860
Date: Tue, 1 Apr 2003 20:39:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > Every now and then my kernel gets stuck after printing "Calibrating delay loop ..."
> > and I have to press the reset button to recover.
>
> > Someone else has experienced this on a 8260 board. This board did not have a RTC
> > and the fix was to add a set_tb(0,0) early in arch/ppc/kernel/time.c/time_init
>
> The RTC is only used to keep track of time of day.  It plays no role in
> calibrating or timing anything.  The time_init function makes an attempt
> to synchronize the RTC second boundary with the decrementer.
>
> > Our board has a RTC but it gets initialized very late(after the Calibrating
> > delay loop stuff).
>
> Then you are likely to simply see the "Warning: real time clock seems stuck!"
> message early in setup.

Nope, I set the ppc_md.get_rtc_time to NULL.

>
> > Either one of us can't understand why this would fix the problem and since I can't
> > repeat the problem at will I can't verify if a set_tb(0,0) will fix anything.
>
> We also do this on 4xx.
>
> > Can anybody explain why(or why not) a set_tb(0,0) will make a difference?
>
> I think the problem is the function tb_delta() returns an 'int', while
> the rest of the arithmetic is unsigned.  If you happen to get the tbl to
> wrap before you get the first decrementer interrupt, I suspect the arithmetic
> in these functions goes awry.  The 'set_tb()' ensures the tbl doesn't wrap
> around.

OK, thanks for the explanation. I guess this could happen to anyone then(regardless if RTC is there or
not)? Me thinks it's a good idea to do a set_tb(0,0) for 8xx also.

>
>
> -- Dan
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
