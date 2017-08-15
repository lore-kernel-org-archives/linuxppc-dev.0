Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWgM80HvKzDr9D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 15:02:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
 benh@kernel.crashing.org, paulus@samba.org, davem@davemloft.net,
 dave.hansen@linux.intel.com
Cc: bsingharora@gmail.com, dja@axtens.net, tglx@linutronix.de, mgorman@suse.de,
 aarcange@redhat.com, kirill.shutemov@linux.intel.com,
 heiko.carstens@de.ibm.com, ak@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org,
 Khalid Aziz <khalid@gonehiking.org>
Subject: Re: [PATCH v7 7/9] mm: Add address parameter to arch_validate_prot()
In-Reply-To: <2e97b439-dd71-8997-4824-15f2b1f53787@oracle.com>
References: <cover.1502219353.git.khalid.aziz@oracle.com>
 <43c120f0cbbebd1398997b9521013ced664e5053.1502219353.git.khalid.aziz@oracle.com>
 <87tw1flftz.fsf@concordia.ellerman.id.au>
 <2e97b439-dd71-8997-4824-15f2b1f53787@oracle.com>
Date: Tue, 15 Aug 2017 15:02:08 +1000
Message-ID: <877ey5v2y7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Khalid Aziz <khalid.aziz@oracle.com> writes:

> On 08/10/2017 07:20 AM, Michael Ellerman wrote:
>> Khalid Aziz <khalid.aziz@oracle.com> writes:
>>=20
>>> A protection flag may not be valid across entire address space and
>>> hence arch_validate_prot() might need the address a protection bit is
>>> being set on to ensure it is a valid protection flag. For example, sparc
>>> processors support memory corruption detection (as part of ADI feature)
>>> flag on memory addresses mapped on to physical RAM but not on PFN mapped
>>> pages or addresses mapped on to devices. This patch adds address to the
>>> parameters being passed to arch_validate_prot() so protection bits can
>>> be validated in the relevant context.
>>>
>>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>>> Cc: Khalid Aziz <khalid@gonehiking.org>
>>> ---
>>> v7:
>>> 	- new patch
>>>
>>>   arch/powerpc/include/asm/mman.h | 2 +-
>>>   arch/powerpc/kernel/syscalls.c  | 2 +-
>>>   include/linux/mman.h            | 2 +-
>>>   mm/mprotect.c                   | 2 +-
>>>   4 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm=
/mman.h
>>> index 30922f699341..bc74074304a2 100644
>>> --- a/arch/powerpc/include/asm/mman.h
>>> +++ b/arch/powerpc/include/asm/mman.h
>>> @@ -40,7 +40,7 @@ static inline bool arch_validate_prot(unsigned long p=
rot)
>>>   		return false;
>>>   	return true;
>>>   }
>>> -#define arch_validate_prot(prot) arch_validate_prot(prot)
>>> +#define arch_validate_prot(prot, addr) arch_validate_prot(prot)
>>=20
>> This can be simpler, as just:
>>=20
>> #define arch_validate_prot arch_validate_prot
>>=20
>
> Hi Michael,
>
> Thanks for reviewing!
>
> My patch expands parameter list for arch_validate_prot() from one to two=
=20
> parameters. Existing powerpc version of arch_validate_prot() is written=20
> with one parameter. If I use the above #define, compilation fails with:
>
> mm/mprotect.c: In function =E2=80=98do_mprotect_pkey=E2=80=99:
> mm/mprotect.c:399: error: too many arguments to function=20
> =E2=80=98arch_validate_prot=E2=80=99
>
> Another way to solve it would be to add the new addr parameter to=20
> powerpc version of arch_validate_prot() but I chose the less disruptive=20
> solution of tackling it through #define and expanded the existing=20
> #define to include the new parameter. Make sense?

Yes, it makes sense. But it's a bit gross.

At first glance it looks like our arch_validate_prot() has an incorrect
signature.

I'd prefer you just updated it to have the correct signature, I think
you'll have to change one more line in do_mmap2(). So it's not very
intrusive.

cheers
