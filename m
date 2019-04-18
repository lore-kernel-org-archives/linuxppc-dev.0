Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FF6C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 14:54:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DDE217FA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 14:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="whm/Bsf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DDE217FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lMZf45v8zDqD3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Apr 2019 00:54:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zytor.com
 (client-ip=198.137.202.136; helo=mail.zytor.com; envelope-from=hpa@zytor.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
 dkim=fail reason="signature verification failed" (2048-bit key;
 unprotected) header.d=zytor.com header.i=@zytor.com header.b="whm/Bsf3"; 
 dkim-atps=neutral
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lMPs2DCNzDqQP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Apr 2019 00:46:55 +1000 (AEST)
Received: from [IPv6:2601:646:8680:2bb1:698a:5cb2:68ef:333b]
 ([IPv6:2601:646:8680:2bb1:698a:5cb2:68ef:333b])
 (authenticated bits=0)
 by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x3IEknEJ231884
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Thu, 18 Apr 2019 07:46:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x3IEknEJ231884
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
 s=2019041745; t=1555598811;
 bh=r9+iy1X0/JfCvyk9JDlNHpuqq13sZD05WYWod0pg+KQ=;
 h=Date:In-Reply-To:References:Subject:To:CC:From:From;
 b=whm/Bsf3NFOVjIwUaMedKTHc37bafr4Q4wC+HE6/pZ5UoHYjxqtWvbKpOvR29J33R
 58nxVvkxAvVfekMjlADYu90OKqLtR7dqXQjYMtB/FFqVEe+6Qm55HFvG+SetkLe6+v
 u6zOJSFbV+oX8m2nJjIHwZG6ZqsVF074l8fNpXdwbnI5FT1pJ6wRUt0Tinh6W0xzw+
 jJLfLJm4ZpgZNkVr4t/EgmC2kbBbHQocdLxkE97f1UXmzJf/Q5uqNClvDIMu0F1GwQ
 ZXW4iHLEjP3JmTHOBUyjBiQaEqe2YYH9clWrIctyuZVSPn+f2IXlXDMIhkNPRrPSAG
 +JhBHXmsCWcAA==
Date: Thu, 18 Apr 2019 07:46:39 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <4ae23f8e-c5e5-2d11-8508-82e5dd4c1e2b@linaro.org>
References: <875zrnlakd.fsf@oldenburg2.str.redhat.com>
 <284e9c76-2411-b8f4-c4bc-c25c60c04cf7@linaro.org>
 <87imvker6t.fsf@oldenburg2.str.redhat.com>
 <db468a0f-4a7b-d251-601f-428885275d08@linaro.org>
 <87lg0fbr1q.fsf@oldenburg2.str.redhat.com>
 <A278227C-039B-49F4-B80D-650B785AE225@zytor.com>
 <bfe6744f-7326-0a06-e43c-9f88abce7032@linaro.org>
 <8f05dc10-02ea-327f-f984-98b91a0b195d@zytor.com>
 <4ae23f8e-c5e5-2d11-8508-82e5dd4c1e2b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Linux: Define struct termios2 in <termios.h> under
 _GNU_SOURCE [BZ #10339]
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 Florian Weimer <fweimer@redhat.com>
From: hpa@zytor.com
Message-ID: <50A91072-AEEB-4A05-BF7C-41086B17A4F9@zytor.com>
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

On April 18, 2019 4:09:07 AM PDT, Adhemerval Zanella <adhemerval=2Ezanella@=
linaro=2Eorg> wrote:
>
>
>On 17/04/2019 19:04, H=2E Peter Anvin wrote:
>> On 4/15/19 10:22 AM, Adhemerval Zanella wrote:
>>>>
>>>> New interfaces are only necessary for the handful of architectures
>that don't have the speed fields *and* to space to put them in=2E=20
>>>
>>> Based on your WIP, it seems that both sparc and mips could be
>adapted=2E
>>> Do we still have glibc supported architecture that would require
>compat
>>> symbols?
>>>
>>>>
>>>> Using symbol versioning doesn't really help much since the real
>problem is that struct termios can be passed around in userspace, and
>the interfaces between user space libraries don't have any versioning=2E
>However, my POC code deals with that too by only seeing BOTHER when
>necessary, so if the structure is extended garbage in the extra fields
>will be ignored unless new baud rates are in use=2E
>>>
>>> Yeah, we discussed this earlier and if recall correctly it was not
>settled
>>> that all architectures would allow the use to extra space for the
>new
>>> fields=2E It seems the case, which makes the adaptation for termios2
>even easier=2E
>>>
>>> The question I have for kernel side is whether termios2 is fully
>compatible
>>> with termios, meaning that if there is conner cases we need to
>handle in
>>> userland=2E
>>>
>>=20
>> It depends on what you mean with "fully compatible=2E"
>>=20
>> Functionality-wise, the termios2 interfaces are a strict superset=2E
>There
>> is not, however, any guarantee that struct kernel_termios2 *contains*
>a
>> contiguous binary equivalent to struct kernel_termios (in fact, on
>most
>> architectures, it doesn't=2E)
>
>I mean that we can fully implement termios1 using termios2 by adjusting
>the termios struct in syscall wrappers=2E  If it is a superset I think it
>is fine=2E
>
>>=20
>>>>
>>>> My POC code deals with Alpha as well by falling back to the old
>interfaces if necessary and possible, otherwise return error=2E
>>>>
>>>> Exporting termios2 to user space feels a bit odd at this stage as
>it would only be usable as a fallback on old glibc=2E Call it
>kernel_termios2 at least=2E ioctls using struct termios *must* be changed
>to kernel_termios anyway!
>>>>
>>>
>>> I still prefer to avoid export it to userland and make it usable
>through
>>> default termios, as your wip does=2E  My understanding is new
>interfaces=20
>>> should be semantic equal to current one with the only deviation that
>>> non-standard baudrates will handled as its values=2E  The only issue I
>
>>> can foresee is if POSIX starts to export new bauds value=2E
>>>
>>=20
>> =2E=2E=2E which will be easy to handle: just define a Bxxxx constant wi=
th
>the
>> value equal to the baud rate=2E
>>=20
>> 	-hhpa
>
>Right=2E

termio, termios1 and termios2 are kernel ioctl interfaces =2E=2E=2E there =
are no wrappers; it is an ioctl=2E

The glibc termios is different from all of these, and already is a wrapper=
 around the kernel-provided ioctls=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
