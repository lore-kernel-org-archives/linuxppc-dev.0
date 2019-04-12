Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF79BC10F13
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 02:42:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310E220869
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 02:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310E220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gMd91fgTzDqJR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 12:42:53 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gMbQ3RdwzDqJR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 12:41:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44gMbP2hcyz9s5c;
 Fri, 12 Apr 2019 12:41:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Josh Poimboeuf <jpoimboe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC 1/5] cpu/speculation: Add 'cpu_spec_mitigations='
 cmdline options
In-Reply-To: <20190411131540.754t5t4tp55i6vjq@treble>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <f0bd17358ab478eaca52f3b1da8305c150911b40.1554396090.git.jpoimboe@redhat.com>
 <20190405131211.GE23348@zn.tnic> <20190405142048.burthk2jnpcvi2om@treble>
 <20190405152059.GG23348@zn.tnic> <20190405160136.GI23348@zn.tnic>
 <20190405161852.nmpk22omgiety4df@treble>
 <87sguqwgu7.fsf@concordia.ellerman.id.au>
 <alpine.DEB.2.21.1904101408580.3479@nanos.tec.linutronix.de>
 <20190411131540.754t5t4tp55i6vjq@treble>
Date: Fri, 12 Apr 2019 12:41:21 +1000
Message-ID: <878swguer2.fsf@concordia.ellerman.id.au>
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
Cc: Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <longman@redhat.com>,
 linux-arch@vger.kernel.org, Jon Masters <jcm@redhat.com>,
 Jiri Kosina <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tyler Hicks <tyhicks@canonical.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Josh Poimboeuf <jpoimboe@redhat.com> writes:
> On Wed, Apr 10, 2019 at 02:10:01PM +0200, Thomas Gleixner wrote:
>> On Wed, 10 Apr 2019, Michael Ellerman wrote:
>> > Josh Poimboeuf <jpoimboe@redhat.com> writes:
>> > 
>> > > On Fri, Apr 05, 2019 at 06:01:36PM +0200, Borislav Petkov wrote:
>> > >> Thinking about this more, we can shave off the first 4 chars and have it
>> > >> be:
>> > >> 
>> > >> spec_mitigations=
>> > >> 
>> > >> I think it is painfully clear which speculation mitigations we mean. And
>> > >> the other switches don't have "cpu_" prefixes too so...
>> > >
>> > > Sure, I'm ok with renaming it to that, if there are no objections.
>> > 
>> > What about when we have a mitigation for a non-speculation related bug :)
>> 
>> Those kind of silicon bugs are usually mitigated unconditionally.
>
> Right.
>
> But at least "mitigations=" is nice and short.  We could clarify in the
> documentation that it doesn't apply to *all* mitigations, only the ones
> which are optional and which can affect performance.
>
> And it would give us the freedom to include any future "optional"
> mitigations, spec or not.
>
> I kind of like it.  But I could go either way.

Some of the published SMT attacks are not speculation based.

And arguably we already have an optional mitigation for those, ie. nosmt.

cheers
