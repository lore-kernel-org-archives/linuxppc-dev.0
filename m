Return-Path: <SRS0=iZn8=ST=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3CAC282DA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 22:06:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECAC3217FA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 22:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FaJh0f1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAC3217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44kxCt4bv6zDqPm
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 08:06:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zytor.com
 (client-ip=198.137.202.136; helo=mail.zytor.com; envelope-from=hpa@zytor.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=zytor.com header.i=@zytor.com header.b="FaJh0f1E"; 
 dkim-atps=neutral
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44kxB241WHzDqMN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 08:05:13 +1000 (AEST)
Received: from hanvin-mobl2.amr.corp.intel.com ([192.55.54.41])
 (authenticated bits=0)
 by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x3HM4tJB4099116
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Wed, 17 Apr 2019 15:05:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x3HM4tJB4099116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2019041745; t=1555538709;
 bh=wEkOcEehlaQ55fgLaTV1qTX5iz4LS/i0LW1PMhA2hIA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=FaJh0f1E7GtrYOYBcm7eDdUlfD1K9mOyge8WHLmkbYKCQg4+UI8C1SS2Y/iXyJJDN
 jjB/ajhjS4bBzwUZcVoVMKti1Enm8cIuFaXaMO6fq8miACjA5fq5oerrLKXRlZiqee
 DzYQ80SRzn0dGKL7a2ELWuRgjskFGeW0LGfK8Xlw2FIcnCFA7bneZ4Y9r/8xgMZqiA
 K/QOBa4klqznezp2G+AxmfsPx6i9yQWuMccT+6aObWsaOI9lBzOQ/CjOzhwDPGD/La
 uf+k0FNhNj1VuXIwxV9jgWH68CUzyMRdLI6He5fsS0I9w2//+e9du0IIhi1jXOaX7P
 MKo/UiPet04AA==
Subject: Re: [PATCH] Linux: Define struct termios2 in <termios.h> under
 _GNU_SOURCE [BZ #10339]
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Florian Weimer <fweimer@redhat.com>
References: <875zrnlakd.fsf@oldenburg2.str.redhat.com>
 <284e9c76-2411-b8f4-c4bc-c25c60c04cf7@linaro.org>
 <87imvker6t.fsf@oldenburg2.str.redhat.com>
 <db468a0f-4a7b-d251-601f-428885275d08@linaro.org>
 <87lg0fbr1q.fsf@oldenburg2.str.redhat.com>
 <A278227C-039B-49F4-B80D-650B785AE225@zytor.com>
 <bfe6744f-7326-0a06-e43c-9f88abce7032@linaro.org>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <8f05dc10-02ea-327f-f984-98b91a0b195d@zytor.com>
Date: Wed, 17 Apr 2019 15:04:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bfe6744f-7326-0a06-e43c-9f88abce7032@linaro.org>
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
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/15/19 10:22 AM, Adhemerval Zanella wrote:
>>
>> New interfaces are only necessary for the handful of architectures that don't have the speed fields *and* to space to put them in. 
> 
> Based on your WIP, it seems that both sparc and mips could be adapted.
> Do we still have glibc supported architecture that would require compat
> symbols?
> 
>>
>> Using symbol versioning doesn't really help much since the real problem is that struct termios can be passed around in userspace, and the interfaces between user space libraries don't have any versioning. However, my POC code deals with that too by only seeing BOTHER when necessary, so if the structure is extended garbage in the extra fields will be ignored unless new baud rates are in use.
> 
> Yeah, we discussed this earlier and if recall correctly it was not settled
> that all architectures would allow the use to extra space for the new
> fields. It seems the case, which makes the adaptation for termios2 even easier.
> 
> The question I have for kernel side is whether termios2 is fully compatible
> with termios, meaning that if there is conner cases we need to handle in
> userland.
> 

It depends on what you mean with "fully compatible."

Functionality-wise, the termios2 interfaces are a strict superset. There
is not, however, any guarantee that struct kernel_termios2 *contains* a
contiguous binary equivalent to struct kernel_termios (in fact, on most
architectures, it doesn't.)

>>
>> My POC code deals with Alpha as well by falling back to the old interfaces if necessary and possible, otherwise return error.
>>
>> Exporting termios2 to user space feels a bit odd at this stage as it would only be usable as a fallback on old glibc. Call it kernel_termios2 at least. ioctls using struct termios *must* be changed to kernel_termios anyway!
>>
> 
> I still prefer to avoid export it to userland and make it usable through
> default termios, as your wip does.  My understanding is new interfaces 
> should be semantic equal to current one with the only deviation that
> non-standard baudrates will handled as its values.  The only issue I 
> can foresee is if POSIX starts to export new bauds value.
> 

... which will be easy to handle: just define a Bxxxx constant with the
value equal to the baud rate.

	-hhpa


