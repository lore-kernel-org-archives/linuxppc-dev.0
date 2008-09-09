Return-Path: <gitster@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id A5D11DE0C3
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 00:45:32 +1000 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: avorontsov@ru.mvista.com
Subject: Re: git apply vs. renamed files index mismatch
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<48C57A92.6060608@freescale.com>
	<20080908212717.GA21338@oksana.dev.rtsoft.ru>
	<7vej3ucf6y.fsf@gitster.siamese.dyndns.org>
	<20080909100628.GA15298@oksana.dev.rtsoft.ru>
Date: Tue, 09 Sep 2008 07:45:19 -0700
In-Reply-To: <20080909100628.GA15298@oksana.dev.rtsoft.ru> (Anton Vorontsov's
	message of "Tue, 9 Sep 2008 14:06:28 +0400")
Message-ID: <7vtzcp8jk0.fsf@gitster.siamese.dyndns.org>
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

> Now consider the following patch (modified by hand: it should say
> +foo, but I changed it to +bar).
> ...
> The "index ..." stuff says that there are no changes and it is
> pure rename, but obviously there is a change.

Ah, I see what you mean.  But in general, it is not obvious at all.

If you have the identical preimage (recorded on the LHS of the index line)
or the patch reproduces the postimage in full (i.e. "create a new file"),
you *could* notice.  It's an interesting idea from git person's point of
view (i.e. "would be fun to implement"), but I doubt it would be useful in
practice, because:

 (1) You often do not have the identically matching preimage;

 (2) More importantly, it is not unusual for people to *edit* the patch in
     their MUA (think of typofixes), after getting it out of git.

 (3) Even more importantly, even if you notice there is some difference,
     you cannot produce the postimage by only looking at the hash (this is
     obvious -- otherwise by definition you broke SHA-1), so you cannot
     tell *how* the patch was modified.

What is of much more practical value to learn here in the context of this
topic would be that after accepting such a patch that does not use -M (so
that non-git people can use patch(1) to apply), a git person can still
verify the result with "git show -M" to see what changes other than a pure
rename was made by the patch.
