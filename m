Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4A5C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 11:19:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99FF220857
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 11:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="pbM5HIXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99FF220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44997Y4Vc8zDqPl
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 22:19:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="pbM5HIXR"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44995J5VkvzDqNv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 22:17:54 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id i20so9579124pfo.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Feb 2019 03:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=UHHl8AM7Jhi///WMGmk4ybie58KH2C4i507/H9P4AV4=;
 b=pbM5HIXR+VUBsh08LFocMwTaNq5WRB8aPrEVqFlSnGDiCIqXVeqIztGPyOtW81GQif
 CaJDbo1zPkBwBsZE7Qn8TzANW/UFhMKj6eXkb0xG3vebAPaJZekgwG/BzBZSMesZN2Rr
 ls5pATdLZ0nsldnVVnPYUdshq1kwZHU1YTnEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=UHHl8AM7Jhi///WMGmk4ybie58KH2C4i507/H9P4AV4=;
 b=p2mF8fuyGUCL/jZlClBzv/1PFfqsGsyKU6cRg/vV8hSDEbizPzMaXQX93jrfl1M2WX
 /9BqLHOTty6kOc1rukuXdgSPganDBcNsf8aUt2H+dwSEPr2Rbbq3nqcrv1fseNq1zPMq
 SIQTI3uhJPBCrrMK/zYBTUP7DYkF/yKK7W8ZYgc8h+7COzpsRFt8GoH6jbAOLCTIDHy3
 fyrFHpjcXd3olpsyXaQKJv0QeUR7IbO59OUlptx/BCzr1BFaDB5s1aqNY9Jwst7n6SUY
 r7FMbwiAs8GtIh2FMUlNVNEf+r+ApJrRMeaKiEKqJBlF75G03zp9ibcE2LDb0ZUmga29
 SDdA==
X-Gm-Message-State: AHQUAubpXmnJcaJXUZkK2U0mcfZixhRTgwWycAW1dwtw0yepd02H/xPx
 1mVwuL6SBUJHUfoEcyOdzwN3BQ==
X-Google-Smtp-Source: AHgI3IbdFjOp73631g0UjM/K5GUWQCGpt8CXA4zAWeRe0XAVb+tYs17iKcud8fh21VOSGl+jJB/rrw==
X-Received: by 2002:a63:fd03:: with SMTP id d3mr7766532pgh.359.1551352671085; 
 Thu, 28 Feb 2019 03:17:51 -0800 (PST)
Received: from localhost (203-59-50-226.dyn.iinet.net.au. [203.59.50.226])
 by smtp.gmail.com with ESMTPSA id z191sm12033580pgd.45.2019.02.28.03.17.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 28 Feb 2019 03:17:50 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Mathieu Malaterre <malat@debian.org>, Jakub Drnec <jaydee@email.cz>
Subject: Re: PROBLEM: monotonic clock going backwards on ppc64
In-Reply-To: <CA+7wUswyzc5SGjjb+WS4QpopyL0qoGYj0WF1jNaTfsC5ZsMpdw@mail.gmail.com>
References: <HaC.ZfES.62bwlnvAvMP.1STMMj@seznam.cz>
 <CA+7wUswyzc5SGjjb+WS4QpopyL0qoGYj0WF1jNaTfsC5ZsMpdw@mail.gmail.com>
Date: Thu, 28 Feb 2019 22:17:46 +1100
Message-ID: <87va1417s5.fsf@dja-thinkpad.axtens.net>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mathieu Malaterre <malat@debian.org> writes:

> On Tue, Feb 26, 2019 at 9:36 PM Jakub Drnec <jaydee@email.cz> wrote:
>>
>> Hi all,
>>
>> I think I observed a potential problem, is this the correct place to report it? (CC me, not on list)
>>
>> [1.] One line summary: monotonic clock can be made to decrease on ppc64
>> [2.] Full description:
>> Setting the realtime clock can sometimes make the monotonic clock go back by over a hundred years.
>> Decreasing the realtime clock across the y2k38 threshold is one reliable way to reproduce.
>> Allegedly this can also happen just by running ntpd, I have not managed to reproduce that other
>> than booting with rtc at >2038 and then running ntp.
>
> Isn't it the expected behavior. Here is what I see for powermac:
>
> $ git show 22db552b50fa
> ...
>     This changes the logic to cast to an unsigned 32-bit number first for
>     the Macintosh time and then convert that to the Unix time, which then
>     gives us a time in the documented 1904..2040 year range. I decided not
>     to use the longer 1970..2106 range that other drivers use, for
>     consistency with the literal interpretation of the register, but that
>     could be easily changed if we decide we want to support any Mac after
>     2040.
> ...
>

My interpretation of that commit is that it relates to the kernel
reading the hardware RTC on a powermac, but this issue relates to
userspace fetching the time from the vDSO. I'm also not running on a
powermac, so my hardware should be able to deal with times > 2040...


Regards,
Daniel

>> When this happens, anything with timers (e.g. openjdk) breaks rather badly.
>>
>> [3.] Keywords: gettimeofday, ppc64, vdso
>> [4.] Kernel information
>> [4.1.] Kernel version: any (tested on 4.19)
>> [4.2.] Kernel .config file: any
>> [5.] Most recent kernel version which did not have the bug: not a regression
>> [6.] Output of Oops..: not applicable
>> [7.] Example program which triggers the problem
>> --- testcase.c
>> #include <stdio.h>
>> #include <time.h>
>> #include <stdlib.h>
>> #include <unistd.h>
>>
>> long get_time() {
>>   struct timespec tp;
>>   if (clock_gettime(CLOCK_MONOTONIC, &tp) != 0) {
>>     perror("clock_gettime failed");
>>     exit(1);
>>   }
>>   long result = tp.tv_sec + tp.tv_nsec / 1000000000;
>>   return result;
>> }
>>
>> int main() {
>>   printf("monitoring monotonic clock...\n");
>>   long last = get_time();
>>   while(1) {
>>     long now = get_time();
>>     if (now < last) {
>>       printf("clock went backwards by %ld seconds!\n",
>>         last - now);
>>     }
>>     last = now;
>>     sleep(1);
>>   }
>>   return 0;
>> }
>> ---
>> when running
>> # date -s 2040-1-1
>> # date -s 2037-1-1
>> program outputs: clock went backwards by 4294967295 seconds!
>>
>> [8.] Environment: any ppc64, currently reproducing on qemu-system-ppc64le running debian unstable
>> [X.] Other notes, patches, fixes, workarounds:
>> The problem seems to be in vDSO code in arch/powerpc/kernel/vdso64/gettimeofday.S.
>> (possibly because some values used in the calculation are only 32 bit?)
>> Slightly silly workaround:
>> nuke the "cmpwi cr1,r3,CLOCK_MONOTONIC" in __kernel_clock_gettime
>> Now it always goes through the syscall fallback which does not have the same problem.
>>
>> Regards,
>> Jakub Drnec
