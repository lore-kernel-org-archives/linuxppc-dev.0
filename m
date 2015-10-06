Return-Path: <labbott@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C2EC1A0017
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 05:26:05 +1100 (AEDT)
Subject: Re: Missing operand for tlbie instruction on Power7
To: Michael Ellerman <mpe@ellerman.id.au>
References: <560EA623.1040300@redhat.com>
 <1444102518.16909.3.camel@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <56141237.2040403@redhat.com>
Date: Tue, 6 Oct 2015 11:25:59 -0700
MIME-Version: 1.0
In-Reply-To: <1444102518.16909.3.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/05/2015 08:35 PM, Michael Ellerman wrote:
> On Fri, 2015-10-02 at 08:43 -0700, Laura Abbott wrote:
>> Hi,
>>
>> We received a report (https://bugzilla.redhat.com/show_bug.cgi?id=1267395) of bad assembly
>> when compiling on powerpc with little endian
>
> ...
>
>> After some discussion with the binutils folks, it turns out that the tlbie
>> instruction actually requires another operand and binutils was updated to
>> check for this https://sourceware.org/ml/binutils/2015-05/msg00133.html .
>>
>> The code sequence in arch/powerpc/include/asm/ppc_asm.h now needs to be updated:
>>
>> #if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
>> #define tlbia                                   \
>>           li      r4,1024;                        \
>>           mtctr   r4;                             \
>>           lis     r4,KERNELBASE@h;                \
>> 0:      tlbie   r4;                             \
>>           addi    r4,r4,0x1000;                   \
>>           bdnz    0b
>> #endif
>>
>> I don't know enough ppc assembly to properly fix this but I can test.
>
> How are you testing? This code is fairly old and I'm dubious if it still works.
>
> These days we have a ppc_md hook for flushing the TLB, ppc_md.flush_tlb().
> Ideally the swsusp code would use that.
>
> cheers
>
>

Testing would probably just be compile and maybe boot. I don't have regular
access to the hardware. This problem just showed up for me when someone
tried to compile Fedora rawhide with the latest binutils.

 From what I can tell, it looks like the .flush_tlb of the cpu_spec is only
defined for power7 and power8 and I don't see a ppc_md.flush_tlb on the
master branch. It's not clear what to do for the case where there is no
flush_tlb function. Would filling in a .flush_tlb for all the PPC_BOOK3S_64
with the existing tlbia sequence work? It's also worth noting that the
__flush_power7 uses tlbiel instead of tlbie.

Thanks,
Laura
