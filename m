Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63746C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 09:49:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8442089F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 09:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8442089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444CVd50SlzDqDW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 20:49:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444CSg1xbfzDqD2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 20:47:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 444CSg12k3z9s7h; Wed, 20 Feb 2019 20:47:31 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 444CSc24jVz9s70;
 Wed, 20 Feb 2019 20:47:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrea Parri <andrea.parri@amarulasolutions.com>,
 Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 1/7] dump_stack: Support adding to the dump stack arch
 description
In-Reply-To: <20190219233925.GA5648@andrea>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
 <20190211125035.GA1562@andrea>
 <20190211143859.dd2lkccxod3f2fwn@pathway.suse.cz>
 <20190219233925.GA5648@andrea>
Date: Wed, 20 Feb 2019 20:47:25 +1100
Message-ID: <87va1e7pw2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, sergey.senozhatsky@gmail.com,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 linuxppc-dev@ozlabs.org, tj@kernel.org, akpm@linux-foundation.org,
 dyoung@redhat.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Andrea Parri <andrea.parri@amarulasolutions.com> writes:
> On Mon, Feb 11, 2019 at 03:38:59PM +0100, Petr Mladek wrote:
>> On Mon 2019-02-11 13:50:35, Andrea Parri wrote:
>> > On Thu, Feb 07, 2019 at 11:46:29PM +1100, Michael Ellerman wrote:
>> > > Arch code can set a "dump stack arch description string" which is
>> > > displayed with oops output to describe the hardware platform.
>> > > 
>> > > It is useful to initialise this as early as possible, so that an early
>> > > oops will have the hardware description.
>> > > 
>> > > However in practice we discover the hardware platform in stages, so it
>> > > would be useful to be able to incrementally fill in the hardware
>> > > description as we discover it.
>> > > 
>> > > This patch adds that ability, by creating dump_stack_add_arch_desc().
>> > > 
>> > > If there is no existing string it behaves exactly like
>> > > dump_stack_set_arch_desc(). However if there is an existing string it
>> > > appends to it, with a leading space.
>> > > 
>> > > This makes it easy to call it multiple times from different parts of the
>> > > code and get a reasonable looking result.
>> > > 
>> > > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> > > ---
>> > >  include/linux/printk.h |  5 ++++
>> > >  lib/dump_stack.c       | 58 ++++++++++++++++++++++++++++++++++++++++++
>> > >  2 files changed, 63 insertions(+)
>> > > 
>> > > v3: No change, just widened Cc list.
>> > > 
>> > > v2: Add a smp_wmb() and comment.
>> > > 
>> > > v1 is here for reference https://lore.kernel.org/lkml/1430824337-15339-1-git-send-email-mpe@ellerman.id.au/
>> > > 
>> > > I'll take this series via the powerpc tree if no one minds?
>> > > 
>> > > 
>> > > diff --git a/include/linux/printk.h b/include/linux/printk.h
>> > > index 77740a506ebb..d5fb4f960271 100644
>> > > --- a/include/linux/printk.h
>> > > +++ b/include/linux/printk.h
>> > > @@ -198,6 +198,7 @@ u32 log_buf_len_get(void);
>> > >  void log_buf_vmcoreinfo_setup(void);
>> > >  void __init setup_log_buf(int early);
>> > >  __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...);
>> > > +__printf(1, 2) void dump_stack_add_arch_desc(const char *fmt, ...);
>> > >  void dump_stack_print_info(const char *log_lvl);
>> > >  void show_regs_print_info(const char *log_lvl);
>> > >  extern asmlinkage void dump_stack(void) __cold;
>> > > @@ -256,6 +257,10 @@ static inline __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...)
>> > >  {
>> > >  }
>> > >  
>> > > +static inline __printf(1, 2) void dump_stack_add_arch_desc(const char *fmt, ...)
>> > > +{
>> > > +}
>> > > +
>> > >  static inline void dump_stack_print_info(const char *log_lvl)
>> > >  {
>> > >  }
>> > > diff --git a/lib/dump_stack.c b/lib/dump_stack.c
>> > > index 5cff72f18c4a..69b710ff92b5 100644
>> > > --- a/lib/dump_stack.c
>> > > +++ b/lib/dump_stack.c
>> > > @@ -35,6 +35,64 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
>> > >  	va_end(args);
>> > >  }
>> > >  
>> > > +/**
>> > > + * dump_stack_add_arch_desc - add arch-specific info to show with task dumps
>> > > + * @fmt: printf-style format string
>> > > + * @...: arguments for the format string
>> > > + *
>> > > + * See dump_stack_set_arch_desc() for why you'd want to use this.
>> > > + *
>> > > + * This version adds to any existing string already created with either
>> > > + * dump_stack_set_arch_desc() or dump_stack_add_arch_desc(). If there is an
>> > > + * existing string a space will be prepended to the passed string.
>> > > + */
>> > > +void __init dump_stack_add_arch_desc(const char *fmt, ...)
>> > > +{
>> > > +	va_list args;
>> > > +	int pos, len;
>> > > +	char *p;
>> > > +
>> > > +	/*
>> > > +	 * If there's an existing string we snprintf() past the end of it, and
>> > > +	 * then turn the terminating NULL of the existing string into a space
>> > > +	 * to create one string separated by a space.
>> > > +	 *
>> > > +	 * If there's no existing string we just snprintf() to the buffer, like
>> > > +	 * dump_stack_set_arch_desc(), but without calling it because we'd need
>> > > +	 * a varargs version.
>> > > +	 */
>> > > +	len = strnlen(dump_stack_arch_desc_str, sizeof(dump_stack_arch_desc_str));
>> > > +	pos = len;
>> > > +
>> > > +	if (len)
>> > > +		pos++;
>> > > +
>> > > +	if (pos >= sizeof(dump_stack_arch_desc_str))
>> > > +		return; /* Ran out of space */
>> > > +
>> > > +	p = &dump_stack_arch_desc_str[pos];
>> > > +
>> > > +	va_start(args, fmt);
>> > > +	vsnprintf(p, sizeof(dump_stack_arch_desc_str) - pos, fmt, args);
>> > > +	va_end(args);
>> > > +
>> > > +	if (len) {
>> > > +		/*
>> > > +		 * Order the stores above in vsnprintf() vs the store of the
>> > > +		 * space below which joins the two strings. Note this doesn't
>> > > +		 * make the code truly race free because there is no barrier on
>> > > +		 * the read side. ie. Another CPU might load the uninitialised
>> > > +		 * tail of the buffer first and then the space below (rather
>> > > +		 * than the NULL that was there previously), and so print the
>> > > +		 * uninitialised tail. But the whole string lives in BSS so in
>> > > +		 * practice it should just see NULLs.
>> > 
>> > The comment doesn't say _why_ we need to order these stores: IOW, what
>> > will or can go wrong without this order?  This isn't clear to me.
>> >
>> > Another good practice when adding smp_*-constructs (as discussed, e.g.,
>> > at KS'18) is to indicate the matching construct/synch. mechanism.
>> 
>> Yes, one barrier without a counter-part is suspicious.
>
> As is this silence...,
>
> Michael, what happened to this patch? did you submit a new version?

No, I'm just busy, it's the merge window next week :)

I thought the comment was pretty clear, if the stores are observed out
of order we might print the uninitialised tail.

And the barrier on the read side would need to be in printk somewhere,
which is obviously unpleasant.

>> If the parallel access is really needed then we could define the
>> current length as atomic_t and use:
>> 
>> 	+ atomic_cmpxchg() to reserve the space for the string
>> 	+ %*s to limit the printed length
>> 
>> In the worst case, we would print an incomplete string.
>> See below for a sample code.
>
> Seems worth exploring, IMO; but I'd like to first hear _clear about
> the _intended semantics (before digging into alternatives)...

It is not my intention to support concurrent updates of the string. The
idea is you setup the string early in boot.

The concern with a concurrent reader is simply that the string is dumped
in the panic path, and you never really know when you're going to panic.
Even if you only write to the string before doing SMP bringup you might
still have another CPU go rogue and panic before then.

But I probably should have just not added the barrier, it's over
paranoid and will almost certainly never matter in practice.

cheers
