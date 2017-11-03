Return-Path: <mbenes@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySvgR5vHvzDqwS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Nov 2017 19:06:59 +1100 (AEDT)
Date: Fri, 3 Nov 2017 09:06:55 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: jeyu@kernel.org, jikos@kernel.org, pmladek@suse.com, lpechacek@suse.cz,
 pavel@ucw.cz, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v3 1/2] livepatch: send a fake signal to all blocking tasks
In-Reply-To: <20171102133200.abwvepjx3ytufsc4@treble>
Message-ID: <alpine.LSU.2.21.1711030903110.31648@pobox.suse.cz>
References: <20171031114853.841-1-mbenes@suse.cz>
 <20171031114853.841-2-mbenes@suse.cz>
 <20171102133200.abwvepjx3ytufsc4@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2 Nov 2017, Josh Poimboeuf wrote:

> On Tue, Oct 31, 2017 at 12:48:52PM +0100, Miroslav Benes wrote:
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index bf8c8fd72589..b7c60662baf3 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -440,6 +440,7 @@ EXPORT_SYMBOL_GPL(klp_enable_patch);
> >   * /sys/kernel/livepatch/<patch>
> >   * /sys/kernel/livepatch/<patch>/enabled
> >   * /sys/kernel/livepatch/<patch>/transition
> > + * /sys/kernel/livepatch/<patch>/signal
> >   * /sys/kernel/livepatch/<patch>/<object>
> >   * /sys/kernel/livepatch/<patch>/<object>/<function,sympos>
> >   */
> > @@ -514,11 +515,37 @@ static ssize_t transition_show(struct kobject *kobj,
> >  			patch == klp_transition_patch);
> >  }
> >  
> > +static ssize_t signal_store(struct kobject *kobj, struct kobj_attribute *attr,
> > +			    const char *buf, size_t count)
> > +{
> > +	int ret;
> > +	bool val;
> > +
> > +	/*
> > +	 * klp_mutex lock is not grabbed here intentionally. It is not really
> > +	 * needed. The race window is harmless and grabbing the lock would only
> > +	 * hold the action back.
> > +	 */
> > +	if (!klp_transition_patch)
> > +		return -EINVAL;
> > +
> > +	ret = kstrtobool(buf, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (val)
> > +		klp_force_signals();
> > +
> > +	return count;
> > +}
> 
> The function still has global functionality even though the sysfs entry
> is now per-patch.  So if you do
> 
>   echo 1 > /sys/kernel/livepatch/patch1/signal
> 
> But patch2 is in transition, then it will send signals based on patch2.
> Instead it should probably return an error.
> 
> There's a similar issue with force_store().

Bah. I still find having "signal" and "force" in 
/sys/kernel/livepatch/<patch>/ a bit odd, but I'll add

        struct klp_patch *patch;

        patch = container_of(kobj, struct klp_patch, kobj);
	/*
	 ...
	 */
	if (patch != klp_transition_patch)
		return -EINVAL;


That should solve it for all cases.

Thanks,
Miroslav
