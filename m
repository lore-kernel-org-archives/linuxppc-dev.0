Return-Path: <SRS0=ygHD=TN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C8DC04AA7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2019 12:44:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36C8208C2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2019 12:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36C8208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 452gVx5LG5zDqHW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2019 22:44:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.com
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=pmladek@suse.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.com
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 452gSf0pyPzDqH5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2019 22:42:25 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id B3F83AF79;
 Mon, 13 May 2019 12:42:21 +0000 (UTC)
Date: Mon, 13 May 2019 14:42:20 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
Message-ID: <20190513124220.wty2qbnz4wo52h3x@pathway.suse.cz>
References: <20190510081635.GA4533@jagdpanzerIV>
 <20190510084213.22149-1-pmladek@suse.com>
 <20190510122401.21a598f6@gandalf.local.home>
 <daf4dfd1-7f4f-8b92-6866-437c3a2be28b@c-s.fr>
 <096d6c9c17b3484484d9d9d3f3aa3a7c@AcuMS.aculab.com>
 <20190513091320.GK9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190513091320.GK9224@smile.fi.intel.com>
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
 David Laight <David.Laight@ACULAB.COM>, Stephen Rothwell <sfr@ozlabs.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon 2019-05-13 12:13:20, Andy Shevchenko wrote:
> On Mon, May 13, 2019 at 08:52:41AM +0000, David Laight wrote:
> > From: christophe leroy
> > > Sent: 10 May 2019 18:35
> > > Le 10/05/2019 à 18:24, Steven Rostedt a écrit :
> > > > On Fri, 10 May 2019 10:42:13 +0200
> > > > Petr Mladek <pmladek@suse.com> wrote:
> 
> > > >> -	if (probe_kernel_address(ptr, byte))
> > > >> +	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
> > > >>   		return "(efault)";
> > 
> > "efault" looks a bit like a spellling mistake for "default".
> 
> It's a special, thus it's in parenthesis, though somebody can be
> misguided.
> 
> > > Usually, < PAGE_SIZE means NULL pointer dereference (via the member of a
> > > struct)
> > 
> > Maybe the caller should pass in a short buffer so that you can return
> > "(err-%d)"
> > or "(null+%#x)" ?

There are many vsprintf() users. I am afraid that nobody would want
to define extra buffers for error messages. It must fit into
the one for the formatted string.


> In both cases it should be limited to the size of pointer (8 or 16
> characters). Something like "(e:%4d)" would work for error codes.

I am afraid that we could get 10 different proposals from a huge
enough group of people. I wanted to start with something simple
(source code). I know that (efault) might be confused with
"default" but it is still just one string to grep.


> The "(null)" is good enough by itself and already an established
> practice..

(efault) made more sense with the probe_kernel_read() that
checked wide range of addresses. Well, I still think that
it makes sense to distinguish a pure NULL. And it still
used also for IS_ERR_VALUE().

Best Regards,
Petr
