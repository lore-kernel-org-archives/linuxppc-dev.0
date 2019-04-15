Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE35DC10F12
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 17:24:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D3D20652
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 17:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wmzv5737"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D3D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jb2n218xzDqBs
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 03:24:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::941; helo=mail-ua1-x941.google.com;
 envelope-from=adhemerval.zanella@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wmzv5737"; 
 dkim-atps=neutral
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com
 [IPv6:2607:f8b0:4864:20::941])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jb112QL1zDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 03:22:44 +1000 (AEST)
Received: by mail-ua1-x941.google.com with SMTP id p13so5767378uaa.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 10:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=r7SO+EHafDWJ9y5P2TcKMyZLsMEqeKH3jipwkrw+sIo=;
 b=Wmzv5737VazLiSt8rpnj4VVJetenKj/Mmg1NwWBFZnRoSMLPS85yj3vkjnLWKmize0
 4ShUtMPdl7mwJvKYA/7AYdR2HSxKy16sdHCXZ7cR/3R26W7J2kEiIRywKkgEo+Abf/A+
 lj6rcyYir3SIzX7y6g+3cbcHuTUiuu1/UobLpDYHZDYUieagW39UEW8KfpER3JK7RLA5
 gA9MFqxAnuOJ1npBD36k+3i4uDS6MnoCcuJHX4AY1RUyqceh8TeB2hg0zryEXuBXxHmh
 G89jPqLWgiXNZuJK7ymi6gHgH9hA0sl0Y/aS7N50EnjPkq+1jIfk1Tjfw+7ud9MjDRzo
 9+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=r7SO+EHafDWJ9y5P2TcKMyZLsMEqeKH3jipwkrw+sIo=;
 b=ejyul+ZIYBDGNj9j4beBdWS1ulHaOXi4ioFmcUTiZbJ5TrUU3W2qru57zUhnjqh23m
 TJfidCT2ACo3Emonec9Yf8dw0pXF294X6uef1qI1bGfNkNLxI/Yipk5u6hj87QX1jizG
 moz0maCKk8QK+Grf6i0oaDKaX9V6m8931yWbfHbVHyzHx5Ud+gt1B324CfoeHjJvLaVx
 Ejamb4FWz2seenC2pN2I/paJDe9j914Xvzj2QvnrMvJGIWMC6nYTG0AnMnXje89atQaX
 w70NTwH+5skySYoA+EY1PWSU1QADDGirq46LkitPv7bMiIt8YEAjMuYZBky+oC8PMbMk
 lxww==
X-Gm-Message-State: APjAAAW1hAl9YxVdzMJ4FdcOkKjAlkOIqGj45njLZ23kCRXXo2TwvVfa
 gWBYKROJEkvDY+FFXbfvYczUqZTKiQs=
X-Google-Smtp-Source: APXvYqx8orNsjeTeAMvol/9vdYWPkk4aI1ZXrOj57MgWEyjTAZ8oaCGO4cSpWhfJHLPIaSHO6IV1fw==
X-Received: by 2002:ab0:2b98:: with SMTP id q24mr2574567uar.122.1555348960440; 
 Mon, 15 Apr 2019 10:22:40 -0700 (PDT)
Received: from [192.168.1.132] ([177.194.125.152])
 by smtp.googlemail.com with ESMTPSA id
 s195sm12348760vka.42.2019.04.15.10.22.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Apr 2019 10:22:39 -0700 (PDT)
To: hpa@zytor.com, Florian Weimer <fweimer@redhat.com>
References: <875zrnlakd.fsf@oldenburg2.str.redhat.com>
 <284e9c76-2411-b8f4-c4bc-c25c60c04cf7@linaro.org>
 <87imvker6t.fsf@oldenburg2.str.redhat.com>
 <db468a0f-4a7b-d251-601f-428885275d08@linaro.org>
 <87lg0fbr1q.fsf@oldenburg2.str.redhat.com>
 <A278227C-039B-49F4-B80D-650B785AE225@zytor.com>
