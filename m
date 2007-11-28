Return-Path: <alan@akb.net>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.234])
	by ozlabs.org (Postfix) with ESMTP id 8C9BEDDE1E
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 10:41:24 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so1248070nzh
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 15:41:23 -0800 (PST)
Message-ID: <bfa0697f0711281541l31225d59ne78c8fe40286052e@mail.gmail.com>
Date: Wed, 28 Nov 2007 16:41:22 -0700
From: "Alan Bennett" <embedded@akb.net>
Sender: alan@akb.net
To: linuxppc-dev@ozlabs.org
Subject: Timers on mpc8248 etc...
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've got a routine that needs to delay for X microseconds, this is a
must.  The command after schedule_timeout must has to wait for the HW
to complete a task that takes X microseconds.

I would think that one way to do this is with a simple
schedule_timeout.  But in the example below, the time that passes from
run1() to dontrun() is far less than 3.2 msecs.  Infact, sometimes its
~ 800 micros according the a analyzer looking at points triggered in
run1() and donrun().  Could this be a configuration problem with the
timer/interrupt that generates the jiffies?


run1();
delaytime = 3280;
set_current_state(TASK_UNINTERRUPTIBLE) ;
schedule_timeout(usecs_to_jiffies(delaytime));  //1HZ = 1 second
1/1000 second = 1 milli
dontrun();
