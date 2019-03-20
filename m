Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683BAC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 13:32:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B990213F2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 13:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B990213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PW6p4SYGzDqQt
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Mar 2019 00:32:02 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PVm51FfWzDqJs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2019 00:15:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44PVm43NQyz9sNG;
 Thu, 21 Mar 2019 00:15:48 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Catalin Marinas <catalin.marinas@arm.com>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v2] kmemleak: skip scanning holes in the .bss section
In-Reply-To: <20190319115747.GB59586@arrakis.emea.arm.com>
References: <20190313145717.46369-1-cai@lca.pw>
 <20190319115747.GB59586@arrakis.emea.arm.com>
Date: Thu, 21 Mar 2019 00:15:46 +1100
Message-ID: <87lg19y9dp.fsf@concordia.ellerman.id.au>
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
Cc: linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Catalin Marinas <catalin.marinas@arm.com> writes:
> Hi Qian,
>
> On Wed, Mar 13, 2019 at 10:57:17AM -0400, Qian Cai wrote:
>> @@ -1531,7 +1547,14 @@ static void kmemleak_scan(void)
>>  
>>  	/* data/bss scanning */
>>  	scan_large_block(_sdata, _edata);
>> -	scan_large_block(__bss_start, __bss_stop);
>> +
>> +	if (bss_hole_start) {
>> +		scan_large_block(__bss_start, bss_hole_start);
>> +		scan_large_block(bss_hole_stop, __bss_stop);
>> +	} else {
>> +		scan_large_block(__bss_start, __bss_stop);
>> +	}
>> +
>>  	scan_large_block(__start_ro_after_init, __end_ro_after_init);
>
> I'm not a fan of this approach but I couldn't come up with anything
> better. I was hoping we could check for PageReserved() in scan_block()
> but on arm64 it ends up not scanning the .bss at all.
>
> Until another user appears, I'm ok with this patch.
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I actually would like to rework this kvm_tmp thing to not be in bss at
all. It's a bit of a hack and is incompatible with strict RWX.

If we size it a bit more conservatively we can hopefully just reserve
some space in the text section for it.

I'm not going to have time to work on that immediately though, so if
people want this fixed now then this patch could go in as a temporary
solution.

cheers