From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=adhemerval.zanella@linaro.org; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] Linux: Define struct termios2 in <termios.h> under
 _GNU_SOURCE [BZ #10339]
Message-ID: <bfe6744f-7326-0a06-e43c-9f88abce7032@linaro.org>
Date: Mon, 15 Apr 2019 14:22:37 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <A278227C-039B-49F4-B80D-650B785AE225@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
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
Cc: linux-api@vger.kernel.org, libc-alpha@sourceware.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 15/04/2019 12:53, hpa@zytor.com wrote:
> On April 12, 2019 12:50:41 AM PDT, Florian Weimer <fweimer@redhat.com> wrote:
>> * Adhemerval Zanella:
>>
>>> On 11/04/2019 08:07, Florian Weimer wrote:
>>>> * Adhemerval Zanella:
>>>>
>>>>> This allows us to adjust the baud rates to non-standard values
>> using termios
>>>>> interfaces without to resorting to add new headers and use a
>> different API
>>>>> (ioctl).
>>>>
>>>> How much symbol versioning will be required for this change?
>>>
>>> I think all interfaces that have termios as input for sparc and mips 
>>> (tcgetattr, tcsetattr, cfmakeraw, cfgetispeed, cfgetospeed,
>> cfsetispeed,
>>> cfsetospeed, cfsetspeed).
>>>
>>> Alpha will also need to use termios1 for pre-4.20 kernels.
>>
>> So only new symbol versions there?  Hmm.
>>
>>>>> As Peter Anvin has indicated, he create a POC [1] with the
>> aforementioned
>>>>> new interfaces.  It has not been rebased against master, more
>> specially against
>>>>> my termios refactor to simplify the multiple architecture header
>> definitions,
>>>>> but I intend to use as a base.
>>>>
>>>> Reference [1] is still missing. 8-(
>>>
>>> Oops... it is
>> https://git.zytor.com/users/hpa/glibc/termbaud.git/log/?h=wip.termbaud
>>
>> This doesn't really illuminate things.  “Drop explicit baud setting
>> interfaces in favor of cfenc|decspeed()” removes the new symbol version
>> for the cf* functions.
>>
>> My gut feeling is that it's safer to add new interfaces, based on the
>> actual kernel/userspace interface, rather than trying to fix up
>> existing
>> interfaces with symbol versioning.  The main reason is that code
>> involving serial interfaces is difficult to test, so it will take years
>> until we find the last application broken by the glibc interface bump.
>>
>> I don't feel strongly about this.  This came out of a request for
>> enabling TCGETS2 support downstream.  If I can't fix this upstream, I
>> will just reject that request.
>>
>> Thanks,
>> Florian
> 
> New interfaces are only necessary for the handful of architectures that don't have the speed fields *and* to space to put them in. 

Based on your WIP, it seems that both sparc and mips could be adapted.
Do we still have glibc supported architecture that would require compat
symbols?

> 
> Using symbol versioning doesn't really help much since the real problem is that struct termios can be passed around in userspace, and the interfaces between user space libraries don't have any versioning. However, my POC code deals with that too by only seeing BOTHER when necessary, so if the structure is extended garbage in the extra fields will be ignored unless new baud rates are in use.

Yeah, we discussed this earlier and if recall correctly it was not settled
that all architectures would allow the use to extra space for the new
fields. It seems the case, which makes the adaptation for termios2 even easier.

The question I have for kernel side is whether termios2 is fully compatible
with termios, meaning that if there is conner cases we need to handle in
userland.

> 
> My POC code deals with Alpha as well by falling back to the old interfaces if necessary and possible, otherwise return error.
> 
> Exporting termios2 to user space feels a bit odd at this stage as it would only be usable as a fallback on old glibc. Call it kernel_termios2 at least. ioctls using struct termios *must* be changed to kernel_termios anyway!
> 

I still prefer to avoid export it to userland and make it usable through
default termios, as your wip does.  My understanding is new interfaces 
should be semantic equal to current one with the only deviation that
non-standard baudrates will handled as its values.  The only issue I 
can foresee is if POSIX starts to export new bauds value.
