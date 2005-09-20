Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id E27F3682F7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Sep 2005 03:56:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 20 Sep 2005 12:56:02 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859463@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: wait_event and interrupts
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi
I have a driver that roughly does something like:

int driver_read(int cs, int addr, void *buf, int len)
{
    hw_done =3D 0;
    /* init_hw */

    if (!hw_done)
    {
        ret =3D wait_event_interruptible_timeout(inq, hw_done, TIMEOUT);
        if (ret =3D=3D 0)
        {
            if (hw_done)
                goto hw_finished;
		=09
            return -EIO;
        }
    }
hw_finished:
    return len;
}

static irqreturn_t myinterrupt(int irq, void * dev_id, struct pt_regs *
regs)
{
    hw_done =3D 1;
    schedule_work(&tqueue);

    return IRQ_HANDLED;
}

static void do_softint(void *private_)
{
    wake_up_interruptible(&inq);

}

I have a problem however with this, because in about 10% of my cases,
the interrupt triggers very fast, and ends up being served between the
check for hw_done and the wait_event call. This cause the wait to
timeout instead of getting waked up.

Is there a better way of doing this?
I do not want to do a busy wait, because the hardware can take up to
several 100's of ms to return, but most often returns within 20us.
