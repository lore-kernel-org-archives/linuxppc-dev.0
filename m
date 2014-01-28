Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3AD792C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 05:49:49 +1100 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 29 Jan 2014 04:49:47 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0B9392CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 05:49:44 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0SInUIN10617134
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 05:49:30 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0SInhIA010524
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 05:49:43 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: don't re-issue spinlock typedef that breaks
 older gcc
In-Reply-To: <52E7EDC4.3000102@windriver.com>
References: <1390925817-27374-1-git-send-email-paul.gortmaker@windriver.com>
 <87sis810dl.fsf@linux.vnet.ibm.com> <52E7EDC4.3000102@windriver.com>
Date: Wed, 29 Jan 2014 00:19:38 +0530
Message-ID: <87ppnc0wn1.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Gortmaker <paul.gortmaker@windriver.com> writes:

> On 14-01-28 12:28 PM, Aneesh Kumar K.V wrote:
>> Paul Gortmaker <paul.gortmaker@windriver.com> writes:
>> 
>>> Commit b3084f4db3aeb991c507ca774337c7e7893ed04f ("powerpc/thp: Fix
>>> crash on mremap") added a "typedef struct spinlock spinlock_t;"
>>> which on gcc 4.5.2 (and possibly other versions) causes many of:
>>>
>>> include/linux/spinlock_types.h:76:3: error: redefinition of typedef 'spinlock_t'
>>> arch/powerpc/include/asm/pgtable-ppc64.h:563:25: note: previous declaration of 'spinlock_t' was here
>>> In file included from include/linux/mutex.h:15:0,
>>>                  from include/linux/notifier.h:13,
>>>                  from include/linux/pm_qos.h:8,
>>>                  from include/linux/netdevice.h:28,
>>>                  from drivers/net/wireless/ath/wil6210/wil6210.h:20,
>>>                  from drivers/net/wireless/ath/wil6210/debug.c:17:
>>>
>>> It appears that somewhere between gcc 4.5.2 and 4.6.3 this
>>> redefinition restriction was lifted.  Using the proper header
>>> from within !ASSEMBLY seems to fix it up in an acceptable way.
>>>
>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>>> ---
>>>
>> 
>> 
>> http://mid.gmane.org/1389939036.3000.7.camel@ThinkPad-T5421.cn.ibm.com
>> 
>> This was posted earlier.
>
> I see.  Well I guess Ben didn't use it since it is the same as the
> temporary not-signed-off-by hack patch I posted earlier as well.
>
> https://lkml.org/lkml/2014/1/27/584
>
> I believe what I've posted here below to be the proper fix.

I had another variant which needed this

http://mid.gmane.org/1388999012-14424-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com

BTW I had added the above struct spinlock; patch as the backport to
stable 3.13 series. So if we are picking another one, we may need to
update stable also

-aneesh
