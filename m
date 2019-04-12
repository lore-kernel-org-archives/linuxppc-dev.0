Return-Path: <SRS0=dpXp=SO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03906C10F0E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 07:52:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372A6206BA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 07:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372A6206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gVVG32T5zDqRj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 17:52:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com;
 envelope-from=fweimer@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gVSR1fFGzDqGM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 17:50:46 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1F15A356F1;
 Fri, 12 Apr 2019 07:50:44 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-63.ams2.redhat.com
 [10.36.116.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C98EC60C97;
 Fri, 12 Apr 2019 07:50:42 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Subject: Re: [PATCH] Linux: Define struct termios2 in <termios.h> under
 _GNU_SOURCE [BZ #10339]
References: <875zrnlakd.fsf@oldenburg2.str.redhat.com>
 <284e9c76-2411-b8f4-c4bc-c25c60c04cf7@linaro.org>
 <87imvker6t.fsf@oldenburg2.str.redhat.com>
 <db468a0f-4a7b-d251-601f-428885275d08@linaro.org>
Date: Fri, 12 Apr 2019 09:50:41 +0200
In-Reply-To: <db468a0f-4a7b-d251-601f-428885275d08@linaro.org> (Adhemerval
 Zanella's message of "Thu, 11 Apr 2019 09:53:30 -0300")
Message-ID: <87lg0fbr1q.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 12 Apr 2019 07:50:44 +0000 (UTC)
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
 linuxppc-dev@lists.ozlabs.org, hpa@zytor.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

* Adhemerval Zanella:

> On 11/04/2019 08:07, Florian Weimer wrote:
>> * Adhemerval Zanella:
>>=20
>>> This allows us to adjust the baud rates to non-standard values using te=
rmios
>>> interfaces without to resorting to add new headers and use a different =
API
>>> (ioctl).
>>=20
>> How much symbol versioning will be required for this change?
>
> I think all interfaces that have termios as input for sparc and mips=20
> (tcgetattr, tcsetattr, cfmakeraw, cfgetispeed, cfgetospeed, cfsetispeed,
> cfsetospeed, cfsetspeed).
>
> Alpha will also need to use termios1 for pre-4.20 kernels.

So only new symbol versions there?  Hmm.

>>> As Peter Anvin has indicated, he create a POC [1] with the aforemention=
ed
>>> new interfaces.  It has not been rebased against master, more specially=
 against
>>> my termios refactor to simplify the multiple architecture header defini=
tions,
>>> but I intend to use as a base.
>>=20
>> Reference [1] is still missing. 8-(
>
> Oops... it is https://git.zytor.com/users/hpa/glibc/termbaud.git/log/?h=
=3Dwip.termbaud

This doesn't really illuminate things.  =E2=80=9CDrop explicit baud setting
interfaces in favor of cfenc|decspeed()=E2=80=9D removes the new symbol ver=
sion
for the cf* functions.

My gut feeling is that it's safer to add new interfaces, based on the
actual kernel/userspace interface, rather than trying to fix up existing
interfaces with symbol versioning.  The main reason is that code
involving serial interfaces is difficult to test, so it will take years
until we find the last application broken by the glibc interface bump.

I don't feel strongly about this.  This came out of a request for
enabling TCGETS2 support downstream.  If I can't fix this upstream, I
will just reject that request.

Thanks,
Florian
