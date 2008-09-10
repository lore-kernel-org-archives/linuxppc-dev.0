Return-Path: <gitster@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id E0A05DDF16
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 13:38:57 +1000 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: avorontsov@ru.mvista.com
Subject: Re: git apply vs. renamed files index mismatch
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<48C57A92.6060608@freescale.com>
	<20080908212717.GA21338@oksana.dev.rtsoft.ru>
	<7vej3ucf6y.fsf@gitster.siamese.dyndns.org>
	<20080909100628.GA15298@oksana.dev.rtsoft.ru>
	<7vtzcp8jk0.fsf@gitster.siamese.dyndns.org>
	<20080909151446.GA10395@oksana.dev.rtsoft.ru>
Date: Tue, 09 Sep 2008 20:31:01 -0700
In-Reply-To: <20080909151446.GA10395@oksana.dev.rtsoft.ru> (Anton Vorontsov's
	message of "Tue, 9 Sep 2008 19:14:46 +0400")
Message-ID: <7v1vzs1xu2.fsf@gitster.siamese.dyndns.org>
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

> On Tue, Sep 09, 2008 at 07:45:19AM -0700, Junio C Hamano wrote:
> ...
>> ...  It's an interesting idea from git person's point of
>> view (i.e. "would be fun to implement"), but I doubt it would be useful in
>> practice, because:
>> 
>>  (1) You often do not have the identically matching preimage;
>> 
>>  (2) More importantly, it is not unusual for people to *edit* the patch in
>>      their MUA (think of typofixes), after getting it out of git.
>
> Not for rename patches...

a. Why not?  Even if your patch is (totally uninteresting) pure rename, it
   is natural to review the patch before you send out, and it also is
   natural to get tempted to fix typoes, just for a straight normal patch.

b. If you can expect good behaviour out of people, by declaring "Not for
   rename patches" as your guarantee, what's the point of this discussion?

> As for implementing, isn't this as simple as this pseudo code:
>
> if (index_deleted_file == index_new_file)
> 	if (deleted_file != new_file)
> 		printk("warning\n");
>
> In the git-apply?

Implementation is easy (I said "would be fun to code", didn't I? --- by the
way, how did you match "index_deleted_file" with "index_new_file"?).

My point was that it would not be reliable enough to be useful in
practice.
