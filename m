Message-ID: <3D2E16E1.3080602@lvl7.com>
Date: Thu, 11 Jul 2002 19:38:09 -0400
From: Neil Horman <nhorman@lvl7.com>
MIME-Version: 1.0
To: Khai Trinh <kqtrinh@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: tasklets and waking up sleeping process question
References: <20020711224210.62434.qmail@web11505.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You _can_ do either.  Doing the later however, is more or less re-inventing the
wheel, as the tasklet mechanism is designed specifically so that you can do non
time-sensitive interrupt work (the tasklet runs in interrupt context, but with
interrupts still enabled).  So going to the trouble to create a kernel thread to
  pend on a semaphore to be unlocked by an interrupt handler top-half really
never makes sense, unless you need to be able to move your driver code between a
linux environment and a non-linux environment which doesn't have the concept of
tasklets.  Even then, I'd still suggest that you put your code together in such
a way that when building for linux you use tasklets rather than a whole new
kernel thread.
Hope that helps!
Neil

Khai Trinh wrote:

> I have new to Linux. I am reading the Linux device
> driver book second eddition and am trying to make some
> sense out of it.
>
> I am trying to implement an interrupt handler. From
> the description in the book, it seems that one can go
> about implementing the bottom half either using the
> tasklets method or by waking up a sleeping process in
> the top half interrupt handler.
>
> Is what I understood correct or I am totally of the
> topics?
>
> When do you determine which method to implement for an
> interrupt handler?
>
> Regards,
> --Khai
>
>
>


--
/******************************************************************
*Neil Horman
*Software Engineer
*LVL7 Systems
*13000 Weston Pkwy.
*Cary, NC 27513
*(919)-865-2915
*nhorman@lvl7.com
*PGP keyID 0xB5E1020A
*http://www.keyserver.net/en
*******************************************************************/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
