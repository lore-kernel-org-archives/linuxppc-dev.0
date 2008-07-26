Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 555FFDDF68
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 12:45:55 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1192479anc.78
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 19:45:54 -0700 (PDT)
Message-ID: <fa686aa40807251945t26a1656ep7a57ca71faa096c4@mail.gmail.com>
Date: Fri, 25 Jul 2008 22:45:54 -0400
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Daniel Walker" <dwalker@mvista.com>
Subject: Re: [PATCH v3 4/4] powerpc/mpc5200: Add mpc5200-spi (non-PSC) device
	driver
In-Reply-To: <1217009954.13539.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080725072549.8485.90723.stgit@trillian.secretlab.ca>
	<20080725073326.8485.99210.stgit@trillian.secretlab.ca>
	<1217009954.13539.23.camel@localhost.localdomain>
Cc: dbrownell@users.sourceforge.net, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 25, 2008 at 2:19 PM, Daniel Walker <dwalker@mvista.com> wrote:
> On Fri, 2008-07-25 at 03:33 -0400, Grant Likely wrote:
>
>> +     if (status && (irq != NO_IRQ))
>> +             dev_err(&ms->master->dev, "spurious irq, status=0x%.2x\n",
>> +                     status);
>> +
>> +     /* Check if there is another transfer waiting */
>> +     if (list_empty(&ms->queue))
>> +             return FSM_STOP;
>
> I don't think doing list_empty outside the critical section is totally
> safe.. You might want to move it down inside the spin_lock() section.

This should be fine.  This is the only place where items are dequeued,
and it will only ever be called from the ISR or the work queue.  The
work queue and IRQ will never be active at the same time (I'll add a
comment to the fact).  It also looks like list_empty is perfectly safe
to call without the protection of a spin lock (but somebody correct me
if I'm out to lunch).  It doesn't dereference any of the pointers in
the list_head structure.

>
>> +     /* Get the next message */
>> +     spin_lock(&ms->lock);
>
> The part that's a little confusing here is that the interrupt can
> actually activate the workqueue .. So I'm wondering if maybe you could
> have this interrupt driven any workqueue driven at the same time? If you
> could then you would need the above to be
> spin_lock_irq/spin_lock_irqsave ..

Ditto here, since the irq and workqueue are not enabled at the same
time there is no worry about collision.

Cheers,
g.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
