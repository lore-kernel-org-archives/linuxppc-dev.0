Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD9BC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 08:40:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C67214AF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 08:40:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C67214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444nws1QyTzDqC3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 19:40:28 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444ntq086TzDq6N
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 19:38:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 444ntp5Wv2z8sjs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 19:38:42 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 444ntp4s2Cz9sD4; Thu, 21 Feb 2019 19:38:42 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=suse.com
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=pmladek@suse.com;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.com
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 444ntn73Kyz9sCH
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2019 19:38:40 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9D9F8AC7A;
 Thu, 21 Feb 2019 08:38:37 +0000 (UTC)
Date: Thu, 21 Feb 2019 09:38:35 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH v3 1/7] dump_stack: Support adding to the dump stack arch
 description
Message-ID: <20190221083835.pwwwcqtwfucxkday@pathway.suse.cz>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
 <20190211125035.GA1562@andrea>
 <20190211143859.dd2lkccxod3f2fwn@pathway.suse.cz>
 <20190219233925.GA5648@andrea>
 <87va1e7pw2.fsf@concordia.ellerman.id.au>
 <20190220134433.GA4932@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220134433.GA4932@andrea>
User-Agent: NeoMutt/20170421 (1.8.2)
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

On Wed 2019-02-20 14:44:33, Andrea Parri wrote:
> > >> > > +		 * Order the stores above in vsnprintf() vs the store of the
> > >> > > +		 * space below which joins the two strings. Note this doesn't
> > >> > > +		 * make the code truly race free because there is no barrier on
> > >> > > +		 * the read side. ie. Another CPU might load the uninitialised
> > >> > > +		 * tail of the buffer first and then the space below (rather
> > >> > > +		 * than the NULL that was there previously), and so print the
> > >> > > +		 * uninitialised tail. But the whole string lives in BSS so in
> > >> > > +		 * practice it should just see NULLs.
> > >> > 
> > It is not my intention to support concurrent updates of the string. The
> > idea is you setup the string early in boot.
> 
> Understood, thanks for the clarification.
> > 
> > The concern with a concurrent reader is simply that the string is dumped
> > in the panic path, and you never really know when you're going to panic.
> > Even if you only write to the string before doing SMP bringup you might
> > still have another CPU go rogue and panic before then.
> > 
> > But I probably should have just not added the barrier, it's over
> > paranoid and will almost certainly never matter in practice.
> 
> Oh, well, I can only echo you: if you don't care about the stores being
> _observed_ out of order, you could simply remove the barrier; if you do
> care, then you need "more paranoid" on the readers side.  ;-)

Hmm, the barrier might be fine and actually useful. The
purpose is to make sure that the later '\0' is written before
the existing one is replaced by ' '.

The reader does not need the barrier as long as it reads the string
sequentially. I would expect that it is always the case. But who
knows with all the speculation-related CPU bugs around.

In each case, any race could never crash the kernel.
The dump_stack_arch_desc_str is zeroed out of box and
the very last '\0' is never rewritten.

Best Regards,
Petr
