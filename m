Return-Path: <cbf123@mail.usask.ca>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CB8152C036E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jul 2013 09:40:52 +1000 (EST)
Message-ID: <51E093F9.6050303@mail.usask.ca>
Date: Fri, 12 Jul 2013 17:40:41 -0600
From: Chris Friesen <cbf123@mail.usask.ca>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: error compiling ptrace in current mainline git
References: <51E02E7D.5050304@mail.usask.ca>
 <20130712223141.GA14807@thor.bakeyournoodle.com>
In-Reply-To: <20130712223141.GA14807@thor.bakeyournoodle.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/12/2013 04:31 PM, Tony Breeds wrote:
> On Fri, Jul 12, 2013 at 10:27:41AM -0600, Chris Friesen wrote:
>> Hi all,
>>
>> I'm trying to build current mainline git with gcc version 4.4.1 as a
>> cross compiler and I'm getting the following:
>>
>>
>>    CC      arch/powerpc/kernel/ptrace.o
>> {standard input}: Assembler messages:
>> {standard input}:1619: Error: junk at end of line: `1'
>
> <snip>
>
>> Any ideas on how to deal with this?  Is this a code error or a
>> compiler error?
>
> It could be either can you:
> a) try the 4.6.3 cross compiler from: https://www.kernel.org/pub/tools/crosstool/
> b) Try a ppc64_defconfig build.
>
> If the newer compiler with your .config fixes it it's a compiler issue.
> If chaning the config with you 4.4.1 compiler fixes it please post you
> .config to see if we can work out what's going on.

I used the 4.6.3 cross compiler for x86_64 from the above location.  It 
seems to be able to build arch/powerpc/kernel/ptrace.c, but then it 
gives a different error:

   CC      arch/powerpc/kernel/epapr_paravirt.o
   AS      arch/powerpc/kernel/epapr_hcalls.o
   CC      arch/powerpc/kernel/prom_init.o
   AS      arch/powerpc/kernel/head_64.o
/tmp/ccnAw2ZB.s: Assembler messages:
/tmp/ccnAw2ZB.s: Internal error, aborting at 
/home/tony/buildall/src/binutils/gas/config/tc-ppc.c line 6351 in 
md_apply_fix
Please report this bug.
make[2]: *** [arch/powerpc/kernel/head_64.o] Error 1

> Also when you say "current mainline git" I assume you mean the HEAD of
> linus's tree not Ben's right?

Yes, that's correct.

Chris
