Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymPgL6dg3zDrM4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 00:30:38 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Deb McLemore <debmc@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Deb McLemore <debmc@linux.vnet.ibm.com>, jk@ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Add queue mechanism for early messages
In-Reply-To: <1511706615-7126-1-git-send-email-debmc@linux.vnet.ibm.com>
References: <1511706615-7126-1-git-send-email-debmc@linux.vnet.ibm.com>
Date: Wed, 29 Nov 2017 00:30:34 +1100
Message-ID: <878teqzg1x.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Deb,

Thanks for the patch.

Some comments below ...

Deb McLemore <debmc@linux.vnet.ibm.com> writes:
> Add a check for do_notify to confirm that a message handler
> has been registered before an attempt is made to call notifier
> call chain.
>
> If the message handler has not been registered queue up the message
> to be replayed when the proper registration is called.

Can you give me a bit more detail here on why we want to do this,
what the alternatives are (if any), and what problem it solves.

> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 65c79ec..0e3b464 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -40,6 +40,16 @@
>  
>  #include "powernv.h"
>  
> +#define OPAL_MSG_QUEUE_MAX 16

Why 16?

It seems a bit arbitrary. You're kzalloc'ing them, and they're < 100
bytes or so, so I don't see any reason to restrict it so much?

Having some sort of limit is probably good, but it could be 1024 or
something, just to catch the case where nothing ever registers for that
message type due to a bug.

> +
> +struct OpalMsgNode {

Please use snake case, rather than camel case. I know some of the
existing opal code uses camel case, but it's still wrong :)

So that'd be opal_msg_node.

> +	struct list_head	opal_queue_list_node;

It's usual practice to just use "list" as the name for these. It doesn't
need to be fully qualified like that, and "list" will look familiar to
people.

> +	struct opal_msg		msg;
> +	uint32_t		queue_msg_type;

The type is in the struct opal_msg, so I don't think we need it here do
we? You will have to endian-convert it though.

> +};
> +
> +static LIST_HEAD(opal_msg_queue_pending);

Being a list head this would usually have "list" in the name, so it
could just be "msg_list".

> @@ -55,11 +65,15 @@ struct mcheck_recoverable_range {
>  	u64 recover_addr;
>  };
>  
> +static unsigned long opal_msg_notify_reg_mask;
> +static int opal_active_queue_elements;

And then this could just be "msg_list_size" or "len".


>  static struct mcheck_recoverable_range *mc_recoverable_range;
>  static int mc_recoverable_range_len;
>  
>  struct device_node *opal_node;
>  static DEFINE_SPINLOCK(opal_write_lock);
> +static DEFINE_SPINLOCK(opal_msg_lock);

You've grouped this with the other lock, but it would actually be better
with the list head that it protects. And if you accept my suggestion of
renaming the list to "msg_list" then this would be "msg_list_lock".

> @@ -238,14 +252,47 @@ machine_early_initcall(powernv, opal_register_exception_handlers);
>  int opal_message_notifier_register(enum opal_msg_type msg_type,
>  					struct notifier_block *nb)
>  {
> +	struct OpalMsgNode *msg_node, *tmp;
> +	int ret;
> +	unsigned long flags;

I prefer this style:

> +	struct OpalMsgNode *msg_node, *tmp;
> +	unsigned long flags;
> +	int ret;

> +
> +	spin_lock_irqsave(&opal_msg_lock, flags);
> +
> +	opal_msg_notify_reg_mask |= 1 << msg_type;
> +
> +	spin_unlock_irqrestore(&opal_msg_lock, flags);

So setting the bit in the mask here, before you check the args below is
a bit fishy. It's also a bit fishy to take the lock, then drop it, then
take it again below, though I don't think there's actually a bug.

But, do we even need the mask? The only place it's used is in
opal_message_do_notify(), and I think that could just be replaced with a
list_empty() check of the notifier chain?


>  	if (!nb || msg_type >= OPAL_MSG_TYPE_MAX) {
>  		pr_warning("%s: Invalid arguments, msg_type:%d\n",
>  			   __func__, msg_type);
>  		return -EINVAL;
>  	}
>  
> -	return atomic_notifier_chain_register(
> -				&opal_msg_notifier_head[msg_type], nb);
> +	ret = atomic_notifier_chain_register(
> +		&opal_msg_notifier_head[msg_type], nb);
> +
> +	if (ret)
> +		return ret;
 
The logic below should probably be in a helper function.

> +	spin_lock_irqsave(&opal_msg_lock, flags);
> +	list_for_each_entry_safe(msg_node,
> +				tmp,
> +				&opal_msg_queue_pending,
> +				opal_queue_list_node) {
> +		if (msg_node->queue_msg_type == msg_type) {

You can reduce the indentation by doing:

		if (msg_node->queue_msg_type != msg_type)
			continue;

		atomic_notifier_call_chain(
				&opal_msg_notifier_head[msg_type],
				msg_type,
				&msg_node->msg);
		list_del(&msg_node->opal_queue_list_node);
		kfree(msg_node);
		opal_active_queue_elements--;
	}

> +	spin_unlock_irqrestore(&opal_msg_lock, flags);
> +
> +	return ret;

ret can only be 0 here, so it's clearer to just return 0.

> +
>  }
>  EXPORT_SYMBOL_GPL(opal_message_notifier_register);
>  
> @@ -259,9 +306,40 @@ EXPORT_SYMBOL_GPL(opal_message_notifier_unregister);
>  
>  static void opal_message_do_notify(uint32_t msg_type, void *msg)
>  {
> -	/* notify subscribers */
> -	atomic_notifier_call_chain(&opal_msg_notifier_head[msg_type],
> -					msg_type, msg);
> +	struct OpalMsgNode *msg_node;
> +

Extraneous blank line here.

> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&opal_msg_lock, flags);
> +
> +	if (opal_msg_notify_reg_mask & (1 << msg_type)) {

So like I was saying above, this could become:

	if (!list_empty(&opal_msg_notifier_head[msg_type])) {

> +		/* notify subscribers */
> +		atomic_notifier_call_chain(&opal_msg_notifier_head[msg_type],
> +						msg_type, msg);
> +	} else {

That should all be in a helper:

> +		if (opal_active_queue_elements < OPAL_MSG_QUEUE_MAX) {
> +			msg_node = kzalloc(sizeof(*msg_node), GFP_ATOMIC);
> +			if (msg_node) {
> +				INIT_LIST_HEAD(&msg_node->opal_queue_list_node);
> +				memcpy(&msg_node->msg,
> +					msg,
> +					sizeof(struct opal_msg));
> +				msg_node->queue_msg_type = msg_type;
> +				list_add_tail(&msg_node->opal_queue_list_node,
> +						&opal_msg_queue_pending);
> +				opal_active_queue_elements++;
> +			}

Should you pr_warn_once() if we ran out of memory?

> +		}
> +
> +		if (opal_active_queue_elements >= OPAL_MSG_QUEUE_MAX) {
> +			pr_warn_once("%s: Notifier Register Queue full at %i\n",
> +					__func__,

Using __func__ is overkill. You get an "opal:" prefix automatically in
this file, so you just need to say "message queue full". The size isn't
that helpful, because it's a constant, we know what it is.

> +					opal_active_queue_elements);
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&opal_msg_lock, flags);
> +
>  }
>  
>  static void opal_handle_message(void)

cheers
