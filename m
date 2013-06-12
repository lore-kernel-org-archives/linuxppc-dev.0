Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 253712C0085
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 13:15:42 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 11 Jun 2013 21:15:39 -0600
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 24E07C90044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 23:15:35 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5C3FZ7n246428
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 23:15:35 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5C3FXHm012956
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 23:15:35 -0400
Date: Wed, 12 Jun 2013 11:15:29 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 23/27] powernv/opal: Notifier for OPAL events
Message-ID: <20130612031529.GA9492@shangw.(null)>
References: <1370417668-16832-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1370417668-16832-24-git-send-email-shangw@linux.vnet.ibm.com>
 <1370997149.8250.158.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1370997149.8250.158.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 12, 2013 at 10:32:29AM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2013-06-05 at 15:34 +0800, Gavin Shan wrote:
>> The patch intends to implement the notifier for variable OPAL events.
>> It's notable that the notifier can be disabled dynamically. Also, the
>> notifier could be fired upon incoming OPAL interrupts, or enabling
>> the OPAL notifier.
>
>"This patch implements a notifier to receive a notification on OPAL
>event mask changes." is probably better. No need to blurb about
>enable/disable, however add something along the lines of
>
>"The notifier is only called as a result of an OPAL interrupt, which
>will happen upon reception of FSP messages or PCI errors. Any event
>mask change detected as a result of opal_poll_events() will not result
>in a notifier call.
>
>With OPALv3, opal_poll_event() will not clear interrupt conditions from
>the FSP however, even if it consumes the messages (and thus updates the
>event mask). Thus the interrupt notifier is a reliable way to get
>the completion for FSP based OPAL operations. The specific list will
>be added to the header file.
>
>

Thanks, Ben. Will update the changelog accordingly.

>> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/opal.h       |    3 +
>>  arch/powerpc/platforms/powernv/opal.c |   79 ++++++++++++++++++++++++++++++++-
>>  2 files changed, 81 insertions(+), 1 deletions(-)
>> 
>> diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
>> index 2880797..64e7c84 100644
>> --- a/arch/powerpc/include/asm/opal.h
>> +++ b/arch/powerpc/include/asm/opal.h
>> @@ -644,6 +644,9 @@ extern void hvc_opal_init_early(void);
>>  extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
>>  				   int depth, void *data);
>>  
>> +extern int opal_notifier_register(uint64_t mask, void (*cb)(uint64_t));
>> +extern void opal_notifier_enable(bool enable);
>
>Make it two functions
>
>opal_enable_notifier() vs. opal_disable_notifier()
>

Ok. Will do.

>>  extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
>>  extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
>>  
>> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
>> index 628c564..9bbbf93 100644
>> --- a/arch/powerpc/platforms/powernv/opal.c
>> +++ b/arch/powerpc/platforms/powernv/opal.c
>> @@ -26,11 +26,20 @@ struct opal {
>>  	u64 entry;
>>  } opal;
>>  
>> +struct opal_cb {
>> +	struct list_head list;
>> +	uint64_t mask;
>> +	void (*cb)(uint64_t);
>> +};
>> +
>>  static struct device_node *opal_node;
>>  static DEFINE_SPINLOCK(opal_write_lock);
>>  extern u64 opal_mc_secondary_handler[];
>>  static unsigned int *opal_irqs;
>>  static unsigned int opal_irq_count;
>> +static LIST_HEAD(opal_notifier);
>> +static DEFINE_SPINLOCK(opal_notifier_lock);
>> +static atomic_t opal_notifier_hold = ATOMIC_INIT(0);
>>  
>>  int __init early_init_dt_scan_opal(unsigned long node,
>>  				   const char *uname, int depth, void *data)
>> @@ -95,6 +104,74 @@ static int __init opal_register_exception_handlers(void)
>>  
>>  early_initcall(opal_register_exception_handlers);
>>  
>> +int opal_notifier_register(uint64_t mask, void (*cb)(uint64_t))
>> +{
>> +	unsigned long flags;
>> +	struct opal_cb *p, *tmp;
>> +
>> +	if (!mask || !cb) {
>> +		pr_warning("%s: Invalid argument (%llx, %p)!\n",
>> +			__func__, mask, cb);
>> +		return -EINVAL;
>> +	}
>> +
>> +	p = kzalloc(sizeof(*p), GFP_KERNEL);
>> +	if (!p) {
>> +		pr_warning("%s: Out of memory (%llx, %p)!\n",
>> +			__func__, mask, cb);
>> +		return -ENOMEM;
>> +	}
>> +	p->mask = mask;
>> +	p->cb   = cb;
>> +
>> +	spin_lock_irqsave(&opal_notifier_lock, flags);
>> +	list_for_each_entry(tmp, &opal_notifier, list) {
>> +		if (tmp->cb == cb || tmp->mask & mask) {
>> +			pr_warning("%s: Duplicate evnet handler (%llx, %p)\n",
>> +				__func__, tmp->mask, tmp->cb);
>> +			spin_unlock_irqrestore(&opal_notifier_lock, flags);
>> +			kfree(p);
>> +			return -EEXIST;
>> +		}
>> +	}
>
>Don't bother with checking the list already. This is not useful. Also
>it's fine for two things to listen on the same event.
>

Ok. Will update in next revision.

>> +
>> +	list_add_tail(&p->list, &opal_notifier);
>> +	spin_unlock_irqrestore(&opal_notifier_lock, flags);
>> +
>> +	return 0;
>> +}
>> +
>> +static void opal_do_notifier(uint64_t events)
>> +{
>> +	struct opal_cb *tmp;
>> +
>> +	if (atomic_read(&opal_notifier_hold))
>> +		return;
>> +	if (!events)
>> +		return;
>> +
>> +	list_for_each_entry(tmp, &opal_notifier, list) {
>> +		if (events & tmp->mask)
>> +			tmp->cb(events & tmp->mask);
>> +	}
>> +}
>
>My idea was to call this if the event bit has changed since the last
>time we called opal_do_notifier. IE. Use a static last_notified_mask
>and do something like
>
>	changed_mask = last_notified_mask ^ events;
>
>	list_for_each_entry(tmp, &opal_notifier, list) {
>		if (changed_mask & tmp->mask)
>			tmp->cb(events);
>
>Also, always pass the whole events to the callback, no point in
>filtering.
>
>BTW, "tmp" isn't a nice name here.
>

Ok. Will update in next revision:
	- Allow multiple "clients" for same event.
	- Make the variable "tmp" to have better name.

>> +void opal_notifier_enable(bool enable)
>> +{
>> +	int64_t rc;
>> +	uint64_t evt = 0;
>> +
>> +	if (enable) {
>> +		atomic_set(&opal_notifier_hold, 0);
>> +
>> +		/* Process pending events */
>> +		rc = opal_poll_events(&evt);
>> +		if (rc == OPAL_SUCCESS && evt)
>> +			opal_do_notifier(evt);
>> +	} else
>> +		atomic_set(&opal_notifier_hold, 1);
>> +}
>
>As I said, two functions.
>

Ok.

>>  int opal_get_chars(uint32_t vtermno, char *buf, int count)
>>  {
>>  	s64 len, rc;
>> @@ -297,7 +374,7 @@ static irqreturn_t opal_interrupt(int irq, void *data)
>>  
>>  	opal_handle_interrupt(virq_to_hw(irq), &events);
>>  
>> -	/* XXX TODO: Do something with the events */
>> +	opal_do_notifier(events);
>>  
>>  	return IRQ_HANDLED;
>>  }
>

Thanks,
Gavin
