Return-Path: <SRS0=OkVA=BO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19E1C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2020 00:51:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD52206DA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2020 00:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Za5rUkj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD52206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BLGRc40fkzDqTN
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2020 10:51:56 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BLGNm1BKFzDqSp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2020 10:49:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Za5rUkj7; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BLGNj2bMHz9sPC;
 Tue,  4 Aug 2020 10:49:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1596502166;
 bh=3km56OESZEG1IUM1QfBpRjK0KZXxpHpMwagYVoTYTGM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Za5rUkj7GfVi2NgE+l0OjQQiWk3Cit3/ruEipW0TWiKNNpaqDN3ey4NZhYQvK1iE0
 UXwfqs3famv4I4mkymeNMWAsb3boWg2Vbok6ZZsFCbhwPloV5RSzjXGzmSTTH1U8ha
 dL/0Ve8EavL/rteDkH7Kza/b3+2vBa/SozZ0UWHm3vaGVUjPYAZFsW2I0dd7DL+DKq
 nFMiPjeutb080LI3VnEDIxPEFOJ7dYwb2XNeq+RXaiysW9hF7MzaG+SszubeLoArY8
 mv3azWtlB3rPOhtuvE+3sWAZwPu2ypmirlFZv4FdIBB50IEKEEZsNjIByyuWTGkUj7
 MjlbJCFm5ZcHA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: powerpc: build failures in Linus' tree
In-Reply-To: <20200803223147.28adac79@canb.auug.org.au>
References: <20200802204842.36bca162@canb.auug.org.au>
 <20200802172019.GB26677@1wt.eu> <20200803034547.GA15501@1wt.eu>
 <87v9i0yo47.fsf@mpe.ellerman.id.au>
 <20200803223147.28adac79@canb.auug.org.au>
Date: Tue, 04 Aug 2020 10:49:20 +1000
Message-ID: <87pn87z14f.fsf@mpe.ellerman.id.au>
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
Cc: Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Paul Mackerras <paulus@samba.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Willy Tarreau <w@1wt.eu>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> On Mon, 03 Aug 2020 21:18:00 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> If we just move the include of asm/paca.h below asm-generic/percpu.h
>> then it avoids the bad circular dependency and we still have paca.h
>> included from percpu.h as before.
>> 
>> eg:
>> 
>> diff --git a/arch/powerpc/include/asm/percpu.h b/arch/powerpc/include/asm/percpu.h
>> index dce863a7635c..8e5b7d0b851c 100644
>> --- a/arch/powerpc/include/asm/percpu.h
>> +++ b/arch/powerpc/include/asm/percpu.h
>> @@ -10,8 +10,6 @@
>>  
>>  #ifdef CONFIG_SMP
>>  
>> -#include <asm/paca.h>
>> -
>>  #define __my_cpu_offset local_paca->data_offset
>>  
>>  #endif /* CONFIG_SMP */
>> @@ -19,4 +17,6 @@
>>  
>>  #include <asm-generic/percpu.h>
>>  
>> +#include <asm/paca.h>
>> +
>>  #endif /* _ASM_POWERPC_PERCPU_H_ */
>> 
>> 
>> So I think I'm inclined to merge that as a minimal fix that's easy to
>> backport.
>> 
>> cheers
>
> Looks ok, except does it matter that the include used to be only done
> if __powerpc64__ and CONFIG_SMP are defined?

Basically all of paca.h is inside #ifdef CONFIG_PPC64.

SMP "shouldn't matter", but I tested a SMP=n build and it's clean, so I
think it's good. Of course there's really no guarantees with these
header tangles.

cheers
