Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 4CEA41A032F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Feb 2016 20:33:23 +1100 (AEDT)
Subject: Re: [PATCH v5] powerpc32: provide VIRT_CPU_ACCOUNTING
To: Denis Kirjanov <kda@linux-powerpc.org>
References: <20160211161650.1F12C1A2400@localhost.localdomain>
 <CAOJe8K0VJM8VEEN2i+ufV0YjSrRYHO+o7k3Tiv=va9LnH02R7w@mail.gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <56C19B5F.70801@c-s.fr>
Date: Mon, 15 Feb 2016 10:33:19 +0100
MIME-Version: 1.0
In-Reply-To: <CAOJe8K0VJM8VEEN2i+ufV0YjSrRYHO+o7k3Tiv=va9LnH02R7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 14/02/2016 21:40, Denis Kirjanov a écrit :
> On 2/11/16, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>> This patch provides VIRT_CPU_ACCOUTING to PPC32 architecture.
>> PPC32 doesn't have the PACA structure, so we use the task_info
>> structure to store the accounting data.
>>
>> In order to reuse on PPC32 the PPC64 functions, all u64 data has
>> been replaced by 'unsigned long' so that it is u32 on PPC32 and
>> u64 on PPC64
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Doesn't build for me with the patch applied
>
> To see full details build your kernel with:
> 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
>    GEN     .version
>    CHK     include/generated/compile.h
>    UPD     include/generated/compile.h
>    CC      init/version.o
>    LD      init/built-in.o
> drivers/built-in.o: In function `get_cpu_idle_time':
> (.text+0x1261c4): undefined reference to `__umoddi3'
> drivers/built-in.o: In function `get_cpu_idle_time':
> (.text+0x1261e0): undefined reference to `__udivdi3'
> Makefile:936: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
>
>
Looks like you have CONFIG_CPU_FREQ, which I don't have.

The issue comes from the jiffies64_to_cputime64() defined in 
arch/powerpc/include/asm/cputime.h :

static inline cputime64_t jiffies64_to_cputime64(const u64 jif)
{
         u64 ct;
         u64 sec;

         /* have to be a little careful about overflow */
         ct = jif % HZ;
         sec = jif / HZ;



On 32 bits, 64 bits % and / require __udivdi3() and __umoddi3(), which 
are not implemented in the kernel.

As HZ fits in 32 bits, the solution is to use do_div(). I should not 
change anything on PPC64 and would solve your issue.
I will submit an update of the patch within an hour.

Christophe
