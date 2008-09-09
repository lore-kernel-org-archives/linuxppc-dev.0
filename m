Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6E5BBDE00F
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 01:14:49 +1000 (EST)
Date: Tue, 9 Sep 2008 19:14:46 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Junio C Hamano <gitster@pobox.com>
Subject: Re: git apply vs. renamed files index mismatch
Message-ID: <20080909151446.GA10395@oksana.dev.rtsoft.ru>
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<48C57A92.6060608@freescale.com>
	<20080908212717.GA21338@oksana.dev.rtsoft.ru>
	<7vej3ucf6y.fsf@gitster.siamese.dyndns.org>
	<20080909100628.GA15298@oksana.dev.rtsoft.ru>
	<7vtzcp8jk0.fsf@gitster.siamese.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <7vtzcp8jk0.fsf@gitster.siamese.dyndns.org>
Cc: Scott Wood <scottwood@freescale.com>, git@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 09, 2008 at 07:45:19AM -0700, Junio C Hamano wrote:
> Anton Vorontsov <avorontsov@ru.mvista.com> writes:
> 
> > Now consider the following patch (modified by hand: it should say
> > +foo, but I changed it to +bar).
> > ...
> > The "index ..." stuff says that there are no changes and it is
> > pure rename, but obviously there is a change.
> 
> Ah, I see what you mean.  But in general, it is not obvious at all.
> 
> If you have the identical preimage (recorded on the LHS of the index line)
> or the patch reproduces the postimage in full (i.e. "create a new file"),
> you *could* notice.  It's an interesting idea from git person's point of
> view (i.e. "would be fun to implement"), but I doubt it would be useful in
> practice, because:
> 
>  (1) You often do not have the identically matching preimage;
> 
>  (2) More importantly, it is not unusual for people to *edit* the patch in
>      their MUA (think of typofixes), after getting it out of git.

Not for rename patches...

>  (3) Even more importantly, even if you notice there is some difference,

Just noticing that there is a difference is enough.

As for implementing, isn't this as simple as this pseudo code:

if (index_deleted_file == index_new_file)
	if (deleted_file != new_file)
		printk("warning\n");

In the git-apply?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
