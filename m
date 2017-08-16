Return-Path: <pmladek@suse.com>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXX4y2WvpzDrKZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 00:37:54 +1000 (AEST)
Date: Wed, 16 Aug 2017 16:37:48 +0200
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: jpoimboe@redhat.com, jeyu@kernel.org, jikos@kernel.org,
 lpechacek@suse.cz, live-patching@vger.kernel.org,
 linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: Re: [PATCH v2 2/3] livepatch: send a fake signal to all blocking tasks
Message-ID: <20170816143748.GC601@pathway.suse.cz>
References: <20170810104815.14727-1-mbenes@suse.cz>
 <20170810104815.14727-3-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170810104815.14727-3-mbenes@suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu 2017-08-10 12:48:14, Miroslav Benes wrote:
> Live patching consistency model is of LEAVE_PATCHED_SET and
> SWITCH_THREAD. This means that all tasks in the system have to be marked
> one by one as safe to call a new patched function. Safe means when a
> task is not (sleeping) in a set of patched functions. That is, no
> patched function is on the task's stack. Another clearly safe place is
> the boundary between kernel and userspace. The patching waits for all
> tasks to get outside of the patched set or to cross the boundary. The
> transition is completed afterwards.
> 
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 79022b7eca2c..a359340c924d 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -452,7 +452,7 @@ EXPORT_SYMBOL_GPL(klp_enable_patch);
>  static ssize_t force_show(struct kobject *kobj,
>  			  struct kobj_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "No operation is currently permitted.\n");
> +	return sprintf(buf, "signal\n");

This makes invalid the "NOTE:" above this function ;-)

Best Regards,
Petr
