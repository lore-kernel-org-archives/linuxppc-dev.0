Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46072C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:20:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFFB7206B7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:20:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFFB7206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44g1qD5cXLzDqYM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 23:20:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=jpoimboe@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44g1jy0KkczDqY7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 23:15:49 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4BDE30832DE;
 Thu, 11 Apr 2019 13:15:47 +0000 (UTC)
Received: from treble (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AA9061998;
 Thu, 11 Apr 2019 13:15:42 +0000 (UTC)
Date: Thu, 11 Apr 2019 08:15:40 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC 1/5] cpu/speculation: Add 'cpu_spec_mitigations='
 cmdline options
Message-ID: <20190411131540.754t5t4tp55i6vjq@treble>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <f0bd17358ab478eaca52f3b1da8305c150911b40.1554396090.git.jpoimboe@redhat.com>
 <20190405131211.GE23348@zn.tnic>
 <20190405142048.burthk2jnpcvi2om@treble>
 <20190405152059.GG23348@zn.tnic> <20190405160136.GI23348@zn.tnic>
 <20190405161852.nmpk22omgiety4df@treble>
 <87sguqwgu7.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.21.1904101408580.3479@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904101408580.3479@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 11 Apr 2019 13:15:48 +0000 (UTC)
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
 x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <longman@redhat.com>,
 linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
 Jiri Kosina <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Jon Masters <jcm@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tyler Hicks <tyhicks@canonical.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 10, 2019 at 02:10:01PM +0200, Thomas Gleixner wrote:
> On Wed, 10 Apr 2019, Michael Ellerman wrote:
> > Josh Poimboeuf <jpoimboe@redhat.com> writes:
> > 
> > > On Fri, Apr 05, 2019 at 06:01:36PM +0200, Borislav Petkov wrote:
> > >> Thinking about this more, we can shave off the first 4 chars and have it
> > >> be:
> > >> 
> > >> spec_mitigations=
> > >> 
> > >> I think it is painfully clear which speculation mitigations we mean. And
> > >> the other switches don't have "cpu_" prefixes too so...
> > >
> > > Sure, I'm ok with renaming it to that, if there are no objections.
> > 
> > What about when we have a mitigation for a non-speculation related bug :)
> 
> Those kind of silicon bugs are usually mitigated unconditionally.

Right.

But at least "mitigations=" is nice and short.  We could clarify in the
documentation that it doesn't apply to *all* mitigations, only the ones
which are optional and which can affect performance.

And it would give us the freedom to include any future "optional"
mitigations, spec or not.

I kind of like it.  But I could go either way.

-- 
Josh
