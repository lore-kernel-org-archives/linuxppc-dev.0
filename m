Return-Path: <SRS0=JiTK=V4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68328C433FF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Jul 2019 13:38:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7F09206A2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Jul 2019 13:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7F09206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45zDyl3psjzDqcJ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Jul 2019 23:38:23 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45zBpP1JJzzDqcQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2019 22:01:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45zBpN4yLMz9sMr;
 Wed, 31 Jul 2019 22:01:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan <ajd@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 5/5] powerpc/configs: Disable SCOM_DEBUGFS in
 powernv_defconfig
In-Reply-To: <f6c744a6-3c25-c7a0-f4bf-b3ca239068f9@linux.ibm.com>
References: <20190509051119.7694-1-ajd@linux.ibm.com>
 <20190509051119.7694-5-ajd@linux.ibm.com>
 <1557380130.bkras9z1l5.astroid@bobo.none>
 <316fb28d-b18b-c236-3063-27837b53e0d3@linux.ibm.com>
 <f6c744a6-3c25-c7a0-f4bf-b3ca239068f9@linux.ibm.com>
Date: Wed, 31 Jul 2019 22:00:59 +1000
Message-ID: <877e7yqupw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Andrew Donnellan <ajd@linux.ibm.com> writes:
> On 9/5/19 3:54 pm, Andrew Donnellan wrote:
>> On 9/5/19 3:37 pm, Nicholas Piggin wrote:
>>> Andrew Donnellan's on May 9, 2019 3:11 pm:
>>>> SCOM_DEBUGFS is really not needed for anything other than low-level
>>>> hardware debugging.
>>>>
>>>> opal-prd uses its own interface (/dev/prd) for SCOM access, so it 
>>>> doesn't
>>>> need SCOM_DEBUGFS.
>>>>
>>>> At some point in the future we'll introduce a debug config fragment 
>>>> where
>>>> this can go instead.
>>>
>>> That doesn't really explain why you want to disable it. It is useful
>>> for low level hardware debugging, I added it.
>>>
>>> obscurity^Wsecurity?
>> 
>> Mostly just a general feeling that it's not something we need to have by 
>> default. Security-wise, PRD still provides SCOM access, though we are 
>> going to look at how we can further lock that down. Shrinks the build by 
>> only a few kilobytes...
>> 
>> mpe said he's planning on adding a debug.config where we can shift stuff 
>> like this, and if/when we do that I would like to see this moved there, 
>> but perhaps this patch can wait until then. I'll let mpe decide.
>
> mpe do you have thoughts on this? I would like to see at least the rest 
> of this series merged.

I think it should be off by default, it may be true that root can
attack/break the system in many other ways, but providing unrestricted
SCOM access is a pretty big opening.

This is similar to strict /dev/mem IMO, which "everyone" agrees is a
good idea these days.

It's pretty trivial for folks doing development to turn it on in their
local trees, and I would also welcome a debug.config fragment that
enables it.

So I'll take the whole series.

cheers
