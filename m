Return-Path: <eemingliu@hotmail.com>
Message-ID: <BAY138-F307C7D793CEC734113D325B2DC0@phx.gbl>
In-Reply-To: <20070813084736.GF13994@moe.telargo.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: domen.puncer@telargo.com
Subject: Re: basic and stupid question on wait_event and wake_up
Date: Mon, 13 Aug 2007 09:22:14 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Momen,
OK. I see now. So you mean condition is only to judge whether a sleeping 
process could be waken up or not when wake_up() is executed in other 
processes or interrupt handlers. What really wakes the process up is still 
the function of wake_up, right? We just execute wake_up() and then check if 
condition is true. If yes, the process will leave its sleeping and wake up; 
if not, it keep sleeping. Am I right?

BR
Ming


>From: Domen Puncer <domen.puncer@telargo.com>
>To: Ming Liu <eemingliu@hotmail.com>
>CC: Linuxppc-embedded@ozlabs.org
>Subject: Re: basic and stupid question on wait_event and wake_up
>Date: Mon, 13 Aug 2007 10:47:36 +0200
>
>On 13/08/07 08:33 +0000, Ming Liu wrote:
> > Dear Domen,
> > Thanks for your reply first.
> >
> > >I understand it this way:
> > >- condition
> > >  Just checking the condition is one way (if you don't have a wake_up
> > >  source, like an interrupt), but that's not really what wait_event 
does.
> > >  It would be something like
> > >	while (condition) {
> > >		msleep(10);
> > >	}
> > >  There was some talk on poll_wait(), but I don't know what happened 
to
> > >  it.
> >
> > So you mean in my senario (wake the process up in the interrupt 
handler), I
> > needn't to use wake_up at all? A "condition == true" in the interrupt
> > handler is enough to wake the sleeping process up? Am I right?
>
>No.
>Without the wake_up(), wait_event() would (normally) just wait
>... and wait... and wait...
>When you set your task_state to TASK_{UN,}INTERRUPTIBLE you need to have
>a way to wake it up again.
>
>That's why I used msleep(10) in my example. It would check condition every
>10 ms.
>
> >
> > I checked the source code in linux/wait.h and here is the defination of
> > wait_event:
> >
> > #define __wait_event(wq, condition)
> > do {
> > DEFINE_WAIT(__wait);
> > 	for (;;) {							\
> > 		prepare_to_wait(&wq, &__wait, TASK_UNINTERRUPTIBLE);
> >                     if (condition)
> > 			break;
> > 		schedule();
> > 	}
> > 	finish_wait(&wq, &__wait);
> > } while (0)
> >
> > #define wait_event(wq, condition)
> > do {
> > 	if (condition)
> > 		break;
> > 	__wait_event(wq, condition);
> > } while (0)
> >
> > >From the source code, it seems like that this mechanism doesn't use
> > msleep(), like what you mentioned, to release its executing. Instead, 
it
> > uses schedule() to do that.
>
>msleep() was just an example of how to do polling wait. Didn't mean to
>confuze you there, sorry.
>
> >
> >
> > >- wake_up
> > >  Just wake_up isn't enough, you get a race:
> > >  |   interrupt handler   |   process      |
> > >  ------------------------------------------
> > >  |   do_something()      |                |
> > >  |   wake_up()           |                |
> > >  |   ...                 |   wait on wq   |
> > >
> > >  And so you have a process waiting on waitqueue, that just missed the
> > >  wakeup. Obviously should not be used.
> > >
> > >- wake_up & condition
> > >  |   interrupt handler   |   process      |
> > >  ------------------------------------------
> > >  |   flag = 1            |                |
> > >  |   wake_up()           |                |
> > >  |   ...                 |   wait_event   |
> > >  |   ...                 |   flag = 0     |
> > >
> > >  This will work properly and if wait_event misses a wake_up, the
> > >  condition check (flag)  will kick in before putting it to sleep.
> > >
> >
> > Thanks for your explaining on the race problem. I can understand this 
now.
> > However I still cannot understand, is such a problem: In the above 
figures
> > for my case, if flag=1 could wake the process up, then what's the use 
of
> > wake_up()? From my understanding if the condition turns true, then the
> > process which depends on this condition will be waken up. Thus what's 
the
> > exact use of wake_up()? Also in my program, I tried to remove wake_up()
> > sentence and it seems that there is no difference on the result.
>
>As explained above, flag = 1 does not wake up the process, it just makes
>sure you don't have miss-the-wakeup race.
>
>
>	Domen
>
> >
> > Thanks for the explanation.
> >
> > BR
> > Ming

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn  
