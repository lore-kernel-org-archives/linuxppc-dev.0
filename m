Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376C2C4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 15:54:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A76FF206BA
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 15:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TQfs1wGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76FF206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Z9cs0v7NzDqLD
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 02:54:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.dk
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=axboe@kernel.dk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel-dk.20150623.gappssmtp.com
 header.i=@kernel-dk.20150623.gappssmtp.com header.b="TQfs1wGf"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Z9YC5wlpzDqLx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 02:51:27 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so8257986plt.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Apr 2019 08:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uonhx/LPDDVDGNQW+H/tK8KtlZ2R4bxwlGmgw2LiaWg=;
 b=TQfs1wGfOLPtcaYtQZ/qhCsI6Zh64+pHvQk5JOLLhic495QORkGTgP0oF3wsqR3qCt
 iXyGlUmA2MrC6SxN7941HkzwuNTmkq/5qoLckc7EYjBEJyQqyN8dCgrpbZS6552xn/Qk
 pU4P+BbbKsFuzgT4TNxN8AmGh7Z7WIZrtHlD2lrGNCpKKMsd+i7LfRKPYC7hVkz73R1k
 EKsTy2Fs9H1tsOZZh+pdwMzJbCX4EaWOgL8zmIDn+WJg3LPItRPgPbjjjSXPrnFRyWP3
 Ak3GqA1C3Bh1VAboyveae9mijiF7n3RMZvkfkhdUI3RlSiKkQOfJME1OxCf+OPPzbIs6
 fs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uonhx/LPDDVDGNQW+H/tK8KtlZ2R4bxwlGmgw2LiaWg=;
 b=LWh70Ch10zPHVm58F1kolJqmqXRmWzSp5gdWMbeAClYVqAeREgDThHeeRtElo6jaqL
 YH1PT+k/qslcrBBvvXYefm1FiLvYa1H6i7XsbNbDla9ESgSVSMZ8Ub/dK/7iEAwUJtQo
 Z6KzRSKmsniEfs9vkr8tCijWL4+vfcviCMMTWbugkiqPXO5bDQllI7xRiNLOEjsHaaIi
 WC1q2inyYUdGckp72Vk/Off502PNHkvhnX7ZAElXSrVOFdEnbXzDhfkMRK7ckIedvXSC
 60FfFMw/AGbEU0o1IjjaA/afCfZROwOOcNUubSvBCzSaubq05ghfkJaGB3ITkmsyjKte
 y+AA==
X-Gm-Message-State: APjAAAW0/1y4HH2fR/7L2XEgtLmgQp7etJCdnSQDKPSK2nwlXTb5zFvA
 r64JFGXR6NsF9AKvZT5CCmRe5Q==
X-Google-Smtp-Source: APXvYqyuZlOgGACiMvo7zmWSlvp9AYQWk9aBM8mIhqXcJZVajXaVHi33LyqZT/7GTZs2Le+pKElXBw==
X-Received: by 2002:a17:902:681:: with SMTP id 1mr680253plh.31.1554306685930; 
 Wed, 03 Apr 2019 08:51:25 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
 by smtp.gmail.com with ESMTPSA id e4sm19098769pgd.32.2019.04.03.08.51.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Apr 2019 08:51:25 -0700 (PDT)
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
To: Will Deacon <will.deacon@arm.com>
References: <20190325143521.34928-1-arnd@arndb.de>
 <20190325144737.703921-1-arnd@arndb.de>
 <87tvff24a1.fsf@concordia.ellerman.id.au>
 <20190403111134.GA7159@fuggles.cambridge.arm.com>
 <9d673dfd-0051-3676-653e-6376430d73dd@kernel.dk>
 <20190403151932.GA16866@fuggles.cambridge.arm.com>
 <032faa2f-6317-75b6-8514-076ef1a244e8@kernel.dk>
 <20190403154902.GB16866@fuggles.cambridge.arm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <086cdf60-8973-02e6-191b-b818e6f12468@kernel.dk>
Date: Wed, 3 Apr 2019 09:51:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403154902.GB16866@fuggles.cambridge.arm.com>
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

On 4/3/19 9:49 AM, Will Deacon wrote:
> On Wed, Apr 03, 2019 at 09:39:52AM -0600, Jens Axboe wrote:
>> On 4/3/19 9:19 AM, Will Deacon wrote:
>>> On Wed, Apr 03, 2019 at 07:49:26AM -0600, Jens Axboe wrote:
>>>> On 4/3/19 5:11 AM, Will Deacon wrote:
>>>>> will@autoplooker:~/liburing/test$ ./io_uring_register 
>>>>> RELIMIT_MEMLOCK: 67108864 (67108864)
>>>>> [   35.477875] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
>>>>> [   35.478969] Mem abort info:
>>>>> [   35.479296]   ESR = 0x96000004
>>>>> [   35.479785]   Exception class = DABT (current EL), IL = 32 bits
>>>>> [   35.480528]   SET = 0, FnV = 0
>>>>> [   35.480980]   EA = 0, S1PTW = 0
>>>>> [   35.481345] Data abort info:
>>>>> [   35.481680]   ISV = 0, ISS = 0x00000004
>>>>> [   35.482267]   CM = 0, WnR = 0
>>>>> [   35.482618] user pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
>>>>> [   35.483486] [0000000000000070] pgd=0000000000000000
>>>>> [   35.484041] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>>>>> [   35.484788] Modules linked in:
>>>>> [   35.485311] CPU: 113 PID: 3973 Comm: io_uring_regist Not tainted 5.1.0-rc3-00012-g40b114779944 #1
>>>>> [   35.486712] Hardware name: linux,dummy-virt (DT)
>>>>> [   35.487450] pstate: 20400005 (nzCv daif +PAN -UAO)
>>>>> [   35.488228] pc : link_pwq+0x10/0x60
>>>>> [   35.488794] lr : apply_wqattrs_commit+0xe0/0x118
>>>>> [   35.489550] sp : ffff000017e2bbc0
>>>>
>>>> Huh, this looks odd, it's crashing inside the wq setup.
>>>
>>> Enabling KASAN seems to indicate a double-free, which may well be related.
>>
>> Does this help?
> 
> Yes, thanks for the quick patch. Feel free to add:
> 
> Reported-by: Will Deacon <will.deacon@arm.com>
> Tested-by: Will Deacon <will.deacon@arm.com>
> 
> if you spin a proper patch.

Great, thanks for reporting/testing.

-- 
Jens Axboe

