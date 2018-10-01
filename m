Return-Path: <SRS0=DRoX=MN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98071C43143
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 23:03:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11026206B2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Oct 2018 23:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11026206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PHrp552LzF3DL
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 09:03:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=windriver.com
 (client-ip=147.11.146.13; helo=mail1.windriver.com;
 envelope-from=jason.wessel@windriver.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=windriver.com
X-Greylist: delayed 11265 seconds by postgrey-1.36 at bilbo;
 Tue, 02 Oct 2018 09:00:12 AEST
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PHmr2XJXzF31V
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 09:00:11 +1000 (AEST)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
 by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w91JqDP1001179
 (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
 Mon, 1 Oct 2018 12:52:13 -0700 (PDT)
Received: from [172.25.59.211] (172.25.59.211) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.408.0; Mon, 1 Oct 2018
 12:52:12 -0700
Subject: Re: [PATCH] kdb: use correct pointer when 'btc' calls 'btt'
To: Michael Ellerman <mpe@ellerman.id.au>, Christophe LEROY
 <christophe.leroy@c-s.fr>, Daniel Thompson <daniel.thompson@linaro.org>
References: <ff05bd36b338f4f914780176e9eba8138e1b254b.1536927765.git.christophe.leroy@c-s.fr>
 <20180916190610.vzqxwps7zqy2zc6o@holly.lan>
 <5f0e0241-b7ab-b5fa-de0e-01abdbc85770@linaro.org>
 <760ed3ff-43d9-75e5-b36c-aaa7871ffe50@c-s.fr>
 <877ej7urh3.fsf@concordia.ellerman.id.au>
 <7cf2d115-a58b-4585-37fc-7e58169a43a3@c-s.fr>
 <87zhw1srt4.fsf@concordia.ellerman.id.au>
From: Jason Wessel <jason.wessel@windriver.com>
Message-ID: <ca845d92-674b-4ca2-3535-2621972bd13b@windriver.com>
Date: Mon, 1 Oct 2018 14:52:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87zhw1srt4.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: kgdb-bugreport@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, me@tobin.cc
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 09/28/2018 07:57 AM, Michael Ellerman wrote:
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>> Le 27/09/2018 à 13:09, Michael Ellerman a écrit :
>>> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>>>> Le 26/09/2018 à 13:11, Daniel Thompson a écrit :
>>>>
>>>> The Fixes: and now your Reviewed-by: appear automatically in patchwork
>>>> (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=65715),
>>>> so I believe they'll be automatically included when Jason or someone
>>>> else takes the patch, no ?
>>>
>>> patchwork won't add the Fixes tag from the reply, it needs to be in the
>>> original mail.
>>>
>>> See:
>>>     https://github.com/getpatchwork/patchwork/issues/151
>>>
>>
>> Ok, so it accounts it and adds a '1' in the F column in the patches
>> list, but won't take it into account.
> 
> Yes. The logic that populates the columns is separate from the logic
> that scrapes the tags, which is a bug :)
> 
>> Then I'll send a v2 with revised commit text.
> 


No need.  https://git.kernel.org/pub/scm/linux/kernel/git/jwessel/kgdb.git/commit/?h=kgdb-next

Since it is a regression fix, we'll try and get it merged as soon as we can.

Cheers,
Jason.
