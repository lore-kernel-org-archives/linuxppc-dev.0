Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4196xG59QDzF0nB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 22:40:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Florian Weimer <fweimer@redhat.com>, Ram Pai <linuxram@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dave.hansen@intel.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, Ulrich.Weigand@de.ibm.com,
 luto@kernel.org, msuchanek@suse.de
Subject: Re: [PATCH v2 0/6] powerpc/pkeys: fixes to pkeys
In-Reply-To: <8812c879-5761-ef62-dd15-3ceef46d9653@redhat.com>
References: <1528936144-6696-1-git-send-email-linuxram@us.ibm.com>
 <8812c879-5761-ef62-dd15-3ceef46d9653@redhat.com>
Date: Tue, 19 Jun 2018 22:40:01 +1000
Message-ID: <874lhzx84e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Florian Weimer <fweimer@redhat.com> writes:
> On 06/14/2018 02:28 AM, Ram Pai wrote:
>> Assortment of fixes to pkey.
>> 
>> Patch 1  makes pkey consumable in multithreaded applications.
>> 
>> Patch 2  fixes fork behavior to inherit the key attributes.
>> 
>> Patch 3  A off-by-one bug made one key unusable. Fixes it.
>> 
>> Patch 4  Execute-only key is preallocated.
>> 
>> Patch 5  Makes pkey-0 less special.
>> 
>> Patch 6  Deny by default permissions on all unallocated keys.
>> 
>> Passes all selftests on powerpc. Also behavior verified to be correct
>> by Florian.
>> 
>> Changelog:
>> 
>> 	v2: . fixed merge conflict with upstream code.
>> 	    . Add patch 6. Makes the behavior consistent
>> 	      with that on x86.
>
> (Except signal handling, but I agree with Ram that the POWER behavior is 
> the correct one.)
>
>> Ram Pai (6):
>>    powerpc/pkeys: Enable all user-allocatable pkeys at init.
>>    powerpc/pkeys: Save the pkey registers before fork
>>    powerpc/pkeys: fix calculation of total pkeys.
>>    powerpc/pkeys: Preallocate execute-only key
>>    powerpc/pkeys: make protection key 0 less special
>>    powerpc/pkeys: Deny read/write/execute by default
>
> I tested the whole series with the new selftests, with the printamr.c 
> program I posted earlier, and the glibc test for pkey_alloc &c.  The 
> latter required some test fixes, but now passes as well.  As far as I 
> can tell, everything looks good now.
>
> Tested-By: Florian Weimer <fweimer@redhat.com>

Thanks. I'll add that to each patch I guess, if you're happy with that?

cheers
