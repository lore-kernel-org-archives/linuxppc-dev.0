Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wKSN34y3FzDqCL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 May 2017 09:12:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: aik@ozlabs.ru, alastair@d-silva.org, Alex Williamson
 <alex.williamson@redhat.com>, alistair@popple.id.au,
 ananth@linux.vnet.ibm.com, Andrew Donnellan
 <andrew.donnellan@au1.ibm.com>, "Aneesh Kumar K. V"
 <aneesh.kumar@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>, Ben
 Hutchings <ben@decadent.org.uk>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Balbir Singh <bsingharora@gmail.com>,
 cascardo@canonical.com, Christophe Leroy <christophe.leroy@c-s.fr>,
 clombard@linux.vnet.ibm.com, david@gibson.dropbear.id.au,
 ego@linux.vnet.ibm.com, fbarrat@linux.vnet.ibm.com, Geert Uytterhoeven
 <geert@linux-m68k.org>, gpiccoli@linux.vnet.ibm.com,
 gwshan@linux.vnet.ibm.com, hamish.martin@alliedtelesis.co.nz,
 hbathini@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com, Laurent Dufour
 <ldufour@linux.vnet.ibm.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 maddy@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 matthew.brown.dev@gmail.com, tcharding <me@tobin.cc>, Masami Hiramatsu
 <mhiramat@kernel.org>, Michael Neuling <mikey@neuling.org>,
 mrochs@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com, Nick Piggin
 <npiggin@gmail.com>, Oliver O'Halloran <oohall@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, rashmica.g@gmail.com, Rob Herring
 <robh@kernel.org>, ruscur@russell.cc, sukadev@linux.vnet.ibm.com,
 tyreld@linux.vnet.ibm.com, vaibhav jain <vaibhav@linux.vnet.ibm.com>,
 vipin@linux.vnet.ibm.com, xinhui.pan@linux.vnet.ibm.com,
 yang.shi@windriver.com, Paul Mackerras <paulus@samba.org>, "Kirill A.
 Shutemov"  <kirill.shutemov@linux.intel.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.12-1 tag
In-Reply-To: <CA+55aFzFm5HcFc20WgFOhm7HM6UZFe+-TVFZfi0kOrHgPLC8Jw@mail.gmail.com>
References: <87k25vh23u.fsf@concordia.ellerman.id.au>
 <CA+55aFzFm5HcFc20WgFOhm7HM6UZFe+-TVFZfi0kOrHgPLC8Jw@mail.gmail.com>
Date: Sat, 06 May 2017 09:12:14 +1000
Message-ID: <87inleaofl.fsf@concordia.ellerman.id.au>
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

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Fri, May 5, 2017 at 6:20 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Also due to a screw-up on my part, we need a hunk added when you merge
>> the powerpc tree with the KVM tree:
>>
>> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
>> index 7807ee17af4b..ffe1da95033a 100644
>> --- a/arch/powerpc/kvm/book3s_xive.c
>> +++ b/arch/powerpc/kvm/book3s_xive.c
>> @@ -24,6 +24,7 @@
>>  #include <asm/xive.h>
>>  #include <asm/xive-regs.h>
>>  #include <asm/debug.h>
>> +#include <asm/debugfs.h>
>>  #include <asm/time.h>
>>  #include <asm/opal.h>
>>
>> I haven't seen a pull request from Paolo yet, so possibly you'll need
>> to add that later when you merge the KVM tree.
>
> Ok. I won't catch this in my allmodconfig build due to the
> ppc-specific nature of it, so I'll probably forget about this and not
> catch it.

Yeah fair enough.

> Paolo, Radim, can you try to remind me about this conflict when you
> send the KVM pull request?

I Cc'ed Paolo, and will try and keep an eye out for the KVM pull request
in case he forgets to mention it.

> Also:
>
>>   - Larger virtual address space on 64-bit server CPUs. By default we
>>     use a 128TB virtual address space, but a process can request access
>>     to the full 512TB by passing a hint to mmap().
>
> I'm assuming/hoping this uses the same logic as the upcoming 47+ bit
> 5-level page table x86 support? Sounds like it, but I didn't check the
> code.
>
> See "x86/mm: Allow to have userspace mappings above 47-bits" which
> hasn't been merged yet, but has been discussed on linux-mm, for
> example.

Yep. We were tracking that discussion, and made changes to make our
semantics match x86.

If anything changes on the x86 side before it merges we can update our
code to match, hopefully prior to 4.12 releasing.

There's also a selftest for the mmap behaviour, written by one of our
guys, which is coming via mm I think, so that should help make sure the
semantics match.

cheers
