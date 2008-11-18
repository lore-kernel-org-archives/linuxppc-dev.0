Return-Path: <CFRIESEN@nortel.com>
Received: from zrtps0kn.nortel.com (zrtps0kn.nortel.com [47.140.192.55])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8C3A1DDE19
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 03:14:51 +1100 (EST)
Message-ID: <4922E9EC.3070606@nortel.com>
Date: Tue, 18 Nov 2008 10:14:36 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: BUG? timer_create() with SIGEV_THREAD not working (at least on ppc64)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The code below sets up a simple timer with SIGEV_THREAD.  I compiled the 
code as "g++ timertest.cc -o timertest -lrt -pthread".

Running it on my G5 with 2.6.27 (but with an older glibc), it prints:

Creating timer
Setting timer 268509264 for 5-second expiration...

and then the timer never expires.  I have an old Fedora Core 4 x86 
machine and there it works as expected.

Is there some hard requirement to upgrade glibc?  If not, then this 
looks like a bug somewhere.

Thanks,

Chris



int main(void)
{
     timer_t  timer_id;
     struct itimerspec    its;
     struct sigevent      se;

     // set timer signal event
     se.sigev_notify = SIGEV_THREAD;
     se.sigev_value.sival_ptr = &timer_id;
     se.sigev_notify_function = handler;
     se.sigev_notify_attributes = NULL;

     if ( timer_create(CLOCK_REALTIME, &se, &timer_id) < 0)
     {
         printf("create timer failed\n");
         fflush(0);
         return 0;
     }

     // set timer.
     its.it_value.tv_sec     = 1;
     its.it_value.tv_nsec    = 0;
     its.it_interval.tv_sec  = 1;
     its.it_interval.tv_nsec = 0;
     if ( timer_settime(timer_id, 0, &its, NULL) < 0)
     {
         printf("set timer failed\n");
         fflush(0);
         return 0;
     }

     printf("set timer OK\n");
     fflush(0);

     while(1)
     {  pause();}
     return 0;
}
