Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205]) by ozlabs.org (Postfix) with ESMTP id 414BF140096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 15:17:01 +1000 (EST)
Message-ID: <5372FC43.6010707@roeck-us.net>
Date: Tue, 13 May 2014 22:16:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: powerpc/ppc64: Allow allmodconfig to build (finally !)
References: <1399874254.17624.85.camel@pasglop>	<20140513002846.GA29753@roeck-us.net>	<1399972601.17624.169.camel@pasglop>	<20140513171749.GA9440@roeck-us.net>
 <20140514133434.13b66009@canb.auug.org.au>
In-Reply-To: <20140514133434.13b66009@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Alan Modra <amodra@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/13/2014 08:34 PM, Stephen Rothwell wrote:
> Hi Guenter,
>
> On Tue, 13 May 2014 10:17:49 -0700 Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Tue, May 13, 2014 at 07:16:41PM +1000, Benjamin Herrenschmidt wrote:
>>> On Mon, 2014-05-12 at 17:28 -0700, Guenter Roeck wrote:
>>>
>>>> After applying this patch, I get
>>>>
>>>> arch/powerpc/kernel/exceptions-64s.S:269: Error: operand out of range
>>>> (0x000000000000814c is not between 0xffffffffffff8000 and 0x0000000000007ffc)
>>>> arch/powerpc/kernel/exceptions-64s.S:729: Error: operand out of range
>>>> (0x000000000000814c is not between 0xffffffffffff8000 and 0x0000000000007ffc)
>>>>
>>>> with powerpc:defconfig, powerpc:allmodconfig, powerpc:cell_defconfig, and
>>>> powerpc:maple_defconfig.
>>>>
>>>> This is on top of v3.15-rc5. Any idea what is going on ?
>>>>
>>>> Compiler is powerpc64-poky-linux-gcc (GCC) 4.7.2 (from poky 1.4.0-1).
>>>
>>> Interesting... works with all my test configs using 4.7.3...
>>>
>>> I don't have my tree at hand right now, I'll check what that means
>>> tomorrow see if I can find a workaround.
>>>
>> It works for me with gcc 4.8.2 (build from yocto 1.6.0).
>>
>> Is asking people to use gcc 4.7.3 or later acceptable ?
>
> OK, this appears to be an assembler bug.
>
> $ cat test.s
> 	.text
> x:
> 	.pushsection	b, "a"
> 	beq y
> 	.popsection
> 	.=0x80000
> y:
> $ /opt/cross/gcc-4.6.3-nolibc/powerpc64-linux/bin/powerpc64-linux-as --version
> GNU assembler (GNU Binutils) 2.22
> This assembler was configured for a target of `powerpc64-linux'.
> $ /opt/cross/gcc-4.6.3-nolibc/powerpc64-linux/bin/powerpc64-linux-as -o test.o test.s
> test.s: Assembler messages:
> test.s:4: Error: operand out of range (0x0000000000080000 is not between 0xffffffffffff8000 and 0x0000000000007ffc)
> $ /opt/cross/gcc-4.8.1-nolibc/powerpc64-linux/bin/powerpc64-linux-as --version
> GNU assembler (GNU Binutils) 2.23.52.20130512
> This assembler was configured for a target of `powerpc64-linux'.
> $ /opt/cross/gcc-4.8.1-nolibc/powerpc64-linux/bin/powerpc64-linux-as -o test.o test.s
> (no error)
>
> Alan, can you shed light on when it was fixed?
>

Hi Stephen,

any idea what might cause this one, by any chance ?

arch/powerpc/kernel/built-in.o: In function `exc_debug_crit_book3e':
(.text+0x165ee): relocation truncated to fit: R_PPC64_ADDR16_HI against symbol `interrupt_base_book3e' defined in .text section in arch/powerpc/kernel/built-in.o
arch/powerpc/kernel/built-in.o: In function `exc_debug_crit_book3e':
(.text+0x16602): relocation truncated to fit: R_PPC64_ADDR16_HI against symbol `interrupt_end_book3e' defined in .text section in arch/powerpc/kernel/built-in.o
arch/powerpc/kernel/built-in.o: In function `exc_debug_debug_book3e':

I see this if I try to build powerpc:ppc64e_defconfig or powerpc:chroma_defconfig
with gcc 4.8.2 and binutils 2.24.

Thanks,
Guenter
