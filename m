Return-Path: <SRS0=9qWD=TP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B8EC04E53
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 07:55:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C7A20843
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 07:55:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C7A20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 453n0N0z0ZzDqTn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 May 2019 17:55:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.com
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=pmladek@suse.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.com
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 453myf0TVJzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2019 17:53:43 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 8FDD9AF3F;
 Wed, 15 May 2019 07:53:40 +0000 (UTC)
Date: Wed, 15 May 2019 09:53:39 +0200
From: Petr Mladek <pmladek@suse.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
Message-ID: <20190515075339.7biocrjfpxj77l3b@pathway.suse.cz>
References: <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com>
 <20190513091320.GK9224@smile.fi.intel.com>
 <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz>
 <20190514020730.GA651@jagdpanzerIV>
 <45348cf615fe40d383c1a25688d4a88f@AcuMS.aculab.com>
 <CAMuHMdXaMObq9h2Sb49PW1-HUysPeaWXB7wJmKFz=xLmSoUDZg@mail.gmail.com>
 <20190514143751.48e81e05@oasis.local.home>
 <CAMuHMdUhy3uB+G23uXh__F2Y_Jsam5uS1Q5jJC95kWAOEM8WRA@mail.gmail.com>
 <20190514153503.6b7faaa7@oasis.local.home>
 <CAMuHMdUFEwxwQUWg0HNUiz75hP6S7TVGSx7fWXnsQ_3qsVfotQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUFEwxwQUWg0HNUiz75hP6S7TVGSx7fWXnsQ_3qsVfotQ@mail.gmail.com>
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
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@suse.cz>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 David Laight <David.Laight@aculab.com>, Stephen Rothwell <sfr@ozlabs.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed 2019-05-15 09:23:05, Geert Uytterhoeven wrote:
> Hi Steve,
> 
> On Tue, May 14, 2019 at 9:35 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Tue, 14 May 2019 21:13:06 +0200
> > Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > Do we care about the value? "(-E%u)"?
> > > >
> > > > That too could be confusing. What would (-E22) be considered by a user
> > > > doing an sprintf() on some string. I know that would confuse me, or I
> > > > would think that it was what the %pX displayed, and wonder why it
> > > > displayed it that way. Whereas "(fault)" is quite obvious for any %p
> > > > use case.
> > >
> > > I would immediately understand there's a missing IS_ERR() check in a
> > > function that can return  -EINVAL, without having to add a new printk()
> > > to find out what kind of bogus value has been received, and without
> > > having to reboot, and trying to reproduce...
> >
> > I have to ask. Has there actually been a case that you used a %pX and
> > it faulted, and you had to go back to find what the value of the
> > failure was?
> 
> If it faulted, the bad pointer value is obvious from the backtrace.
> If the code avoids the fault by verifying the pointer and returning
> "(efault)" instead, the bad pointer value is lost.
> 
> Or am I missing something?

Should buggy printk() crash the system?

Another problem is that vsprintf() is called in printk() under
lockbuf_lock. The messages are stored into printk_safe per CPU
buffers. It allows to see the nested messages. But there is still
a bigger risk of missing them than with a "normal" fault.

Finally, various variants of these checks were already used
in "random" printf formats. The only change is that we are
using them consistently everywhere[*] a pointer is accessed.

[*] Just the top level pointer is checked. Some pointer modifiers
are accessing ptr->ptr->val. The lower level pointers are not
checked to avoid too much complexity.

Best Regards,
Petr
