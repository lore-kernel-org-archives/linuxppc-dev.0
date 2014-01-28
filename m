Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5BEC42C007C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 06:06:56 +1100 (EST)
Message-ID: <52E7FFDF.9050405@windriver.com>
Date: Tue, 28 Jan 2014 14:07:11 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc: don't re-issue spinlock typedef that breaks
 older gcc
References: <1390925817-27374-1-git-send-email-paul.gortmaker@windriver.com>
 <87sis810dl.fsf@linux.vnet.ibm.com> <52E7EDC4.3000102@windriver.com>
 <87ppnc0wn1.fsf@linux.vnet.ibm.com>
In-Reply-To: <87ppnc0wn1.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14-01-28 01:49 PM, Aneesh Kumar K.V wrote:
> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
> 
>> On 14-01-28 12:28 PM, Aneesh Kumar K.V wrote:
>>> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
>>>
>>>> Commit b3084f4db3aeb991c507ca774337c7e7893ed04f ("powerpc/thp: Fix
>>>> crash on mremap") added a "typedef struct spinlock spinlock_t;"
>>>> which on gcc 4.5.2 (and possibly other versions) causes many of:
>>>>
>>>> include/linux/spinlock_types.h:76:3: error: redefinition of typedef 'spinlock_t'
>>>> arch/powerpc/include/asm/pgtable-ppc64.h:563:25: note: previous declaration of 'spinlock_t' was here
>>>> In file included from include/linux/mutex.h:15:0,
>>>>                  from include/linux/notifier.h:13,
>>>>                  from include/linux/pm_qos.h:8,
>>>>                  from include/linux/netdevice.h:28,
>>>>                  from drivers/net/wireless/ath/wil6210/wil6210.h:20,
>>>>                  from drivers/net/wireless/ath/wil6210/debug.c:17:
>>>>
>>>> It appears that somewhere between gcc 4.5.2 and 4.6.3 this
>>>> redefinition restriction was lifted.  Using the proper header
>>>> from within !ASSEMBLY seems to fix it up in an acceptable way.
>>>>
>>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>>>> ---
>>>>
>>>
>>>
>>> http://mid.gmane.org/1389939036.3000.7.camel@ThinkPad-T5421.cn.ibm.com
>>>
>>> This was posted earlier.
>>
>> I see.  Well I guess Ben didn't use it since it is the same as the
>> temporary not-signed-off-by hack patch I posted earlier as well.
>>
>> https://lkml.org/lkml/2014/1/27/584
>>
>> I believe what I've posted here below to be the proper fix.
> 
> I had another variant which needed this
> 
> http://mid.gmane.org/1388999012-14424-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com

What config did you use to trigger that?  I've not seen it in
allyes/allmodconfig.  I'd like us to try and fix it an alternate
way, vs. fragmenting the header into smaller and smaller
specialized chunks, if possible.

> 
> BTW I had added the above struct spinlock; patch as the backport to
> stable 3.13 series. So if we are picking another one, we may need to
> update stable also

The stable tree is self-correcting ; it won't take any patches that
don't have the same commit present in mainline.  But yes, someone
will still have to _nominate_ one for stable tree consideration.

Paul.
--

> 
> -aneesh
> 
