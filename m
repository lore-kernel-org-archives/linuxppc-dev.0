Return-Path: <dvlasenk@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJ2Nl1DGjzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 04:37:10 +1000 (AEST)
Subject: Re: [PATCH v4] powerpc: Do not make the entire heap executable
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20160810130030.5268-1-dvlasenk@redhat.com>
 <874m6ejf81.fsf@linux.vnet.ibm.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Kees Cook <keescook@chromium.org>,
 Oleg Nesterov <oleg@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Florian Weimer <fweimer@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
From: Denys Vlasenko <dvlasenk@redhat.com>
Message-ID: <47a2e87e-5299-a009-8a65-5171b33967a1@redhat.com>
Date: Mon, 22 Aug 2016 20:37:05 +0200
MIME-Version: 1.0
In-Reply-To: <874m6ejf81.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/21/2016 05:47 PM, Aneesh Kumar K.V wrote:
> Denys Vlasenko <dvlasenk@redhat.com> writes:
>
>> On 32-bit powerpc the ELF PLT sections of binaries (built with --bss-plt,
>> or with a toolchain which defaults to it) look like this:
>>
>>   [17] .sbss             NOBITS          0002aff8 01aff8 000014 00  WA  0   0  4
>>   [18] .plt              NOBITS          0002b00c 01aff8 000084 00 WAX  0   0  4
>>   [19] .bss              NOBITS          0002b090 01aff8 0000a4 00  WA  0   0  4
>>
>> Which results in an ELF load header:
>>
>>   Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
>>   LOAD           0x019c70 0x00029c70 0x00029c70 0x01388 0x014c4 RWE 0x10000
>>
>> This is all correct, the load region containing the PLT is marked as
>> executable. Note that the PLT starts at 0002b00c but the file mapping ends at
>> 0002aff8, so the PLT falls in the 0 fill section described by the load header,
>> and after a page boundary.
>>
>> Unfortunately the generic ELF loader ignores the X bit in the load headers
>> when it creates the 0 filled non-file backed mappings. It assumes all of these
>> mappings are RW BSS sections, which is not the case for PPC.
>>
>> gcc/ld has an option (--secure-plt) to not do this, this is said to incur
>> a small performance penalty.
>>
>> Currently, to support 32-bit binaries with PLT in BSS kernel maps *entire
>> brk area* with executable rights for all binaries, even --secure-plt ones.
>
>
> Is this going to break any application ? I am asking because you
> mentioned the patch is lightly tested.

I booted powerpc64 machine with RHEL7 installation,
it did not catch fire.

> x86 do have a
>
> #define VM_DATA_DEFAULT_FLAGS \
> 	(((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0 ) | \
> 	 VM_READ | VM_WRITE | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
>
> ie, it can force a read implies exec mode. Do we need that ?

powerpc64 never had that. 32-bit mode may need it, since before
this patch all 32-bit tasks were unconditionally getting
VM_DATA_DEFAULT_FLAGS with VM_EXEC bit.

I'll send an updated patch.
