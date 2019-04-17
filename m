Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7160C282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 22:08:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D234217FA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 22:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dG5IK/cF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D234217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kxFw2SZlzDqQ9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 08:08:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zytor.com
 (client-ip=198.137.202.136; helo=mail.zytor.com; envelope-from=hpa@zytor.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=zytor.com header.i=@zytor.com header.b="dG5IK/cF"; 
 dkim-atps=neutral
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kxD64v3zzDqP8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 08:07:02 +1000 (AEST)
Received: from hanvin-mobl2.amr.corp.intel.com ([134.134.139.83])
 (authenticated bits=0)
 by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x3HM6kGu4099809
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Wed, 17 Apr 2019 15:06:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x3HM6kGu4099809
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2019041745; t=1555538819;
 bh=LfcxlAKQ9/LDv9uxSiQl87QtWB8Zu4FhEOXggHSoq6o=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=dG5IK/cFWflQgUMyQkT8MDokwjwqtTOmvFH9kJeRKQwMC5U/CpUtSsEzZWfxwYQSe
 wxuVspMAoJ7Na3KvT0VP9g5oQGTeft+9uzmPDg94jVeP4w8+0MtRcBy13cRQBMmR6d
 +FHlZkikMhRVo1F7KlSNT1eEZFLKKjA57ccK5N70R9AiFG+DDDDnsROKt34qPZt6Jq
 GvOaYV9ehBJSWGieS/0qIEifGdJRLJ3NGAVTCfrAqSsR8UOr99d8Q9b70Voif/BIMu
 3X6QLzPqFiTqJSiE1sZIa1nOX0943RF8L6gOxZ12jVJghTqJB9SFc3W/Uvc8K+6aVi
 B42EwBld+eV4g==
Subject: Re: [PATCH] Linux: Define struct termios2 in <termios.h> under
 _GNU_SOURCE [BZ #10339]
To: Florian Weimer <fweimer@redhat.com>
References: <875zrnlakd.fsf@oldenburg2.str.redhat.com>
 <284e9c76-2411-b8f4-c4bc-c25c60c04cf7@linaro.org>
 <87imvker6t.fsf@oldenburg2.str.redhat.com>
 <db468a0f-4a7b-d251-601f-428885275d08@linaro.org>
 <87lg0fbr1q.fsf@oldenburg2.str.redhat.com>
 <A278227C-039B-49F4-B80D-650B785AE225@zytor.com>
 <87lg0az2xk.fsf@oldenburg2.str.redhat.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <ccdca9a0-f9b8-bee4-ecc6-57902f36ecd2@zytor.com>
Date: Wed, 17 Apr 2019 15:06:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87lg0az2xk.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: linux-api@vger.kernel.org, libc-alpha@sourceware.org,
 linuxppc-dev@lists.ozlabs.org,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/16/19 2:59 AM, Florian Weimer wrote:
> * hpa:
> 
>> Using symbol versioning doesn't really help much since the real
>> problem is that struct termios can be passed around in userspace, and
>> the interfaces between user space libraries don't have any
>> versioning. However, my POC code deals with that too by only seeing
>> BOTHER when necessary, so if the structure is extended garbage in the
>> extra fields will be ignored unless new baud rates are in use.
> 
> That still doesn't solve the problem of changing struct offsets after a
> struct field of type struct termios.
> 
>> Exporting termios2 to user space feels a bit odd at this stage as it
>> would only be usable as a fallback on old glibc. Call it
>> kernel_termios2 at least.
> 
> I'm not sure why we should do that?  The kernel calls it struct termios2
> in its UAPI headers.  If that name is not appropriate, it should be
> changed first in the UAPI headers.
> 

It should; I believe the namespace we ought to use is struct
__kernel_termios[2].

"struct termios" defined in these headers is obviously completely wrong
for userspace.

	-hpa

