Return-Path: <SRS0=Jq0w=TK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EDDC04A6B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 May 2019 08:07:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C264E2177B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 May 2019 08:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C264E2177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 450jW32wK2zDqSF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 May 2019 18:07:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.com
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=pmladek@suse.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.com
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 450jTF3VvYzDqRh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2019 18:06:07 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 718D5AD69;
 Fri, 10 May 2019 08:06:03 +0000 (UTC)
Date: Fri, 10 May 2019 10:06:02 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
Message-ID: <20190510080602.mdfk54f6lpyg6unw@pathway.suse.cz>
References: <20190509121923.8339-1-pmladek@suse.com>
 <20190510043200.GC15652@jagdpanzerIV>
 <CAHk-=wiP+hwSqEW0dM6AYNWUR7jXDkeueq69et6ahfUgV7hC3w@mail.gmail.com>
 <20190510050709.GA1831@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510050709.GA1831@jagdpanzerIV>
User-Agent: NeoMutt/20170912 (1.9.0)
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
Cc: linux-arch@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@suse.cz>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Stephen Rothwell <sfr@ozlabs.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri 2019-05-10 14:07:09, Sergey Senozhatsky wrote:
> On (05/09/19 21:47), Linus Torvalds wrote:
> >    [ Sorry about html and mobile crud, I'm not at the computer right now ]
> >    How about we just undo the whole misguided probe_kernel_address() thing?
> 
> But the problem will remain - %pS/%pF on PPC (and some other arch-s)
> do dereference_function_descriptor(), which calls probe_kernel_address().
> So if probe_kernel_address() starts to dump_stack(), then we are heading
> towards stack overflow. Unless I'm totally missing something.

That is true. On the other hand, %pS/%pF uses
dereference_function_descriptor() only on three architectures.
And these modifiers are used only rarely (ok, in dump_stack()
but still).

On the other hand, any infinite loop in vsprintf() via
probe_kernel_address() would break any printk(). And would be
hard to debug.

I tend to agree with Linus. probe_kernel_address() is too complicated.
It is prone to these infinite loops and should not be used in
the default printk() path.

It would be nice to have a lightweight and safe alternative. But
I can't find any. And I think that it is not worth any huge
complexity. It was just a nice to have idea...


I am going to send a patch replacing probe_kernel_address() with
a simple check:

	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
		return "(efault)";

The original patch still makes sense because it adds the check
into more locations and replaces some custom variants.

Best Regards,
Petr
