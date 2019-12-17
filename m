Return-Path: <SRS0=7pZz=2H=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA8AC43603
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Dec 2019 17:09:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0745A21582
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Dec 2019 17:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCZA19g8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0745A21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47cl4H5yt3zDqRp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2019 04:09:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=will@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="MCZA19g8"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47cl1r0Sj2zDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2019 04:07:27 +1100 (AEDT)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 10F5D21582;
 Tue, 17 Dec 2019 17:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576602445;
 bh=9qLjCTJpYDZjDSgYG+Ze2rFSDFpRuJkwVOsNbCXu0yY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MCZA19g8+N5u/xEbIwE1OkPJs7Q9S+e4Y81lid+WvA3+cRX4qe8OuIKisihkv0c/l
 11VbnaWSg9gj0yX2tA2M/5poVsgWBQNWKvgdJIz/uubigq7HhGPmSVAoAbgku2i5Ye
 YBVeE6w6e3k1AR2O/IkXLuxvyZNJbHTKwRVO/jMc=
Date: Tue, 17 Dec 2019 17:07:19 +0000
From: Will Deacon <will@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Message-ID: <20191217170719.GA869@willie-the-truck>
References: <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck>
 <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Peter Zijlstra <peterz@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>, linuxppc-dev@lists.ozlabs.org,
 dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 12, 2019 at 12:49:52PM -0800, Linus Torvalds wrote:
> On Thu, Dec 12, 2019 at 11:34 AM Will Deacon <will@kernel.org> wrote:
> >
> > The root of my concern in all of this, and what started me looking at it in
> > the first place, is the interaction with 'typeof()'. Inheriting 'volatile'
> > for a pointer means that local variables in macros declared using typeof()
> > suddenly start generating *hideous* code, particularly when pointless stack
> > spills get stackprotector all excited.
> 
> Yeah, removing volatile can be a bit annoying.
> 
> For the particular case of the bitops, though, it's not an issue.
> Since you know the type there, you can just cast it.
> 
> And if we had the rule that READ_ONCE() was an arithmetic type, you could do
> 
>     typeof(0+(*p)) __var;
> 
> since you might as well get the integer promotion anyway (on the
> non-volatile result).
> 
> But that doesn't work with structures or unions, of course.
> 
> I'm not entirely sure we have READ_ONCE() with a struct. I do know we
> have it with 64-bit entities on 32-bit machines, but that's ok with
> the "0+" trick.

Other than the two trivial examples Arnd and I spotted, it looks like
we're in for some fun with the page-table types such as pud_t but that
/should/ be fixable with enough effort.

However, I'm really banging my head against the compiler trying to get
your trick above to work for pointer types when the pointed-to-type is
not defined. As a very cut down example (I pulled this back out of the
preprocessor and cleaned it up a bit):


struct dentry {
	struct inode *d_inode;
};

static inline struct inode *d_inode_rcu(struct dentry *dentry)
{
	return ({
		typeof(0 + dentry->d_inode) __x = (*(volatile typeof(dentry->d_inode) *)&(dentry->d_inode));
		(typeof(dentry->d_inode))__x;
	});
}


Trying to compile this results in:

  | In function 'd_inode_rcu':
  | error: invalid use of undefined type 'struct inode'

whereas it compiles fine if you remove the '0 +' from the first typeof.

What am I missing? Perhaps the compiler wants the size information of
'struct inode' before it will contemplate the arithmetic, but if so then
I don't think we can use this trick after all. Hmm.

Will
