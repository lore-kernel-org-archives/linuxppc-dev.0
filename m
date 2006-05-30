Return-Path: <almoeli@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id BF65867A5F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 23:18:03 +1000 (EST)
Message-ID: <447C4604.7020109@gmx.de>
Date: Tue, 30 May 2006 15:17:56 +0200
From: almoeli@gmx.de
MIME-Version: 1.0
CC: linuxppc-embedded@ozlabs.org
Subject: Re: Linux kernel thread with Linux 2.6.x
References: <82ecf08e0605291013t7bd1627bg92d13908b3d0b7b7@mail.gmail.com>	<000a01c683cd$e3f29ca0$5201a8c0@GEG2400>
	<20060530112343.GB24129@wohnheim.fh-wedel.de>
In-Reply-To: <20060530112343.GB24129@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

do you have to use the semaphore or does a spinlock also meet your needs?
If you are in kernel 2.4 you can use one of the task_queues (e.g the
scheduler queue, timer and immediate queue also run at irq context) but
that won't have a better speed than your solution because it also gets
the processor when tasks are scheduled (all 10ms I think). In 2.6 it
would be the work_queue (schedule_work()).
So the best way is to use spinlocks and do the work in a tasklet at
interrupt context.

Oliver

Jörn Engel schrieb:
> On Tue, 30 May 2006 11:46:09 +0200, Laurent Lagrange wrote:
>> Thanks for your answer, but a tasklet runs in interrupt context
>> (in_interrupt() != 0) so it doesn't support schedule() call
>> included in "down" semaphore function.
> 
> Do you have code you can show?
> 
> Jörn
> 
