Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA79C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 14:22:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25FA205F4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 14:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25FA205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bMTk0yn2zDqSy
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Apr 2019 01:22:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jpoimboe@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bMRt5FsVzDqQK
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2019 01:20:58 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BEC5C308FF32;
 Fri,  5 Apr 2019 14:20:55 +0000 (UTC)
Received: from treble (ovpn-123-87.rdu2.redhat.com [10.10.123.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92E925D705;
 Fri,  5 Apr 2019 14:20:50 +0000 (UTC)
Date: Fri, 5 Apr 2019 09:20:48 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH RFC 1/5] cpu/speculation: Add 'cpu_spec_mitigations='
 cmdline options
Message-ID: <20190405142048.burthk2jnpcvi2om@treble>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <f0bd17358ab478eaca52f3b1da8305c150911b40.1554396090.git.jpoimboe@redhat.com>
 <20190405131211.GE23348@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405131211.GE23348@zn.tnic>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 05 Apr 2019 14:20:56 +0000 (UTC)
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
Cc: Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <longman@redhat.com>,
 linux-arch@vger.kernel.org, Jon Masters <jcm@redhat.com>,
 Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tyler Hicks <tyhicks@canonical.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Apr 05, 2019 at 03:12:11PM +0200, Borislav Petkov wrote:
> On Thu, Apr 04, 2019 at 11:44:11AM -0500, Josh Poimboeuf wrote:
> > Keeping track of the number of mitigations for all the CPU speculation
> > bugs has become overwhelming for many users.  It's getting more and more
> > complicated to decide which mitigations are needed for a given
> > architecture.  Complicating matters is the fact that each arch tends to
> > their own custom way to mitigate the same vulnerability.
> 
> Yap, we definitely need something like that.
> 
> > Most users fall into a few basic categories:
> > 
> > a) they want all mitigations off;
> > 
> > b) they want all reasonable mitigations on, with SMT enabled even if
> >    it's vulnerable; or
> 
> Uff, "reasonable" - there's the bikeshed waiting to happen.

Luckily the defaults have already been chosen.  So "reasonable" just
means to use the defaults.

> > c) they want all reasonable mitigations on, with SMT disabled if
> >    vulnerable.
> > 
> > Define a set of curated, arch-independent options, each of which is an
> > aggregation of existing options:
> > 
> > - cpu_spec_mitigations=off: Disable all mitigations.
> 
> "cpu_spec_mitigations" is too long, TBH.
> 
> Imagine yourself in a loud, noisy data center - you basically can't wait
> to leave - crouched over a keyboard in an impossible position, having
> to type that thing and then making a typo. Whoops, too late, already
> pressed Enter. Shiiiit!

Sure, it's a bit long.  But it's also easier to remember and more
self-documenting than any shortened option I could come up with.

In your scenario, the fact that it's so easy to remember would save the
day, since you wouldn't have to go look up some obscure shortened option
name in the documentation :-)

Suggestions are welcome but I couldn't come up with a reasonable shorter
option.

> Now you have to wait at least 15 mins for the damn single-threaded added
> value BIOS crap to noodle through all the cores just so you can try
> again, because you just rebooted the box.
> 
> And I know, my ideas for shorter cmdline options are crazy, like
> 
> cpu_spec_mtg=
> 
> which people would say, yuck, unreadable...

I agree with those people.  In my world "mtg" is short for meeting.

> Oh, I know! How about
> 
> cpu_vulns=
> 
> ?

No, because

a) We aren't enabling/disabling *vulnerabilities*, but rather
   mitigations;

b) We aren't enabling/disabling *all* CPU mitigations, only the
   speculative ones.

> We already have /sys/devices/system/cpu/vulnerabilities so it'll be the
> same as that. Less things to remember.

Except that it's not called "cpu_vulns"...

-- 
Josh
