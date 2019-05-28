Return-Path: <SRS0=jaSx=T4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E04AC04AB6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 11:59:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D722075B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 11:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D722075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45CsnY3BB8zDqQZ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 May 2019 21:58:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=vincenzo.frascino@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 45Cslw1rZ0zDqJg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2019 21:57:30 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7D02341;
 Tue, 28 May 2019 04:57:27 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B38783F59C;
 Tue, 28 May 2019 04:57:25 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] kselftest: Extend vDSO selftest to clock_getres
To: Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20190523112116.19233-1-vincenzo.frascino@arm.com>
 <20190523112116.19233-4-vincenzo.frascino@arm.com>
 <87lfyrp0d2.fsf@concordia.ellerman.id.au>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <afb7395f-43e9-c304-2db2-349e6727b687@arm.com>
Date: Tue, 28 May 2019 12:57:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87lfyrp0d2.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Michael,

thank you for your reply.

On 28/05/2019 07:19, Michael Ellerman wrote:
> Vincenzo Frascino <vincenzo.frascino@arm.com> writes:
> 
>> The current version of the multiarch vDSO selftest verifies only
>> gettimeofday.
>>
>> Extend the vDSO selftest to clock_getres, to verify that the
>> syscall and the vDSO library function return the same information.
>>
>> The extension has been used to verify the hrtimer_resoltion fix.
> 
> This is passing for me even without patch 1 applied, shouldn't it fail
> without the fix? What am I missing?
> 

This is correct, because during the refactoring process I missed an "n" :)

if·((x.tv_sec·!=·y.tv_sec)·||·(x.tv_sec·!=·y.tv_sec))

Should be:

if·((x.tv_sec·!=·y.tv_sec)·||·(x.tv_nsec·!=·y.tv_nsec))

My mistake, I am going to fix the test and re-post v5 of this set.

Without my patch if you pass "highres=off" to the kernel (as a command line
parameter) it leads to a broken implementation of clock_getres since the value
of CLOCK_REALTIME_RES does not change at runtime.

Expected result (with highres=off):

# uname -r
5.2.0-rc2
# ./vdso_clock_getres
clock_id: CLOCK_REALTIME [FAIL]
clock_id: CLOCK_BOOTTIME [PASS]
clock_id: CLOCK_TAI [PASS]
clock_id: CLOCK_REALTIME_COARSE [PASS]
clock_id: CLOCK_MONOTONIC [FAIL]
clock_id: CLOCK_MONOTONIC_RAW [PASS]
clock_id: CLOCK_MONOTONIC_COARSE [PASS]

The reason of this behavior is that the only clocks supported by getres on
powerpc are CLOCK_REALTIME and CLOCK_MONOTONIC, the rest on the clocks use
always syscalls.

> # uname -r
> 5.2.0-rc2-gcc-8.2.0
> 
> # ./vdso_clock_getres
> clock_id: CLOCK_REALTIME [PASS]
> clock_id: CLOCK_BOOTTIME [PASS]
> clock_id: CLOCK_TAI [PASS]
> clock_id: CLOCK_REALTIME_COARSE [PASS]
> clock_id: CLOCK_MONOTONIC [PASS]
> clock_id: CLOCK_MONOTONIC_RAW [PASS]
> clock_id: CLOCK_MONOTONIC_COARSE [PASS]
> 
> cheers
> 
>> Cc: Shuah Khan <shuah@kernel.org>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> ---
>>
>> Note: This patch is independent from the others in this series, hence it
>> can be merged singularly by the kselftest maintainers.
>>
>>  tools/testing/selftests/vDSO/Makefile         |   2 +
>>  .../selftests/vDSO/vdso_clock_getres.c        | 124 ++++++++++++++++++
>>  2 files changed, 126 insertions(+)
>>  create mode 100644 tools/testing/selftests/vDSO/vdso_clock_getres.c

-- 
Regards,
Vincenzo
