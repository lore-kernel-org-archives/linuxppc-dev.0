Return-Path: <SRS0=sb+l=LK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4F3C48BE5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 02:41:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF7861055
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 02:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF7861055
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G4Tvn10dKz30CS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 12:41:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Lz/Ng2gG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Lz/Ng2gG; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G4TvK1DmPz2y0G
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jun 2021 12:40:45 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4G4TvH2Cwlz9sTD;
 Wed, 16 Jun 2021 12:40:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1623811244;
 bh=fAOxWCCUqkqRWTT3Osv85acAWAHitkHmIfoMB/o2TUE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Lz/Ng2gGouKD1PHFlUlCnZRvKgC5bG2BrrqX2PRNWdejhXTaEEyIeEOqjXb12ND9Z
 lc3IVqFyNyLvQMQvaO9Hm6/h+UYs7bUH1TOYQGmbdTvKi24aHNeKjXTknSLcLiIVrn
 8ihXvNq73r5qty1HKS8yxN8Zn8pYE20eB3l7jtnYdk6HFX9ws238b/KhClvpLqK21n
 Zth3zU2kVeZag85kYywY/3gJm2TCkhuEuRP3U/X+0z8A8UO6YRI0lArHLsROkHiCO1
 ClIAspa7RmydpOMctT242mM8UitpOYeEfC2CLYcVO25hqNINxJwJDlkBWPBZyWXcR/
 2ZY9eHltVwEEQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH] powerpc: Fix initrd corruption with relative jump labels
In-Reply-To: <YMit22vwhmeK5BvK@SPB-NB-133.local>
References: <20210614131440.312360-1-mpe@ellerman.id.au>
 <YMit22vwhmeK5BvK@SPB-NB-133.local>
Date: Wed, 16 Jun 2021 12:40:42 +1000
Message-ID: <87pmwmsf9x.fsf@mpe.ellerman.id.au>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, groug@kaod.org, a.kovaleva@yadro.com,
 linux-kernel@vger.kernel.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Roman Bolshakov <r.bolshakov@yadro.com> writes:
> On Mon, Jun 14, 2021 at 11:14:40PM +1000, Michael Ellerman wrote:
>> Commit b0b3b2c78ec0 ("powerpc: Switch to relative jump labels") switched
>> us to using relative jump labels. That involves changing the code,
>> target and key members in struct jump_entry to be relative to the
>> address of the jump_entry, rather than absolute addresses.
>> 
>> We have two static inlines that create a struct jump_entry,
>> arch_static_branch() and arch_static_branch_jump(), as well as an asm
>> macro ARCH_STATIC_BRANCH, which is used by the pseries-only hypervisor
>> tracing code.
>> 
>> Unfortunately we missed updating the key to be a relative reference in
>> ARCH_STATIC_BRANCH.
>> 
>> That causes a pseries kernel to have a handful of jump_entry structs
>> with bad key values. Instead of being a relative reference they instead
>> hold the full address of the key.
>> 
>> However the code doesn't expect that, it still adds the key value to the
>> address of the jump_entry (see jump_entry_key()) expecting to get a
>> pointer to a key somewhere in kernel data.
>> 
>> The table of jump_entry structs sits in rodata, which comes after the
>> kernel text. In a typical build this will be somewhere around 15MB. The
>> address of the key will be somewhere in data, typically around 20MB.
>> Adding the two values together gets us a pointer somewhere around 45MB.
>> 
>> We then call static_key_set_entries() with that bad pointer and modify
>> some members of the struct static_key we think we are pointing at.
>> 
>> A pseries kernel is typically ~30MB in size, so writing to ~45MB won't
>> corrupt the kernel itself. However if we're booting with an initrd,
>> depending on the size and exact location of the initrd, we can corrupt
>> the initrd. Depending on how exactly we corrupt the initrd it can either
>> cause the system to not boot, or just corrupt one of the files in the
>> initrd.
>> 
>> The fix is simply to make the key value relative to the jump_entry
>> struct in the ARCH_STATIC_BRANCH macro.
>> 
>> Fixes: b0b3b2c78ec0 ("powerpc: Switch to relative jump labels")
>> Reported-by: Anastasia Kovaleva <a.kovaleva@yadro.com>
>> Reported-by: Roman Bolshakov <r.bolshakov@yadro.com>
>> Reported-by: Greg Kurz <groug@kaod.org>
>> Reported-by: Daniel Axtens <dja@axtens.net>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  arch/powerpc/include/asm/jump_label.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
>> index 2d5c6bec2b4f..93ce3ec25387 100644
>> --- a/arch/powerpc/include/asm/jump_label.h
>> +++ b/arch/powerpc/include/asm/jump_label.h
>> @@ -50,7 +50,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
>>  1098:	nop;					\
>>  	.pushsection __jump_table, "aw";	\
>>  	.long 1098b - ., LABEL - .;		\
>> -	FTR_ENTRY_LONG KEY;			\
>> +	FTR_ENTRY_LONG KEY - .;			\
>>  	.popsection
>>  #endif
>>  
>> -- 
>> 2.25.1
>> 
>
> Thanks for fixing the issue, Michael.
>
> Perhaps the fix should go to v5.13-rc7 if Linus plans to do it. It'd be
> good to avoid broken initrd on pseries guests in the release.

Yes it's in my fixes branch and I'll ask Linus to pull that before the
next rc.

cheers
