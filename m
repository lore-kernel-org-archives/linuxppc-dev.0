Return-Path: <SRS0=psBJ=MK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14731C43382
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 13:00:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8584021547
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 13:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8584021547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MBc251XSzF3HX
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 23:00:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MBXn4sfRzF3Fj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 22:57:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42MBXl62q9z9s1x;
 Fri, 28 Sep 2018 22:57:27 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] kdb: use correct pointer when 'btc' calls 'btt'
In-Reply-To: <7cf2d115-a58b-4585-37fc-7e58169a43a3@c-s.fr>
References: <ff05bd36b338f4f914780176e9eba8138e1b254b.1536927765.git.christophe.leroy@c-s.fr>
 <20180916190610.vzqxwps7zqy2zc6o@holly.lan>
 <5f0e0241-b7ab-b5fa-de0e-01abdbc85770@linaro.org>
 <760ed3ff-43d9-75e5-b36c-aaa7871ffe50@c-s.fr>
 <877ej7urh3.fsf@concordia.ellerman.id.au>
 <7cf2d115-a58b-4585-37fc-7e58169a43a3@c-s.fr>
Date: Fri, 28 Sep 2018 22:57:27 +1000
Message-ID: <87zhw1srt4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Jason Wessel <jason.wessel@windriver.com>,
 linuxppc-dev@lists.ozlabs.org, me@tobin.cc
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe LEROY <christophe.leroy@c-s.fr> writes:
> Le 27/09/2018 =C3=A0 13:09, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>>> Le 26/09/2018 =C3=A0 13:11, Daniel Thompson a =C3=A9crit=C2=A0:
>>>> On 16/09/2018 20:06, Daniel Thompson wrote:
>>>>> On Fri, Sep 14, 2018 at 12:35:44PM +0000, Christophe Leroy wrote:
>>>>>> On a powerpc 8xx, 'btc' fails as follows:
>>>>>> Entering kdb (current=3D0x(ptrval), pid 282) due to Keyboard Entry
>> ...
>>>>>>
>>>>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>>>>> Cc: <stable@vger.kernel.org> # 4.15+
>>>>>
>>>>> Would a Fixes: be better here?
>>>>> Fixes: ad67b74d2469d9b82 ("printk: hash addresses printed with %p")
>>>>
>>>> Christophe, When you add the Fixes: could you also add my
>>>>
>>>> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>>>
>>> Ok, thanks for the review, but do I have to do anything really ?
>>>
>>> The Fixes: and now your Reviewed-by: appear automatically in patchwork
>>> (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D65715=
),
>>> so I believe they'll be automatically included when Jason or someone
>>> else takes the patch, no ?
>>=20
>> patchwork won't add the Fixes tag from the reply, it needs to be in the
>> original mail.
>>=20
>> See:
>>    https://github.com/getpatchwork/patchwork/issues/151
>>=20
>
> Ok, so it accounts it and adds a '1' in the F column in the patches=20
> list, but won't take it into account.

Yes. The logic that populates the columns is separate from the logic
that scrapes the tags, which is a bug :)

> Then I'll send a v2 with revised commit text.

Thanks.

cheers
