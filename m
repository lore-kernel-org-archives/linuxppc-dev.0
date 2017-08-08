Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRPzt2qWnzDrFt
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 16:45:46 +1000 (AEST)
Subject: Re: [01/24] powerpc/mm: Move exception_enter/exit to a do_page_fault
 wrapper
To: Michael Ellerman <mpe@ellerman.id.au>,
 Michael Ellerman <patch-notifications@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
References: <3xQvGm0kQ5z9sR9@ozlabs.org>
 <dca04b16-c97a-3d8c-a748-7945d0fb80dd@c-s.fr>
 <87poc6olbp.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <24c35bb0-2152-f381-9783-6fc820a0e72c@c-s.fr>
Date: Tue, 8 Aug 2017 08:45:42 +0200
MIME-Version: 1.0
In-Reply-To: <87poc6olbp.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 08/08/2017 à 04:16, Michael Ellerman a écrit :
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
> 
>> Le 07/08/2017 à 12:41, Michael Ellerman a écrit :
>>> On Wed, 2017-07-19 at 04:49:23 UTC, Benjamin Herrenschmidt wrote:
>>>> This will allow simplifying the returns from do_page_fault
>>>>
>>>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>
>>> Series applied to powerpc next, thanks.
>>>
>>> https://git.kernel.org/powerpc/c/7afad422ac61067473d5f3d20bbd54
>>
>> Boot failure on the 8xx:
>>
>> [    6.029556] Failed to execute /init (error -14)
>> [    6.034623] Starting init: /bin/sh exists but couldn't execute it
>> (error -14)
>> [    6.041489] Kernel panic - not syncing: No working init found.  Try
>> passing init= option to kernel. See Linux
>> Documentation/admin-guide/init.rst for guidance.
>> [    6.055518] CPU: 0 PID: 1 Comm: init Not tainted
>> 4.13.0-rc3-s3k-dev-00143-g7aa62e972a56 #56
>> [    6.063745] Call Trace:
>> [    6.066224] [c60f1ed0] [c001a624] panic+0x108/0x250 (unreliable)
>> [    6.072140] [c60f1f30] [c0002640] rootfs_mount+0x0/0x58
>> [    6.077311] [c60f1f40] [c000cb80] ret_from_kernel_thread+0x5c/0x64
>> [    6.083405] Rebooting in 180 seconds..
>>
>>
>> Bisected to c433ec0455f921eaf8dd0262a718ce6f8ad62ea2 ("powerpc/mm:
>> Pre-filter SRR1 bits before do_page_fault()")
> 
> Sorry about that. I don't have a way to test 8xx.

Looks like I concluded too quickly yesterday night, indeed the above 
commit is the last good one. The faulty one is 
d300627c6a53693fb01479b59b0cdd293761b1fa("powerpc/6xx: Handle DABR match 
before calling do_page_fault")

> 
>> Will see tomorrow what's wrong with that.
> 
> Thanks.

This is because the 'bl do_page_fault' has been enclosed inside the 
#ifdef CONFIG_6xx

See patch at https://patchwork.ozlabs.org/patch/799039/

Christophe
