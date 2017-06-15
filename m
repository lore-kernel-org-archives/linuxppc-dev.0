Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wp3YR2FKkzDqKv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 10:00:43 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id f127so1798802pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 17:00:43 -0700 (PDT)
Subject: Re: [PATCH kernel] powerpc/debug: Add missing warn flag to WARN_ON's
 non-builtin path
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org,
 "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
References: <20170614030125.45899-1-aik@ozlabs.ru>
 <87mv9a3k59.fsf@concordia.ellerman.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <bbdd8ae1-7489-db86-3121-58b94c797a28@ozlabs.ru>
Date: Thu, 15 Jun 2017 10:00:33 +1000
MIME-Version: 1.0
In-Reply-To: <87mv9a3k59.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=koi8-r
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/06/17 21:04, Michael Ellerman wrote:
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> 
>> When trapped on WARN_ON(), report_bug() is expected to return
>> BUG_TRAP_TYPE_WARN so the caller could increment NIP by 4 and continue.
>> The __builtin_constant_p() path of the PPC's WARN_ON() calls (indirectly)
>> __WARN_FLAGS() which has BUGFLAG_WARNING set, however the other branch
>> does not which makes report_bug() report a bug rather than a warning.
>>
>> Fixes: 19d436268dde95389 ("debug: Add _ONCE() logic to report_bug()")
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> Actually 19d436268dde95389 replaced __WARN_TAINT() with __WARN_FLAGS()
>> and lost BUGFLAG_TAINT() and this is not in the commit log so it is
>> unclear:
>> 1) why
> 
> I think the rename is because previously the argument was a taint value,
> whereas now it is a flags value (which is a superset of taint).
> 
>> 2) whether this particular patch should be doing
>>    BUGFLAG_WARNING|BUGFLAG_TAINT(TAINT_WARN)
>>  or
>>    BUGFLAG_WARNING|(flags)
> 
> There is no flags here so the latter won't work AFAICS.
> 
>> Any ideas? Thanks.
> 
> Your patch looks correct to me. I assume it works?

Yes, it does.

> 
> 
> The bug isn't introduced by 19d436268dde ("debug: Add _ONCE() logic to
> report_bug()") as far as I can see.
> 
> If you check out that revision you see that BUGFLAG_TAINT still contains
> BUGFLAG_WARNING:
> 
> #define BUGFLAG_TAINT(taint)	(BUGFLAG_WARNING | ((taint) << 8))
> 
> But that was removed in f26dee15103f ("debug: Avoid setting
> BUGFLAG_WARNING twice"). So I think the Fixes: tag should point at that
> commit.

Ah, you're right. Should I repost the patch with the updated "fixes:" clause?


> 
> cheers
> 
>> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
>> index f2c562a0a427..0151af6c2a50 100644
>> --- a/arch/powerpc/include/asm/bug.h
>> +++ b/arch/powerpc/include/asm/bug.h
>> @@ -104,7 +104,7 @@
>>  		"1:	"PPC_TLNEI"	%4,0\n"			\
>>  		_EMIT_BUG_ENTRY					\
>>  		: : "i" (__FILE__), "i" (__LINE__),		\
>> -		  "i" (BUGFLAG_TAINT(TAINT_WARN)),		\
>> +		  "i" (BUGFLAG_WARNING|BUGFLAG_TAINT(TAINT_WARN)),\
>>  		  "i" (sizeof(struct bug_entry)),		\
>>  		  "r" (__ret_warn_on));				\
>>  	}							\
>> -- 
>> 2.11.0


-- 
Alexey
