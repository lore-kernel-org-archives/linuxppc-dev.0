Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C8BC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 13:20:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394FC20823
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 13:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394FC20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TBZT4tHQzDqKL
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 00:20:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=molgen.mpg.de
 (client-ip=141.14.17.11; helo=mx1.molgen.mpg.de;
 envelope-from=pmenzel@molgen.mpg.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TBVs0W0vzDqHS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 00:17:06 +1100 (AEDT)
Received: from [172.18.205.202] (unknown [46.183.103.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id A0DFE604E3A59;
 Tue, 26 Mar 2019 14:17:02 +0100 (CET)
Subject: Re: Reading `/sys/kernel/debug/kmemleak` takes 3 s and content not
 shown
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <88e651e2-d876-376e-81fa-eab0729ebb47@molgen.mpg.de>
 <f18fb509-bee1-e411-3761-bd28a0d8aab7@molgen.mpg.de>
 <ad2278fd-ea56-d715-7efb-c4e0adb7314e@c-s.fr>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <33ad8e80-4275-d5bf-9b6a-052dd8afe7ef@molgen.mpg.de>
Date: Tue, 26 Mar 2019 14:17:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <ad2278fd-ea56-d715-7efb-c4e0adb7314e@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Dear Christophe,


On 26.03.19 13:55, Christophe Leroy wrote:

> Le 26/03/2019 à 13:49, Paul Menzel a écrit :

>> On 19.02.19 10:44, Paul Menzel wrote:
>>
>>> On a the IBM S822LC (8335-GTA) with Ubuntu 18.10, and Linux 5.0-rc5+
>>> accessing `/sys/kernel/debug/kmemleak` takes a long time. According to
>>> strace it takes three seconds.
>>>
>>> $ dmesg | grep leak
>>> [    4.407957] kmemleak: Kernel memory leak detector initialized
>>> [    4.407959] kmemleak: Automatic memory scanning thread started
>>> [745989.625624] kmemleak: 1 new suspected memory leaks (see 
>>> /sys/kernel/debug/kmemleak)
>>> [1002619.951902] kmemleak: 1 new suspected memory leaks (see 
>>> /sys/kernel/debug/kmemleak)
>>> ```
>>>
>>> Unfortunately, the leaks supposedly stored in that file are not shown
>>> either.
>>
>> The problem is still present with Linux 5.0. Do you have an idea, how 
>> to fix this?
> 
> Have you identified a previous version that works properly?

It seems to have worked with Linux 4.18-rc4+ [1].

> If so, have you been able to bisect the problem?

No, sorry, I have not. I do not have resources for this.


Kind regards,

Paul


[1]: https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-July/175658.html
