Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39ADC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 07:07:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC01621850
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 07:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC01621850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4493XC4CHNzDqNR
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 18:07:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.210.68; helo=mail-ot1-f68.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4493Sn5ZXjzDqJQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 18:04:24 +1100 (AEDT)
Received: by mail-ot1-f68.google.com with SMTP id w26so3436650otp.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 23:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g1aPq4ujpFdZ3OURDUeUzpDdOX6lcxLFi+s4im6nHGc=;
 b=J3fbxPP3kFmPbdVsvWN1H3JqntCUmfdK5Y27KZ4RrdCAMu3PRlsvGaBjAe4f6CfBfL
 vjGUbwvdR21tAIPUEuRpBFGkk29jI41WBPOQwYlPpXM21VRM0f28A6HgCh8eWex3Odv6
 kW8Ky3czptNMQYqHqa3hMk9Bky8/GqguzGptNXl/A5eJ9oA7iCSJEzbbfhgRA+DKmC+g
 5+xKyGwxRWb4hA0uVVNnjP2wrln+WEpz00yaV3D9WLEXIUb2Bv6nPVwb58An/KSsbO/6
 8nvCfKcD7xgY3aawsulmFrVnA+l+pZ4nuZVrkf32anDooWlcCG95oye+k6OqqoAhmdTI
 Uc6Q==
X-Gm-Message-State: AHQUAuYE5GKx7NtxsegOdvg9c3BGSbObjjyinOl8BLTpLIs7JQK0qbD1
 iEREmFBBv5UfcciAl5vn6db4ONKlrX82yeF7i2vM85aQ
X-Google-Smtp-Source: AHgI3IZJvjbUkZqQ1if/1cscrYDT7Wu2NHULpVFlWqqa5Tgr0iCPCEjSjfcMQnDPLdQZ+YXGAKpdL9QiYrw8PCXrLlM=
X-Received: by 2002:a05:6830:105a:: with SMTP id
 b26mr4982257otp.320.1551337462243; 
 Wed, 27 Feb 2019 23:04:22 -0800 (PST)
MIME-Version: 1.0
References: <HaC.ZfES.62bwlnvAvMP.1STMMj@seznam.cz>
In-Reply-To: <HaC.ZfES.62bwlnvAvMP.1STMMj@seznam.cz>
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 28 Feb 2019 08:04:10 +0100
Message-ID: <CA+7wUswyzc5SGjjb+WS4QpopyL0qoGYj0WF1jNaTfsC5ZsMpdw@mail.gmail.com>
Subject: Re: PROBLEM: monotonic clock going backwards on ppc64
To: Jakub Drnec <jaydee@email.cz>
Content-Type: text/plain; charset="UTF-8"
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 26, 2019 at 9:36 PM Jakub Drnec <jaydee@email.cz> wrote:
>
> Hi all,
>
> I think I observed a potential problem, is this the correct place to report it? (CC me, not on list)
>
> [1.] One line summary: monotonic clock can be made to decrease on ppc64
> [2.] Full description:
> Setting the realtime clock can sometimes make the monotonic clock go back by over a hundred years.
> Decreasing the realtime clock across the y2k38 threshold is one reliable way to reproduce.
> Allegedly this can also happen just by running ntpd, I have not managed to reproduce that other
> than booting with rtc at >2038 and then running ntp.

Isn't it the expected behavior. Here is what I see for powermac:

$ git show 22db552b50fa
...
    This changes the logic to cast to an unsigned 32-bit number first for
    the Macintosh time and then convert that to the Unix time, which then
    gives us a time in the documented 1904..2040 year range. I decided not
    to use the longer 1970..2106 range that other drivers use, for
    consistency with the literal interpretation of the register, but that
    could be easily changed if we decide we want to support any Mac after
    2040.
...

> When this happens, anything with timers (e.g. openjdk) breaks rather badly.
>
> [3.] Keywords: gettimeofday, ppc64, vdso
> [4.] Kernel information
> [4.1.] Kernel version: any (tested on 4.19)
> [4.2.] Kernel .config file: any
> [5.] Most recent kernel version which did not have the bug: not a regression
> [6.] Output of Oops..: not applicable
> [7.] Example program which triggers the problem
> --- testcase.c
> #include <stdio.h>
> #include <time.h>
> #include <stdlib.h>
> #include <unistd.h>
>
> long get_time() {
>   struct timespec tp;
>   if (clock_gettime(CLOCK_MONOTONIC, &tp) != 0) {
>     perror("clock_gettime failed");
>     exit(1);
>   }
>   long result = tp.tv_sec + tp.tv_nsec / 1000000000;
>   return result;
> }
>
> int main() {
>   printf("monitoring monotonic clock...\n");
>   long last = get_time();
>   while(1) {
>     long now = get_time();
>     if (now < last) {
>       printf("clock went backwards by %ld seconds!\n",
>         last - now);
>     }
>     last = now;
>     sleep(1);
>   }
>   return 0;
> }
> ---
> when running
> # date -s 2040-1-1
> # date -s 2037-1-1
> program outputs: clock went backwards by 4294967295 seconds!
>
> [8.] Environment: any ppc64, currently reproducing on qemu-system-ppc64le running debian unstable
> [X.] Other notes, patches, fixes, workarounds:
> The problem seems to be in vDSO code in arch/powerpc/kernel/vdso64/gettimeofday.S.
> (possibly because some values used in the calculation are only 32 bit?)
> Slightly silly workaround:
> nuke the "cmpwi cr1,r3,CLOCK_MONOTONIC" in __kernel_clock_gettime
> Now it always goes through the syscall fallback which does not have the same problem.
>
> Regards,
> Jakub Drnec
