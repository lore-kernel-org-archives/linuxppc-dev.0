Return-Path: <SRS0=spRZ=SR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78EAC10F12
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 15:54:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BEFF20825
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 15:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEFF20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44jY3c6jDHzDqKf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 01:54:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zytor.com
 (client-ip=198.137.202.136; helo=mail.zytor.com; envelope-from=hpa@zytor.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zytor.com
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44jY1k4cx7zDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2019 01:53:13 +1000 (AEST)
Received: from [IPv6:2607:fb90:86d7:2c0d:f984:e141:407b:6a78]
 ([IPv6:2607:fb90:86d7:2c0d:f984:e141:407b:6a78])
 (authenticated bits=0)
 by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x3FFr7ap3036194
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Mon, 15 Apr 2019 08:53:08 -0700
Date: Mon, 15 Apr 2019 08:53:02 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <87lg0fbr1q.fsf@oldenburg2.str.redhat.com>
References: <875zrnlakd.fsf@oldenburg2.str.redhat.com>
 <284e9c76-2411-b8f4-c4bc-c25c60c04cf7@linaro.org>
 <87imvker6t.fsf@oldenburg2.str.redhat.com>
 <db468a0f-4a7b-d251-601f-428885275d08@linaro.org>
 <87lg0fbr1q.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Linux: Define struct termios2 in <termios.h> under
 _GNU_SOURCE [BZ #10339]
To: Florian Weimer <fweimer@redhat.com>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>
From: hpa@zytor.com
Message-ID: <A278227C-039B-49F4-B80D-650B785AE225@zytor.com>
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

On April 12, 2019 12:50:41 AM PDT, Florian Weimer <fweimer@redhat=2Ecom> wr=
ote:
>* Adhemerval Zanella:
>
>> On 11/04/2019 08:07, Florian Weimer wrote:
>>> * Adhemerval Zanella:
>>>=20
>>>> This allows us to adjust the baud rates to non-standard values
>using termios
>>>> interfaces without to resorting to add new headers and use a
>different API
>>>> (ioctl)=2E
>>>=20
>>> How much symbol versioning will be required for this change?
>>
>> I think all interfaces that have termios as input for sparc and mips=20
>> (tcgetattr, tcsetattr, cfmakeraw, cfgetispeed, cfgetospeed,
>cfsetispeed,
>> cfsetospeed, cfsetspeed)=2E
>>
>> Alpha will also need to use termios1 for pre-4=2E20 kernels=2E
>
>So only new symbol versions there?  Hmm=2E
>
>>>> As Peter Anvin has indicated, he create a POC [1] with the
>aforementioned
>>>> new interfaces=2E  It has not been rebased against master, more
>specially against
>>>> my termios refactor to simplify the multiple architecture header
>definitions,
>>>> but I intend to use as a base=2E
>>>=20
>>> Reference [1] is still missing=2E 8-(
>>
>> Oops=2E=2E=2E it is
>https://git=2Ezytor=2Ecom/users/hpa/glibc/termbaud=2Egit/log/?h=3Dwip=2Et=
ermbaud
>
>This doesn't really illuminate things=2E  =E2=80=9CDrop explicit baud set=
ting
>interfaces in favor of cfenc|decspeed()=E2=80=9D removes the new symbol v=
ersion
>for the cf* functions=2E
>
>My gut feeling is that it's safer to add new interfaces, based on the
>actual kernel/userspace interface, rather than trying to fix up
>existing
>interfaces with symbol versioning=2E  The main reason is that code
>involving serial interfaces is difficult to test, so it will take years
>until we find the last application broken by the glibc interface bump=2E
>
>I don't feel strongly about this=2E  This came out of a request for
>enabling TCGETS2 support downstream=2E  If I can't fix this upstream, I
>will just reject that request=2E
>
>Thanks,
>Florian

New interfaces are only necessary for the handful of architectures that do=
n't have the speed fields *and* to space to put them in=2E=20

Using symbol versioning doesn't really help much since the real problem is=
 that struct termios can be passed around in userspace, and the interfaces =
between user space libraries don't have any versioning=2E However, my POC c=
ode deals with that too by only seeing BOTHER when necessary, so if the str=
ucture is extended garbage in the extra fields will be ignored unless new b=
aud rates are in use=2E

My POC code deals with Alpha as well by falling back to the old interfaces=
 if necessary and possible, otherwise return error=2E

Exporting termios2 to user space feels a bit odd at this stage as it would=
 only be usable as a fallback on old glibc=2E Call it kernel_termios2 at le=
ast=2E ioctls using struct termios *must* be changed to kernel_termios anyw=
ay!
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
