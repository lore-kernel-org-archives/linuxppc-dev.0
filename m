Date: Sun, 15 Feb 2004 23:20:35 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Yang <yangqs@163.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: clock() seems not work !
Message-ID: <20040216072035.GB25104@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Feb 16, 2004 at 03:13:55PM +0800, Yang wrote:
> >On Mon, Feb 16, 2004 at 11:58:07AM +0800, Yang wrote:
> >>
> >>  i am writting applications based ppc+MVL3.0, which i want to get CPU
> >> time,but clock() seems not work for me, for this i did a simple test,as
> >> follows:
> >> /*----------------*/
> >>   while(1)
> >> 	{
> >>       printf("current time is ld \n",clock());
> >> 	  sleep(1);
> >> 	}
> >> /*----------------*/
> >>      But it printed the same value all the while. How is it?
> >>
> >
> >What do you expect from this function?
> >
> >Did you read manual entry for clock()?
> >
> >On POSIX systems clock() returns (number of seconds * CLOCKS_PER_SEC)
> >spent by the process, not a system time/tick count...
> >
> >Your program is doing _nothing_, so it's normal that clock() returns
> >the same number. Change sleep(1) to some busy loop and you'll see the
> >difference.
> >
> >Eugene.
>
> In fact i want to get a "timeout" utility ,which check periodically if a program has expired.
> Based X86

What do you mean under x86?

You aren't talking about Linux x86, are you ?

I'm just curious, what OS are you porting this code from (looks like
DOS to me :) ?

>i use clock() to set a timeout and it return the tick count of CPU.
> But it's entirely different in Linux. In most my case the timeout is a couple of 10ms.
>   The following codes are some fragments in my X86 system, how can i migrate them to Linux?
> /*------------------------------------------------*/
>  long set_timeout(long timeout)
>  {
>   return(clock()+timeout/55);  /* i386 tick once per 55ms */
>  }
>
>  char chk_timeout(long settime)
>  {
>    return (clock() >= settime) ? TIMEOUT : NO_TIMEOUT;
>  }
> /*-------------------------------------------------*/
>

OK, I think you should check gettimeofday() function.

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
