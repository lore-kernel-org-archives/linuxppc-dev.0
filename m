Return-Path: <gitster@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id 12DE7DDEE0
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 10:59:07 +1000 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: avorontsov@ru.mvista.com
Subject: Re: git apply vs. renamed files index mismatch
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<48C57A92.6060608@freescale.com>
	<20080908212717.GA21338@oksana.dev.rtsoft.ru>
Date: Mon, 08 Sep 2008 17:53:41 -0700
In-Reply-To: <20080908212717.GA21338@oksana.dev.rtsoft.ru> (Anton Vorontsov's
	message of "Tue, 9 Sep 2008 01:27:17 +0400")
Message-ID: <7vej3ucf6y.fsf@gitster.siamese.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Wood <scottwood@freescale.com>, git@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov <avorontsov@ru.mvista.com> writes:

>>>  3 files changed, 201 insertions(+), 201 deletions(-)
>>>  create mode 100644 arch/powerpc/kernel/dma.c
>>>  delete mode 100644 arch/powerpc/kernel/dma_64.c
>>
>> Passing -M to git format-patch makes it much easier
>
> I always thought that posting "-M" patches to the public lists is
> discouraged since it is quite difficult to apply them via patch(1).
> Also think of non-git users...

My understanding has been that it is encouraged on the kernel mailing
list, because the rename format is far easier to review by showing the
differences that matter to reviewers, than showing a big chunk of text
deleted and another big chunk of text that is similar added elsewhere.

I won't comment on this any further; the use of it is strictly a list and
community policy issue.

> This is still possible by comparing the hashes:
> ...
> That is, if hashes match then it was pure rename.
>
> Though, too bad git {apply,am} does not produce any warnings if there
> are any hidden changes...

But I _do_ want to know what you mean by this comment.  Your statement
makes it sounds as if apply/am happily and silently accept "hidden
changes" and it is a bad thing.

Now what do you exactly mean by "any hidden changes"?  Do you mean "the
sender did not use renaming format, the patch you fed was a one that
removes a huge chunk of text from one file, and adds a similarly huge
chunk of text to another file.  The changes to these files looked similar
but was not quite the same"?  It is all there for you to review, and
especially if you prefer non-renaming format, then that is what you get.
So I do not think that is what you are complaining about.  It must be
something else --- what is it?
