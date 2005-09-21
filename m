Return-Path: <kalle.pokki@iki.fi>
Received: from smtp1.song.fi (smtp1.song.fi [194.100.2.121])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F352668358
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 16:27:20 +1000 (EST)
Message-ID: <4330FAAF.1060704@iki.fi>
Date: Wed, 21 Sep 2005 08:16:15 +0200
From: Kalle Pokki <kalle.pokki@iki.fi>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>, linuxppc-embedded@ozlabs.org
References: <DCEAAC0833DD314AB0B58112AD99B93B859463@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859463@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: wait_event and interrupts
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:

>Hi
>I have a driver that roughly does something like:
>
>int driver_read(int cs, int addr, void *buf, int len)
>{
>    hw_done = 0;
>    /* init_hw */
>
>    if (!hw_done)
>    {
>        ret = wait_event_interruptible_timeout(inq, hw_done, TIMEOUT);
>        if (ret == 0)
>        {
>            if (hw_done)
>                goto hw_finished;
>			
>            return -EIO;
>        }
>    }
>hw_finished:
>    return len;
>}
>
>static irqreturn_t myinterrupt(int irq, void * dev_id, struct pt_regs *
>regs)
>{
>    hw_done = 1;
>    schedule_work(&tqueue);
>
>    return IRQ_HANDLED;
>}
>
>static void do_softint(void *private_)
>{
>    wake_up_interruptible(&inq);
>
>}
>
>I have a problem however with this, because in about 10% of my cases,
>the interrupt triggers very fast, and ends up being served between the
>check for hw_done and the wait_event call. This cause the wait to
>timeout instead of getting waked up.
>
>Is there a better way of doing this?
>I do not want to do a busy wait, because the hardware can take up to
>several 100's of ms to return, but most often returns within 20us.
>  
>
You seem to create an unnecessary race condition by checking the hw_done 
variable in the read function. You can avoid this by changing it to

int driver_read(int cs, int addr, void *buf, int len)
{
    hw_done = 0;
    /* init_hw */

    if (wait_event_interruptible_timeout(inq, hw_done, TIMEOUT))
	return -ERESTARTSYS;

    hw_done = 0;

    /* copy the data to user space here */

    return len;
}

The wait_event_interruptible_timeout() function checks the variable for 
you. You still must make sure the read function does the right thing if 
it is called simultaneously by more than one application.
