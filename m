Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC327C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 17:44:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A40720863
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 17:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="u1wRLb9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A40720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44P0mF6VrlzDqJS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 04:44:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="u1wRLb9H"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44P0kT4StRzDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 04:42:40 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44P0kL5g6yz9v10Q;
 Tue, 19 Mar 2019 18:42:34 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=u1wRLb9H; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id dNphlek3-oaw; Tue, 19 Mar 2019 18:42:34 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44P0kL4GCRz9v10P;
 Tue, 19 Mar 2019 18:42:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553017354; bh=L7wBAoFAfqc6dtDDwnUwlXYwqtLqOQSwU/p/GJfqjGQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=u1wRLb9HLL+kF3x+gcrRXlK3QoZ9pk2iXi2ACEoL6ZPOIp9smFXJUwDfrNIGmh3hh
 +A0LKt4CvY07ErfNwrdmbrkS+A6IQyrh8gy6i2FznDiRSnt0hQBi537vTkZIRfwhjA
 /L7Bo5NG86pwepoiWgQ/JaogT9DDNWeZp/8RBJM0=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 447FA8B8F5;
 Tue, 19 Mar 2019 18:42:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 5AsaCnr8bnIv; Tue, 19 Mar 2019 18:42:36 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A47238B8ED;
 Tue, 19 Mar 2019 18:42:35 +0100 (CET)
Subject: Re: [PULL REQUEST] powerpc generic command line
To: Daniel Walker <danielwa@cisco.com>, Michael Ellerman <mpe@ellerman.id.au>
References: <1551469472-53043-1-git-send-email-danielwa@cisco.com>
 <878sxb7jck.fsf@concordia.ellerman.id.au>
 <20190319153842.vgrm5dc7wwc4u44l@zorba>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <3739e843-0fe4-1295-bd9b-e4a6df614147@c-s.fr>
Date: Tue, 19 Mar 2019 18:42:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190319153842.vgrm5dc7wwc4u44l@zorba>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
Cc: linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Daniel,

Le 19/03/2019 à 16:38, Daniel Walker a écrit :
> On Tue, Mar 19, 2019 at 12:18:03PM +1100, Michael Ellerman wrote:
>> Hi Daniel,
>>
>> Daniel Walker <danielwa@cisco.com> writes:
>>> Here are the generic command line changes for powerpc.
>>>
>>> These changes have been in linux-next for two cycles, with few problems reported.
>>> It's also been used at Cisco Systems, Inc. in production products for many many
>>> years with no problems.
>>>
>>> Please pull these changes.
>>
>> Sorry I didn't reply to this earlier, have been busy with merge window
>> bugs and so on.
>>
>> As I imagine you noticed, I didn't pull this. There are a few reasons.
>>
>> Firstly you sent it a bit late, about a day before the 5.0 release, and
>> at 6am Saturday my time :) In future if you want me to merge something
>> please send a pull at least the ~Wednesday before the release.
>    
> Ok .. It was Friday morning my time.
> 
>> Secondly I had no idea this code was even in linux-next. I'm not sure if
>> I was Cc'ed at some point when you added it, if so sorry I missed it,
>> but I get lots of email. If you're going to add changes to arch/powerpc
>> in your next tree I'd appreciate some notice, or preferably an explicit
>> ack.
>   
> Can I have an ack now ? Since your looking at it. Do you think this has no use,
> certainly Cisco has use for it. It's still in linux-next as of now.
> 
>> The main reason I didn't merge it is that it's adding a bunch of code
>> outside of arch/powerpc, into files which I'm not the maintainer for,
>> and the patches doing so have no acks or reviews from anyone.
> 
> With the exception of the Kconfig the header file is brand new, so I'm not sure
> who would ack that. From a maintainer perspective I think you could add new
> files without issues from other maintainers.
> 
>> It's also adding a generic implementation with no indication that any
>> other arches are willing/able to use the generic implementation, which
>> begs the question whether it will actually used.
>   
> It would have been used by powerpc ;) I've gotten feedback in the past from
> Ralf Baechle who thought this was useful, however that was years ago when
> this was first submitted and the code around this area in mips has changed and
> it would require a fair amount of new work to function properly on mips.
> 
> Also , no other platforms need to use this. Powerpc could be the only user of
> it. This isn't really a question of a new exciting implementation of
> something. This is really simple, it's just consolidation across architectures.
> The implementation is vanilla, non-exciting stuff.
> 
>> I appreciate it's hard to get these sort of cross architecture changes
>> into mainline, but I don't think this is the way to do it.
>>
>> I'd suggest you post a patch series to linux-arch with the generic
>> changes and as many architecture conversions as you can manage, then get
>> some review/acks for the generic changes and chase arch maintainers for
>> some acks.
>   
> I didn't post to linux-arch , but the code has been around for years, submitted
> multiple times with more architectures than powerpc. It was scaled down to just
> powerpc to simplify it's submission.
> 
> It's really a simple set of changes, I don't think it needs as much thought as
> other cross architecture changes.
> 
>> I realise you have posted the series before, it may require some
>> persistence. There were also quite a few comments from Christophe, so
>> replying to those would be a good place to start.
>   
> I've looked at his comments, but I think he was more worried about conflicts with
> his debugging enablement, not something to stop a pull request.

Well, that's what I started with, but at the end my main worry has been 
that you bring a non exciting set of complicated macros and code to 
replace simple code, and you break something out of generic OF code to a 
new brand new generic one, instead of updating the existing generic OF code.

I like the idea behind your series very much, but I don't like too much 
the way it is proposed to be implemented. If you give me one week or 
two, I will come with a lighter proposal that should achieve the same goal.

Christophe

> 
>>> The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:
>>>
>>>    Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)
>>>
>>> are available in the git repository at:
>>>
>>>    https://github.com/daniel-walker/cisco-linux.git for-powerpc
>>>
>>> for you to fetch changes up to 5d4514a9c291ecf19b0626695161673d35e5d549:
>>>
>>>    powerpc: convert config files to generic cmdline (2018-11-16 07:32:26 -0800)
>>>
>>> ----------------------------------------------------------------
>>> Daniel Walker (3):
>>>        add generic builtin command line
>>>        powerpc: convert to generic builtin command line
>>>        powerpc: convert config files to generic cmdline
>>>
>>>   arch/powerpc/Kconfig                          | 23 +--------
>>>   arch/powerpc/configs/44x/fsp2_defconfig       | 29 ++++++-----
>>>   arch/powerpc/configs/44x/iss476-smp_defconfig | 24 ++++-----
>>>   arch/powerpc/configs/44x/warp_defconfig       | 12 ++---
>>>   arch/powerpc/configs/holly_defconfig          | 12 ++---
>>>   arch/powerpc/configs/mvme5100_defconfig       | 25 +++++-----
>>>   arch/powerpc/configs/skiroot_defconfig        | 48 +++++++++---------
>>>   arch/powerpc/configs/storcenter_defconfig     | 15 +++---
>>
>> Also if you're updating defconfigs please don't include any unrelated
>> changes. Trimming the defconfigs can silently drop symbols and break
>> people's setups so needs to be done carefully.
>   
>> It's safer to just sed the defconfig files directly, rather than running
>> savedefconfig on them.
>   
> Ok.
> 
> Daniel
> 
