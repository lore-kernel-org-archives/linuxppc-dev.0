Return-Path: <debmc@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymSJz5l20zDrM5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 02:29:54 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vASFTZQ9109977
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 10:29:52 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ehag0g0u2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 10:29:52 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <debmc@linux.vnet.ibm.com>;
 Tue, 28 Nov 2017 08:29:50 -0700
Subject: Re: [PATCH] powerpc/powernv: Add queue mechanism for early messages
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: jk@ozlabs.org
References: <1511706615-7126-1-git-send-email-debmc@linux.vnet.ibm.com>
 <878teqzg1x.fsf@concordia.ellerman.id.au>
From: Deb McLemore <debmc@linux.vnet.ibm.com>
Date: Tue, 28 Nov 2017 09:29:45 -0600
MIME-Version: 1.0
In-Reply-To: <878teqzg1x.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <cc9d63a2-c548-0669-4abc-f816dc99b8cc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Thanks for the comments, I'll respin the patch and send another version.

Summary on the problem being solved:

When issuing a BMC soft poweroff during IPL the poweroff was being lost,

so the machine would not poweroff.

Opal messages were being received before the opal-power code registered its notifiers.

A few alternatives were discussed (option #3 was chosen):

1 - Have opal_message_init() explicitly call opal_power_control_init() before it

dequeues any OPAL messages (i.e. before we register the opal-msg IRQ handler).

2 - Introduce concept of "critical" message types and when we register handlers

we track which message types have a registered handler, then defer the opal-msg

IRQ registration until we have a handler registered for all the critical types.

3 - Buffering messages, if we receive a message and do not yet have a handler

for that type, store the message and replay when a handler for that type is registered.


There was also a patch submitted for Busybox to close an exposed path there.

http://lists.busybox.net/pipermail/busybox/2017-November/085980.html


On 11/28/2017 07:30 AM, Michael Ellerman wrote:
> Hi Deb,
>
> Thanks for the patch.
>
> Some comments below ...
>
> Deb McLemore <debmc@linux.vnet.ibm.com> writes:
>> Add a check for do_notify to confirm that a message handler
>> has been registered before an attempt is made to call notifier
>> call chain.
>>
>> If the message handler has not been registered queue up the message
>> to be replayed when the proper registration is called.
> Can you give me a bit more detail here on why we want to do this,
> what the alternatives are (if any), and what problem it solves.
>
>> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
>> index 65c79ec..0e3b464 100644
>> --- a/arch/powerpc/platforms/powernv/opal.c
>> +++ b/arch/powerpc/platforms/powernv/opal.c
>> @@ -40,6 +40,16 @@
>>  
>>  #include "powernv.h"
>>  
>> +#define OPAL_MSG_QUEUE_MAX 16
> Why 16?
Arbitrary limit, the case of not having a handler registered is a short-lived
window and the replay queue is not meant to hide bugs, if messages are
being sent and no one has registered there is a problem and having things
be surfaced earlier rather than later seems more helpful in identifying exposures.
If future use cases need larger replay queue limits that can be re-visited.
>
> It seems a bit arbitrary. You're kzalloc'ing them, and they're < 100
> bytes or so, so I don't see any reason to restrict it so much?
>
> Having some sort of limit is probably good, but it could be 1024 or
> something, just to catch the case where nothing ever registers for that
> message type due to a bug.
>
>> +
>> +struct OpalMsgNode {
> Please use snake case, rather than camel case. I know some of the
> existing opal code uses camel case, but it's still wrong :)
>
> So that'd be opal_msg_node.
>
>> +	struct list_head	opal_queue_list_node;
> It's usual practice to just use "list" as the name for these. It doesn't
> need to be fully qualified like that, and "list" will look familiar to
> people.
>
>> +	struct opal_msg		msg;
>> +	uint32_t		queue_msg_type;
> The type is in the struct opal_msg, so I don't think we need it here do
> we? You will have to endian-convert it though.
>
>> +};
>> +
>> +static LIST_HEAD(opal_msg_queue_pending);
> Being a list head this would usually have "list" in the name, so it
> could just be "msg_list".
>
>> @@ -55,11 +65,15 @@ struct mcheck_recoverable_range {
>>  	u64 recover_addr;
>>  };
>>  
>> +static unsigned long opal_msg_notify_reg_mask;
>> +static int opal_active_queue_elements;
> And then this could just be "msg_list_size" or "len".
>
>
>>  static struct mcheck_recoverable_range *mc_recoverable_range;
>>  static int mc_recoverable_range_len;
>>  
>>  struct device_node *opal_node;
>>  static DEFINE_SPINLOCK(opal_write_lock);
>> +static DEFINE_SPINLOCK(opal_msg_lock);
> You've grouped this with the other lock, but it would actually be better
> with the list head that it protects. And if you accept my suggestion of
> renaming the list to "msg_list" then this would be "msg_list_lock".
>
>> @@ -238,14 +252,47 @@ machine_early_initcall(powernv, opal_register_exception_handlers);
>>  int opal_message_notifier_register(enum opal_msg_type msg_type,
>>  					struct notifier_block *nb)
>>  {
>> +	struct OpalMsgNode *msg_node, *tmp;
>> +	int ret;
>> +	unsigned long flags;
> I prefer this style:
>
>> +	struct OpalMsgNode *msg_node, *tmp;
>> +	unsigned long flags;
>> +	int ret;
>> +
>> +	spin_lock_irqsave(&opal_msg_lock, flags);
>> +
>> +	opal_msg_notify_reg_mask |= 1 << msg_type;
>> +
>> +	spin_unlock_irqrestore(&opal_msg_lock, flags);
> So setting the bit in the mask here, before you check the args below is
> a bit fishy. It's also a bit fishy to take the lock, then drop it, then
> take it again below, though I don't think there's actually a bug.
>
> But, do we even need the mask? The only place it's used is in
> opal_message_do_notify(), and I think that could just be replaced with a
> list_empty() check of the notifier chain?
>
>
>>  	if (!nb || msg_type >= OPAL_MSG_TYPE_MAX) {
>>  		pr_warning("%s: Invalid arguments, msg_type:%d\n",
>>  			   __func__, msg_type);
>>  		return -EINVAL;
>>  	}
>>  
>> -	return atomic_notifier_chain_register(
>> -				&opal_msg_notifier_head[msg_type], nb);
>> +	ret = atomic_notifier_chain_register(
>> +		&opal_msg_notifier_head[msg_type], nb);
>> +
>> +	if (ret)
>> +		return ret;
> The logic below should probably be in a helper function.
>
>> +	spin_lock_irqsave(&opal_msg_lock, flags);
>> +	list_for_each_entry_safe(msg_node,
>> +				tmp,
>> +				&opal_msg_queue_pending,
>> +				opal_queue_list_node) {
>> +		if (msg_node->queue_msg_type == msg_type) {
> You can reduce the indentation by doing:
>
> 		if (msg_node->queue_msg_type != msg_type)
> 			continue;
>
> 		atomic_notifier_call_chain(
> 				&opal_msg_notifier_head[msg_type],
> 				msg_type,
> 				&msg_node->msg);
> 		list_del(&msg_node->opal_queue_list_node);
> 		kfree(msg_node);
> 		opal_active_queue_elements--;
> 	}
>
>> +	spin_unlock_irqrestore(&opal_msg_lock, flags);
>> +
>> +	return ret;
> ret can only be 0 here, so it's clearer to just return 0.
>
>> +
>>  }
>>  EXPORT_SYMBOL_GPL(opal_message_notifier_register);
>>  
>> @@ -259,9 +306,40 @@ EXPORT_SYMBOL_GPL(opal_message_notifier_unregister);
>>  
>>  static void opal_message_do_notify(uint32_t msg_type, void *msg)
>>  {
>> -	/* notify subscribers */
>> -	atomic_notifier_call_chain(&opal_msg_notifier_head[msg_type],
>> -					msg_type, msg);
>> +	struct OpalMsgNode *msg_node;
>> +
> Extraneous blank line here.
>
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&opal_msg_lock, flags);
>> +
>> +	if (opal_msg_notify_reg_mask & (1 << msg_type)) {
> So like I was saying above, this could become:
>
> 	if (!list_empty(&opal_msg_notifier_head[msg_type])) {
>
>> +		/* notify subscribers */
>> +		atomic_notifier_call_chain(&opal_msg_notifier_head[msg_type],
>> +						msg_type, msg);
>> +	} else {
> That should all be in a helper:
>
>> +		if (opal_active_queue_elements < OPAL_MSG_QUEUE_MAX) {
>> +			msg_node = kzalloc(sizeof(*msg_node), GFP_ATOMIC);
>> +			if (msg_node) {
>> +				INIT_LIST_HEAD(&msg_node->opal_queue_list_node);
>> +				memcpy(&msg_node->msg,
>> +					msg,
>> +					sizeof(struct opal_msg));
>> +				msg_node->queue_msg_type = msg_type;
>> +				list_add_tail(&msg_node->opal_queue_list_node,
>> +						&opal_msg_queue_pending);
>> +				opal_active_queue_elements++;
>> +			}
> Should you pr_warn_once() if we ran out of memory?
>
>> +		}
>> +
>> +		if (opal_active_queue_elements >= OPAL_MSG_QUEUE_MAX) {
>> +			pr_warn_once("%s: Notifier Register Queue full at %i\n",
>> +					__func__,
> Using __func__ is overkill. You get an "opal:" prefix automatically in
> this file, so you just need to say "message queue full". The size isn't
> that helpful, because it's a constant, we know what it is.
>
>> +					opal_active_queue_elements);
>> +		}
>> +	}
>> +
>> +	spin_unlock_irqrestore(&opal_msg_lock, flags);
>> +
>>  }
>>  
>>  static void opal_handle_message(void)
> cheers
>
