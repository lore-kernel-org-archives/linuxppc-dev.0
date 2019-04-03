Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED0CC4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 13:51:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37D72084B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 13:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a+09Q+zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37D72084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Z6tn4vXbzDqMF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 00:51:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.dk
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=axboe@kernel.dk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel-dk.20150623.gappssmtp.com
 header.i=@kernel-dk.20150623.gappssmtp.com header.b="a+09Q+zu"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Z6rh4tFJzDqKZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 00:49:35 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id 85so8372544pgc.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Apr 2019 06:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=t5ZVVI/5i5BZgbC0+BF4FpeyupPsSZBs0qT2dr3BKsI=;
 b=a+09Q+zugRlUHjkyucJBUCWf446/MQuUX5HgeGs3ZuGQQLIWjJL4mBRQrPd8Bx1buN
 pS4R4TpqP3XhVpa6S7zs10taoPdLsT7v+9IuXra/Uik1YcsijFXT7lR/UJiVHpj8asQt
 ZKI61os4qE1ceMgeeCWS8eeEqFOYcwVarDSKzOrfLlnJyc5wRdlnXGw37CR8OlhLZqnf
 yHVyoaWIHJpz8YliG/fKTjFH1niDFOpAo/QavcioqNac4ds3tqnSs5/kTVDh1j1rvHJs
 S0B+dWgq7An+aJLx8NTQYB7UoUjMFTNUGB972txZpMDJCgnpUlYul4Q6ZsTAr8wNltER
 O/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=t5ZVVI/5i5BZgbC0+BF4FpeyupPsSZBs0qT2dr3BKsI=;
 b=P5f+E034TftG/fbmqCJwuKggELQ9WrqYz6qdlOZx6pubkB8CA2MDtNusvAt7zushDk
 vIv2Zz1BIEJWgeU6jSvM/qXP8O9YVD3S+fX+s/CWzAwkZvgUiEW5H8f4ogQpc8RimaDh
 mDLE150N6lEwlX+VomOcjlx7+f2/NX8RSDmz2xh83lJH6u4IZYuB4MAgwQhILMgClWr/
 XjLoDXKfSI8yJujvn5n9A51t//RvrTezhBj4GdQ/1lLEvNEh6dpEAgwbhAa7Bvnv2llC
 IaQPOUE3bEhJFwTI6DFelm5HqfS804zjrwAiK+YvbhEznIN7V3lf+2oKbc/SzQuga2v9
 Pa7w==
X-Gm-Message-State: APjAAAWY32j4NKqTFwJjL6QhdPuRk/bsIX9YR+RzEWlGvFXX6eGgeVOR
 Hy8EJ+AnJwpP5hgqaOJw0uv0FQ==
X-Google-Smtp-Source: APXvYqzl4pp2LVq+nDJhXTBECl1hQPThxVc/ItK+ZQpXYL1XB54jwn23RYPTMUJAYmiOOJU/yQZx8A==
X-Received: by 2002:a62:2687:: with SMTP id
 m129mr25296327pfm.204.1554299372295; 
 Wed, 03 Apr 2019 06:49:32 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
 by smtp.gmail.com with ESMTPSA id g2sm22691245pfd.134.2019.04.03.06.49.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Apr 2019 06:49:30 -0700 (PDT)
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
To: Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>
References: <20190325143521.34928-1-arnd@arndb.de>
 <20190325144737.703921-1-arnd@arndb.de>
 <87tvff24a1.fsf@concordia.ellerman.id.au>
 <20190403111134.GA7159@fuggles.cambridge.arm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9d673dfd-0051-3676-653e-6376430d73dd@kernel.dk>
Date: Wed, 3 Apr 2019 07:49:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403111134.GA7159@fuggles.cambridge.arm.com>
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-mips@vger.kernel.org,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-m68k@lists.linux-m68k.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 linux-alpha@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/3/19 5:11 AM, Will Deacon wrote:
> Hi Michael,
> 
> On Wed, Apr 03, 2019 at 01:47:50PM +1100, Michael Ellerman wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>>> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
>>> index b18abb0c3dae..00f5a63c8d9a 100644
>>> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
>>> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
>>> @@ -505,3 +505,7 @@
>>>  421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
>>>  422	32	futex_time64			sys_futex			sys_futex
>>>  423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
>>> +424	common	pidfd_send_signal		sys_pidfd_send_signal
>>> +425	common	io_uring_setup			sys_io_uring_setup
>>> +426	common	io_uring_enter			sys_io_uring_enter
>>> +427	common	io_uring_register		sys_io_uring_register
>>
>> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
>>
>> Lightly tested.
>>
>> The pidfd_test selftest passes.
> 
> That reports pass for me too, although it fails to unshare the pid ns, which I
> assume is benign.
> 
>> Ran the io_uring example from fio, which prints lots of:
> 
> How did you invoke that? I had a play with the tests in:

It's t/io_uring from the fio repo:

git://git.kernel.dk/fio

and you just run it ala:

# make t/io_uring
# t/io_uring /dev/some_device

>   git://git.kernel.dk/liburing
> 
> but I quickly ran into the kernel oops below.
> 
> Will
> 
> --->8
> 
> will@autoplooker:~/liburing/test$ ./io_uring_register 
> RELIMIT_MEMLOCK: 67108864 (67108864)
> [   35.477875] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
> [   35.478969] Mem abort info:
> [   35.479296]   ESR = 0x96000004
> [   35.479785]   Exception class = DABT (current EL), IL = 32 bits
> [   35.480528]   SET = 0, FnV = 0
> [   35.480980]   EA = 0, S1PTW = 0
> [   35.481345] Data abort info:
> [   35.481680]   ISV = 0, ISS = 0x00000004
> [   35.482267]   CM = 0, WnR = 0
> [   35.482618] user pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
> [   35.483486] [0000000000000070] pgd=0000000000000000
> [   35.484041] Internal error: Oops: 96000004 [#1] PREEMPT SMP
> [   35.484788] Modules linked in:
> [   35.485311] CPU: 113 PID: 3973 Comm: io_uring_regist Not tainted 5.1.0-rc3-00012-g40b114779944 #1
> [   35.486712] Hardware name: linux,dummy-virt (DT)
> [   35.487450] pstate: 20400005 (nzCv daif +PAN -UAO)
> [   35.488228] pc : link_pwq+0x10/0x60
> [   35.488794] lr : apply_wqattrs_commit+0xe0/0x118
> [   35.489550] sp : ffff000017e2bbc0

Huh, this looks odd, it's crashing inside the wq setup.


-- 
Jens Axboe

