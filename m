Date: Wed, 18 Jun 2003 09:23:57 -0500
From: Chris Zimman <chris@cryptoapps.com>
To: Seb James <seb@peak.uklinux.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: failing i2c driver on mpc8xx - interruptible_sleep_on()
Message-ID: <20030618142357.GA9894@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <3EF0660F.90909@peak.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3EF0660F.90909@peak.uklinux.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jun 18, 2003 at 02:15:59PM +0100, Seb James wrote:

> This function contains a line:
>
>        interruptible_sleep_on(&iic_wait);
>
> Which is causing my mpc8xx to hang (no serial console response, no telnet
> access).
>
> cpm_iic_read(), also has an interruptible_sleep_on() call which hangs my
> target in the same way.
>
> Does anyone know why this might be? interruptible_sleep_on() is in sched.c
> and looks like:

Seb,

What's going on is that when you call interruptible_sleep_on(), you're
putting the process to sleep until an interrupt comes in and wakes it
up.  iic_wait is the wait queue that you're using.  So in order for the
process to continue, and interrupt has to occur and wake this process
up.

The most likely reason that you're hanging is because the interrupt is
never coming in.

--Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
