Message-ID: <3EF0660F.90909@peak.uklinux.net>
Date: Wed, 18 Jun 2003 14:15:59 +0100
From: Seb James <seb@peak.uklinux.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: failing i2c driver on mpc8xx - interruptible_sleep_on()
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello all,

I'm attempting to write a driver to communicate on the i2c bus with a
single clock chip. The mpc8xx is the master device and the clock chip
is the slave. Very simple. The clock chip is a ds1307 from Dallas
Semiconductor. Linux kernel version is 2.4.4, modified by Denx Software
Engineering.

I'm using functions in i2c-core.c and i2c-algo-8xx.c. To write a message
(pointed to by msg) to the i2c bus, I call:

 i2c_transfer(ds1307_client->adapter, msg, 1);

which is to be found in i2c-core.c and does the following:

        I2C_LOCK(adap);

        ret = adap->algo->master_xfer(adap,msgs,num);

        I2C_UNLOCK(adap);

This locks the i2c adapter (which is a conceptual entity) and then calls
master_xfer(), which is a pointer to cpm_xfer(), which you can find in
i2c-algo-8xx.c. cpm_xfer() sorts some variables and such like and then calls:

cpm_iic_write(), from i2c-algo-8xx.c

This function contains a line:

        interruptible_sleep_on(&iic_wait);

Which is causing my mpc8xx to hang (no serial console response, no telnet
access).

cpm_iic_read(), also has an interruptible_sleep_on() call which hangs my
target in the same way.

Does anyone know why this might be? interruptible_sleep_on() is in sched.c
and looks like:

void interruptible_sleep_on(wait_queue_head_t *q)
{
	SLEEP_ON_VAR

        // SEB: Makes the task an interuptible task, so another task can preempt it
	current->state = TASK_INTERRUPTIBLE;

	SLEEP_ON_HEAD
	schedule();
	SLEEP_ON_TAIL
}

where
SLEEP_ON_VAR
SLEEP_ON_HEAD
SLEEP_ON_TAIL
expand to:


#define	SLEEP_ON_VAR				\
	unsigned long flags;			\
	wait_queue_t wait;			\
	init_waitqueue_entry(&wait, current);

#define	SLEEP_ON_HEAD					\
	wq_write_lock_irqsave(&q->lock,flags);		\
	__add_wait_queue(q, &wait);			\
	wq_write_unlock(&q->lock);

#define	SLEEP_ON_TAIL						\
	wq_write_lock_irq(&q->lock);				\
	__remove_wait_queue(q, &wait);				\
	wq_write_unlock_irqrestore(&q->lock,flags);



I am stepping through the code using a bdm debugger and gdb. The debugger
just waits when I try to step into interriptible_sleep_on().

Any help that anyone could offer such as suggestions on how to work out
what this problem is about will be gratefully received.


thanks,

Seb James.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
