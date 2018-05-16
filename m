Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mFnH3QG1zF157
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 23:35:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Deb McLemore <debmc@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Deb McLemore <debmc@linux.vnet.ibm.com>, jk@ozlabs.org
Subject: Re: [PATCH v2] powerpc/powernv: Add queue mechanism for early messages
In-Reply-To: <1511989553-16198-1-git-send-email-debmc@linux.vnet.ibm.com>
References: <cc9d63a2-c548-0669-4abc-f816dc99b8cc@linux.vnet.ibm.com>
 <1511989553-16198-1-git-send-email-debmc@linux.vnet.ibm.com>
Date: Wed, 16 May 2018 23:35:42 +1000
Message-ID: <87bmdfoh8x.fsf@concordia.ellerman.id.au>
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

Deb McLemore <debmc@linux.vnet.ibm.com> writes:
> Problem being solved is when issuing a BMC soft poweroff during IPL,
> the poweroff was being lost so the machine would not poweroff.
>
> Opal messages were being received before the opal-power code
> registered its notifiers.
>
> Alternatives discussed (option #3 was chosen):
>
> 1 - Have opal_message_init() explicitly call opal_power_control_init()
> before it dequeues any OPAL messages (i.e. before we register the
> opal-msg IRQ handler).
>
> 2 - Introduce concept of critical message types and when we register
> handlers we track which message types have a registered handler,
> then defer the opal-msg IRQ registration until we have a handler
> registered for all the critical types.
>
> 3 - Buffering messages, if we receive a message and do not yet
> have a handler for that type, store the message and replay when
> a handler for that type is registered.
>
> Signed-off-by: Deb McLemore <debmc@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/opal.c | 83 ++++++++++++++++++++++++++++++++---
>  1 file changed, 78 insertions(+), 5 deletions(-)

Hi Deb,

Sorry for the delay (!) on this one.

A couple more comments ...

> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 65c79ec..46d7604 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -238,14 +288,25 @@ machine_early_initcall(powernv, opal_register_exception_handlers);
>  int opal_message_notifier_register(enum opal_msg_type msg_type,
>  					struct notifier_block *nb)
>  {
> +	int ret;
> +
>  	if (!nb || msg_type >= OPAL_MSG_TYPE_MAX) {
>  		pr_warning("%s: Invalid arguments, msg_type:%d\n",
>  			   __func__, msg_type);
>  		return -EINVAL;
>  	}
  
We still want to take the msg_list_lock around the registration, ie.
from here to the end of the function.

> -	return atomic_notifier_chain_register(
> -				&opal_msg_notifier_head[msg_type], nb);
> +	ret = atomic_notifier_chain_register(
> +		&opal_msg_notifier_head[msg_type], nb);
> +
> +	if (ret)
> +		return ret;

Otherwise a message that arrives here will be delivered before any
queued messages, which might be a problem.

> +
> +	/* Replay any queued messages that came in  */
> +	/* prior to the notifier chain registration */
> +	dequeue_replay_msg(msg_type);
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(opal_message_notifier_register);
>  
> @@ -259,9 +320,21 @@ EXPORT_SYMBOL_GPL(opal_message_notifier_unregister);
>  
>  static void opal_message_do_notify(uint32_t msg_type, void *msg)
>  {
> -	/* notify subscribers */
> -	atomic_notifier_call_chain(&opal_msg_notifier_head[msg_type],
> -					msg_type, msg);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&msg_list_lock, flags);
> +
> +	if (opal_msg_notifier_head[msg_type].head != NULL) {
> +		/* notify subscribers */
> +		atomic_notifier_call_chain(&opal_msg_notifier_head[msg_type],
> +						msg_type, msg);
> +	} else {
> +		/* Queue up the msg since no notifiers have */
> +		/* registered yet for this msg_type         */
> +		queue_replay_msg(msg);
> +	}
> +
> +	spin_unlock_irqrestore(&msg_list_lock, flags);

I don't think it's actually likely to be a problem, but it would be nice
if we didn't have to hold the lock while calling the notifier in the
general case.

I think we can do that with eg:

	bool queued = false;

	spin_lock_irqsave(&msg_list_lock, flags);

	if (opal_msg_notifier_head[msg_type].head == NULL) {
		/*
                 * Queue up the msg since no notifiers have registered
                 * yet for this msg_type.
                 */
		queue_replay_msg(msg);
                queued = true;
	}

	spin_unlock_irqrestore(&msg_list_lock, flags);

	if (queued)
        	return;

	/* notify subscribers */
	atomic_notifier_call_chain(&opal_msg_notifier_head[msg_type], msg_type, msg);

cheers
