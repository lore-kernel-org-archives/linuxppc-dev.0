Return-Path: <SRS0=+bYb=OD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54931C433FE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Sep 2021 19:11:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE7660C40
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Sep 2021 19:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7CE7660C40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H7bgw6ddCz3056
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Sep 2021 05:11:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=xmission.com (client-ip=166.70.13.231;
 helo=out01.mta.xmission.com; envelope-from=ebiederm@xmission.com;
 receiver=<UNKNOWN>)
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H7bgQ4B44z2yK6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Sep 2021 05:11:29 +1000 (AEST)
Received: from in01.mta.xmission.com ([166.70.13.51]:36900)
 by out01.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1mPrMP-00ElnJ-GI; Mon, 13 Sep 2021 13:11:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:56012
 helo=email.xmission.com)
 by in01.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1mPrMO-005M8J-FP; Mon, 13 Sep 2021 13:11:21 -0600
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <96d06ad9-5a9b-b8c3-3c1d-ed8837091a60@csgroup.eu> (Christophe
 Leroy's message of "Mon, 13 Sep 2021 19:19:26 +0200")
References: <1718f38859d5366f82d5bef531f255cedf537b5d.1631537060.git.christophe.leroy@csgroup.eu>
 <2b179deba4fd4ec0868cdc48a0230dfa3aa5a22f.1631537060.git.christophe.leroy@csgroup.eu>
 <87h7eopixa.fsf@disp2133> <87y280o38q.fsf@disp2133>
 <96d06ad9-5a9b-b8c3-3c1d-ed8837091a60@csgroup.eu>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date: Mon, 13 Sep 2021 14:11:11 -0500
Message-ID: <87ilz4mgts.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1mPrMO-005M8J-FP; ; ; mid=<87ilz4mgts.fsf@disp2133>; ; ;
 hst=in01.mta.xmission.com; ; ; ip=68.227.160.95; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX1+hWNysB++Rsib0OIhE7QHm4S4VuIjrA7E=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH RESEND v3 6/6] powerpc/signal: Use
 unsafe_copy_siginfo_to_user()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
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
Cc: linux-kernel@vger.kernel.org, hch@infradead.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:

> Le 13/09/2021 =C3=A0 18:21, Eric W. Biederman a =C3=A9crit=C2=A0:
>> ebiederm@xmission.com (Eric W. Biederman) writes:
>>
>>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>>
>>>> Use unsafe_copy_siginfo_to_user() in order to do the copy
>>>> within the user access block.
>>>>
>>>> On an mpc 8321 (book3s/32) the improvment is about 5% on a process
>>>> sending a signal to itself.
>>
>> If you can't make function calls from an unsafe macro there is another
>> way to handle this that doesn't require everything to be inline.
>>
>>  From a safety perspective it is probably even a better approach.
>
> Yes but that's exactly what I wanted to avoid for the native ppc32 case: =
this
> double hop means useless pressure on the cache. The siginfo_t structure i=
s 128
> bytes large, that means 8 lines of cache on powerpc 8xx.
>
> But maybe it is acceptable to do that only for the compat case. Let me th=
ink
> about it, it might be quite easy.

The places get_signal is called tend to be well known.  So I think we
are safe from a capacity standpoint.

I am not certain it makes a difference in capacity as there is a high
probability that the stack was deeper recently than it is now which
suggests the cache blocks might already be in the cache.

My sense it is worth benchmarking before optimizing out the extra copy
like that.

On the extreme side there is simply building the entire sigframe on the
stack and then just calling it copy_to_user.  As the stack cache lines
are likely to be hot, and copy_to_user is quite well optimized
there is a real possibility that it is faster to build everything
on the kernel stack, and then copy it to the user space stack.

It is also possible that I am wrong and we may want to figure out how
far up we can push the conversion to the 32bit siginfo format.

If could move the work into collect_signal we could guarantee there
would be no extra work.  That would require adjusting the sigframe
generation code on all of the architectures.

There is a lot we can do but we need benchmarking to tell if it is
worth it.

Eric





