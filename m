Return-Path: <SRS0=OBm5=SH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA92C4360F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 15:20:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7151B2175B
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Apr 2019 15:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pY85clPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7151B2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44bNly0LkmzDqC9
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Apr 2019 02:19:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="pY85clPB"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44bNk5514kzDqMH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2019 02:18:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f5InVECkpzfDdwOHUIdyA52ygP74sSmnoTjO0c8Hu3A=; b=pY85clPBLoqgi9er+9w3Eontg
 sgKpBI2XTkWA52UIum8oiq2vhAXh/GzOEDUZ7lAwuYQJZm5UxYO5qlYLvg+GEMjVQZEukEWFaXUOk
 WC3qCCxxY/T3EvTlUlggWm17WwJ5nNG5ymDAsphoy/1xf53ouFUW7I/xBhpnUeUq+oPtBT0c1xi3f
 JldtkN3EGcPpYBFA0Z0H9Y7q/HB8LTzqFueACJWzazwifswULHea9PGTwsJ6NRxWtlRAe/tTRi5Al
 6YRhJriHfFn/j2TXectKe4VNHjC+xBnEz9xoWaQeMGRCzB+gKrgkpYL69Pb+F7ytICoAu+ja2KKPC
 YX7QsAJ2Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16]
 helo=midway.dunlab)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hCQbd-000474-IY; Fri, 05 Apr 2019 15:18:13 +0000
Subject: Re: [PATCH RFC 2/5] x86/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
To: Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <78c63cb08f36f55407f534d49cc2543079e44dbb.1554396090.git.jpoimboe@redhat.com>
 <20190405135712.GF23348@zn.tnic>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5ccc7515-33e6-b726-833e-9553ab0f4c6a@infradead.org>
Date: Fri, 5 Apr 2019 08:18:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190405135712.GF23348@zn.tnic>
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
Cc: Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org,
 x86@kernel.org, Will Deacon <will.deacon@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <longman@redhat.com>,
 linux-arch@vger.kernel.org, Jon Masters <jcm@redhat.com>,
 Jiri Kosina <jikos@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tyler Hicks <tyhicks@canonical.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 4/5/19 6:57 AM, Borislav Petkov wrote:
> On Thu, Apr 04, 2019 at 11:44:12AM -0500, Josh Poimboeuf wrote:
>> Configure x86 runtime CPU speculation bug mitigations in accordance with
>> the 'cpu_spec_mitigations=' cmdline options.  This affects Meltdown,
>> Spectre v2, Speculative Store Bypass, and L1TF.
>>
>> The default behavior is unchanged.
>>
>> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
>> ---
>>  .../admin-guide/kernel-parameters.txt         | 15 +++++++++
>>  arch/x86/include/asm/processor.h              |  1 +
>>  arch/x86/kernel/cpu/bugs.c                    | 32 ++++++++++++++++---
>>  arch/x86/kvm/vmx/vmx.c                        |  2 ++
>>  arch/x86/mm/pti.c                             |  4 ++-
>>  5 files changed, 49 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index ac42e510bd6e..29dc03971630 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -2552,6 +2552,11 @@
>>  
>>  			off
>>  				Disable all speculative CPU mitigations.
>> +				Equivalent to: nopti [x86]
>> +					       nospectre_v2 [x86]
>> +					       spectre_v2_user=off [x86]
>> +					       spec_store_bypass_disable=off [x86]
>> +					       l1tf=off [x86]
>>  
>>  			auto (default)
>>  				Mitigate all speculative CPU vulnerabilities,
>> @@ -2560,12 +2565,22 @@
>>  				surprised by SMT getting disabled across kernel
>>  				upgrades, or who have other ways of avoiding
>>  				SMT-based attacks.
>> +				Equivalent to: pti=auto [x86]
>> +					       spectre_v2=auto [x86]
>> +					       spectre_v2_user=auto [x86]
>> +					       spec_store_bypass_disable=auto [x86]
>> +					       l1tf=flush [x86]
>>  
>>  			auto,nosmt
>>  				Mitigate all speculative CPU vulnerabilities,
>>  				disabling SMT if needed.  This is for users who
>>  				always want to be fully mitigated, even if it
>>  				means losing SMT.
>> +				Equivalent to: pti=auto [x86]
>> +					       spectre_v2=auto [x86]
>> +					       spectre_v2_user=auto [x86]
>> +					       spec_store_bypass_disable=auto [x86]
>> +					       l1tf=flush,nosmt [x86]
>>  
>>  	mminit_loglevel=
>>  			[KNL] When CONFIG_DEBUG_MEMORY_INIT is set, this
> 
> Yap, those sets look ok.

nit:  s/x86/X86/g
according to Documentation/admin-guide/kernel-parameters.rst


-- 
~Randy
