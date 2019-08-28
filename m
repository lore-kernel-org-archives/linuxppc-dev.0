Return-Path: <SRS0=F8gr=WY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F36C3A5A1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 20:26:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2256920856
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 20:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=catern.com header.i=@catern.com header.b="REuwdRN9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2256920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=catern.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Jcj759DKzDrL1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Aug 2019 06:26:51 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Jcdy5Qq6zDrHn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 06:24:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=catern.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=catern.com header.i=@catern.com header.b="REuwdRN9"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 46Jcdy3vBnz8tTC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2019 06:24:06 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 46Jcdy397Vz9sDB; Thu, 29 Aug 2019 06:24:06 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=catern.com
 (client-ip=68.183.49.163; helo=venus.catern.com;
 envelope-from=sbaugh@catern.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=catern.com
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=catern.com header.i=@catern.com header.b="REuwdRN9"; 
 dkim-atps=neutral
X-Greylist: delayed 405 seconds by postgrey-1.36 at bilbo;
 Thu, 29 Aug 2019 06:24:04 AEST
Received: from venus.catern.com (venus.catern.com [68.183.49.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 46Jcdw5g9Xz9sN6
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Aug 2019 06:24:04 +1000 (AEST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.206.19.101;
 helo=localhost; envelope-from=sbaugh@catern.com; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=catern.com; s=mail;
 t=1567023434; bh=0ywMFKjMwE/uBXqaIPb34y8Q/aLLCmGU3C97TLkQvwo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=REuwdRN9P9zoh6DHSLiK1nqu3i2wNZqBJCILEt+4b0yiKxgb0XYUJwKX2wRNDyDWc
 JukKo1pvC54OaIX4CqMGz3OuGJLGPRfZ0csrkVnGcnxMd6oby8HYrRP9EeNU+sPgW7
 McVdUazYCiNEMo/74xDeTcyWeiOv6iN9cpLaK4n8=
Received: from localhost (ec2-34-206-19-101.compute-1.amazonaws.com
 [34.206.19.101])
 by venus.catern.com (Postfix) with ESMTPSA id 0564E2C2971;
 Wed, 28 Aug 2019 20:17:13 +0000 (UTC)
From: Spencer Baugh <sbaugh@catern.com>
To: Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RESEND v11 7/8] open: openat2(2) syscall
In-Reply-To: <4da231cd52880991d8a038adb8fbb2ef3d724db9.camel@kernel.org>
References: <20190820033406.29796-1-cyphar@cyphar.com>
 <20190820033406.29796-8-cyphar@cyphar.com> <854l2366zp.fsf@catern.com>
 <4da231cd52880991d8a038adb8fbb2ef3d724db9.camel@kernel.org>
Date: Wed, 28 Aug 2019 20:17:07 +0000
Message-ID: <85y2zd3v0c.fsf@catern.com>
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
Cc: linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linuxppc-dev@ozlabs.org,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Jeff Layton <jlayton@kernel.org> writes:
> On Mon, 2019-08-26 at 19:50 +0000, sbaugh@catern.com wrote:
>> Aleksa Sarai <cyphar@cyphar.com> writes:
>> > To this end, we introduce the openat2(2) syscall. It provides all of the
>> > features of openat(2) through the @how->flags argument, but also
>> > also provides a new @how->resolve argument which exposes RESOLVE_* flags
>> > that map to our new LOOKUP_* flags. It also eliminates the long-standing
>> > ugliness of variadic-open(2) by embedding it in a struct.
>> 
>> I don't like this usage of a structure in memory to pass arguments that
>> would fit in registers. This would be quite inconvenient for me as a
>> userspace developer.
>> 
>> Others have brought up issues with this: the issue of seccomp, and the
>> issue of mismatch between the userspace interface and the kernel
>> interface, are the most important for me. I want to add another,
>> admittedly somewhat niche, concern.
>> 
>> This interfaces requires a program to allocate memory (even on the
>> stack) just to pass arguments to the kernel which could be passed
>> without allocating that memory. That makes it more difficult and less
>> efficient to use this syscall in any case where memory is not so easily
>> allocatable: such as early program startup or assembly, where the stack
>> may be limited in size or not even available yet, or when injecting a
>> syscall while ptracing.
>> 
>> A struct-passing interface was needed for clone, since we ran out of
>> registers; but we have not run out of registers yet for openat, so it
>> would be nice to avoid this if we can. We can always expand later...
>> 
>
> We can't really expand later like you suggest.
>
> Suppose in a couple of years that we need to add some new argument to
> openat2 that isn't just a new flag. If all these values are passed by
> individual arguments, you can't add one later without adding yet another
> syscall.

Sure we can. This new syscall doesn't need to use all 6 available
arguments. It can enforce that the unused ones are 0. Then if we
eventually run out of flags and need to switch to pass arguments via
struct, we can just use one of the unused arguments for that purpose.

Even if we used all 6 arguments, in the worst-case scenario, the last
flag we add could change the interpretation of some other argument so it
can be used to pass a pointer to a struct.
