Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0167B1A0A96
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 14:08:33 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 3 Feb 2015 13:08:32 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4CEF62CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 14:08:29 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1338KBL35848204
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Feb 2015 14:08:29 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1337t16018609
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Feb 2015 14:07:55 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/mm: Add trace point for tracking hash pte fault
In-Reply-To: <20150203090129.5e3c7494@kryten>
References: <1421753750-17135-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1421809627.4900.1.camel@ellerman.id.au> <87d268v7xm.fsf@linux.vnet.ibm.com>
 <1422425467.11009.2.camel@ellerman.id.au> <20150202212607.7585dedb@kryten>
 <87vbjk707w.fsf@linux.vnet.ibm.com> <20150203090129.5e3c7494@kryten>
Date: Tue, 03 Feb 2015 08:37:35 +0530
Message-ID: <87pp9r7kw8.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard <anton@samba.org> writes:

> Hi Aneesh,
>
>> yes. We do use jump label. I also verified that looking at .s
>> 
>> #APP
>>  # 23 "./arch/powerpc/include/asm/jump_label.h" 1
>>         1:
>>         nop
>>         .pushsection __jump_table,  "aw"
>>         .llong 1b, .L201, __tracepoint_hash_fault+8      #,
>>         .popsection
>> 
>>  # 0 "" 2
>
> So we insert a single nop, and the slow path is in another section. I'd
> be surprised if we could measure this, unless the nop causes a branch
> target alignment issue the slow path caused some hot path icache layout
> issues.
>
>> Without patch
>> sys: 0m11.2425
>> 
>> With patch:
>> sys: 0m11.3258
>>
>> ie, a -0.7% impact 
>> 
>> If that impact is high we could possibly put that tracepoint within
>> #ifdef CONFIG_DEBUG_VM ?
>
> Did the real time change? I'd be careful about comparing based on
> system time.


Yes it did. 
11.8769 with patch
11.7924 without patch

I will look at the perf stat data difference between the both runs and update.

-aneesh
