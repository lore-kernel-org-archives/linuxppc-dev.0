Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ntXD71c0zDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 May 2018 15:15:08 +1000 (AEST)
Subject: Re: pkeys on POWER: Default AMR, UAMOR values
To: Ram Pai <linuxram@us.ibm.com>
Cc: Andy Lutomirski <luto@amacapital.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-MM <linux-mm@kvack.org>,
 Dave Hansen <dave.hansen@intel.com>
References: <36b98132-d87f-9f75-f1a9-feee36ec8ee6@redhat.com>
 <20180518174448.GE5479@ram.oc3035372033.ibm.com>
 <CALCETrV_wYPKHna8R2Bu19nsDqF2dJWarLLsyHxbcYD_AgYfPg@mail.gmail.com>
 <27e01118-be5c-5f90-78b2-56bb69d2ab95@redhat.com>
 <20180519005219.GI5479@ram.oc3035372033.ibm.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <0e39d75a-c862-205b-1ba2-6843488d7fcd@redhat.com>
Date: Sat, 19 May 2018 07:15:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180519005219.GI5479@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/19/2018 02:52 AM, Ram Pai wrote:

>>> The POWER semantics make it very hard for a multithreaded program to
>>> meaningfully use protection keys to prevent accidental access to important
>>> memory.
>>
>> And you can change access rights for unallocated keys (unallocated
>> at thread start time, allocated later) on x86.  I have extended the
>> misc/tst-pkeys test to verify that, and it passes on x86, but not on
>> POWER, where the access rights are stuck.
> 
> This is something I do not understand. How can a thread change permissions
> on a key, that is not even allocated in the first place.

It was allocated by another thread, and there is synchronization so that 
the allocation happens before the change in access rights.

> Do you consider a key
> allocated in some other thread's context, as allocated in this threads
> context?

Yes, x86 does that.

> If not, does that mean -- On x86, you can activate a key just
> by changing its permission?

This also true on x86, but just an artifact of the implementation.  You 
are supposed to call pkey_alloc before changing the flag.

Thanks,
Florian
