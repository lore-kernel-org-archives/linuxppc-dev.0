Return-Path: <sam.mj@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E6921A104C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 13:50:02 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E8D401402BA
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 13:50:01 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.mj@au1.ibm.com>;
 Wed, 8 Jul 2015 13:50:01 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3A0BA357804C
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2015 13:49:58 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t683npDk3604872
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2015 13:49:59 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t683nP0T016782
 for <linuxppc-dev@ozlabs.org>; Wed, 8 Jul 2015 13:49:26 +1000
Reply-To: sam.mj@au1.ibm.com
Subject: Re: [kexec-lite PATCH V2] trampoline: Reset primary cpu endian to
 big-endian
References: <1436326178-17021-1-git-send-email-sam.mj@au1.ibm.com>
 <1436326636.2658.68.camel@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: anton@samba.org, linuxppc-dev@ozlabs.org
From: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Message-ID: <559C9DC1.30201@au1.ibm.com>
Date: Wed, 8 Jul 2015 13:49:21 +1000
MIME-Version: 1.0
In-Reply-To: <1436326636.2658.68.camel@freescale.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/07/15 13:37, Scott Wood wrote:
> On Wed, 2015-07-08 at 13:29 +1000, Samuel Mendoza-Jonas wrote:
>> Older big-endian ppc64 kernels don't include the FIXUP_ENDIAN check,
>> meaning if we kexec from a little-endian kernel the target kernel will
>> fail to boot.
>> Returning to big-endian before we enter the target kernel ensures that
>> the target kernel can boot whether or not it includes FIXUP_ENDIAN.
>>
>> Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
>> ---
>> V2: As suggested by Anton take advantage of the rfid call and switch off
>> MSR_LE and branch to the target kernel in the same step.
>>
>>  kexec_trampoline.S | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/kexec_trampoline.S b/kexec_trampoline.S
>> index a3eb314..3751112 100644
>> --- a/kexec_trampoline.S
>> +++ b/kexec_trampoline.S
>> @@ -88,8 +88,15 @@ start:
>>  
>>       li      r5,0
>>  
>> -     mtctr   r4
>> -     bctr
>> +     mtsrr0  r4
>> +
>> +     mfmsr   r5
>> +     clrrdi  r5,r5,1         /* Clear MSR_LE */
>> +     mtsrr1  r5
>> +
>> +     li      r5,0
>> +
>> +     rfid
> 
> Is kexec-lite meant to be specific to book3s-64?  The README just says "A 
> simple kexec for flattened device tree platforms" and I see a __powerpc64__ 
> ifdef in kexec_trampoline.S (but not in the above patch)...
> 
> -Scott
> 

I believe that particular ifdef is to check if we're little-endian when reading
the device tree, but that's still a good point - I'll check with Anton.

-- 
-----------
LTC Ozlabs
IBM
