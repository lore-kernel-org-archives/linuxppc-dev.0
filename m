Return-Path: <labbott@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A3A371A0017
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 08:12:12 +1000 (AEST)
Subject: Re: Missing operand for tlbie instruction on Power7
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Denis Kirjanov <kda@linux-powerpc.org>
References: <560EA623.1040300@redhat.com>
 <CAOJe8K1gQFRakYVWPYe0j9+Zc+s9hqB7uFF_aZh9NwCZSfTB_w@mail.gmail.com>
 <1443816930.13186.214.camel@otta>
 <CAOJe8K2GOsBk=CcWaZqq9KN=McLad97BP6ZhEdRB7i2Ag4csOg@mail.gmail.com>
 <20151002220051.GA26712@gate.crashing.org>
Cc: Peter Bergner <bergner@vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Paul Mackerras <paulus@samba.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <560F0138.8050802@redhat.com>
Date: Fri, 2 Oct 2015 15:12:08 -0700
MIME-Version: 1.0
In-Reply-To: <20151002220051.GA26712@gate.crashing.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/02/2015 03:00 PM, Segher Boessenkool wrote:
> On Sat, Oct 03, 2015 at 12:37:35AM +0300, Denis Kirjanov wrote:
>>>> -0:     tlbie   r4;                             \
>>>> +0:     tlbie   r4, 0;                          \
>>>
>>> This isn't correct.  With POWER7 and later (which this compile
>>> is, since it's on LE), the tlbie instruction takes two register
>>> operands:
>>>
>>>      tlbie RB, RS
>>>
>>> The tlbie instruction on pre POWER7 cpus had one required register
>>> operand (RB) and an optional second L operand, where if you omitted
>>> it, it was the same as using "0":
>>>
>>>      tlbie RB, L
>>>
>>> This is a POWER7 and later build, so your change which adds the "0"
>>> above is really adding r0 for RS.  The new tlbie instruction doesn't
>>> treat r0 specially, so you'll be using whatever random bits which
>>> happen to be in r0 which I don't think that is what you want.
>>
>> Ok, than we can just zero out r5 for example and use it in tlbie as RS,
>> right?
>
> That won't assemble _unless_ your assembler is in POWER7 mode.  It also
> won't do the right thing at run time on older machines.
>
> Where is this tlbia macro used at all, for 64-bit machines?
>


[labbott@labbott-redhat-machine linux_upstream]$ make ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu-
   CHK     include/config/kernel.release
   CHK     include/generated/uapi/linux/version.h
   CHK     include/generated/utsrelease.h
   CHK     include/generated/bounds.h
   CHK     include/generated/timeconst.h
   CHK     include/generated/asm-offsets.h
   CALL    scripts/checksyscalls.sh
   CHK     include/generated/compile.h
   CALL    arch/powerpc/kernel/systbl_chk.sh
   AS      arch/powerpc/kernel/swsusp_asm64.o
arch/powerpc/kernel/swsusp_asm64.S: Assembler messages:
arch/powerpc/kernel/swsusp_asm64.S:188: Error: missing operand
scripts/Makefile.build:294: recipe for target 'arch/powerpc/kernel/swsusp_asm64.o' failed
make[1]: *** [arch/powerpc/kernel/swsusp_asm64.o] Error 1
Makefile:941: recipe for target 'arch/powerpc/kernel' failed
make: *** [arch/powerpc/kernel] Error 2

This is piece of code protected by CONFIG_PPC_BOOK3S_64.
  
>
> Segher
>
