Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjX554f4lzDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 11:08:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
 Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>
Subject: Re: syscall statx not implemented on powerpc
In-Reply-To: <67f921484d2e42a8975361e821a4b2a7@svr-chch-ex1.atlnz.lc>
References: <7dba3a5469d34ac3890a5eaa16822a75@svr-chch-ex1.atlnz.lc>
 <4396749.JbYdqAFZXV@localhost.localdomain>
 <6226603a58ba485391854ba231193741@svr-chch-ex1.atlnz.lc>
 <87o9x4ul3g.fsf@concordia.ellerman.id.au>
 <67f921484d2e42a8975361e821a4b2a7@svr-chch-ex1.atlnz.lc>
Date: Wed, 15 Mar 2017 11:08:38 +1100
Message-ID: <87fuifv1tl.fsf@concordia.ellerman.id.au>
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

Chris Packham <Chris.Packham@alliedtelesis.co.nz> writes:

> On 15/03/17 00:57, Michael Ellerman wrote:
>> Chris Packham <Chris.Packham@alliedtelesis.co.nz> writes:
>>> On 13/03/17 21:52, Chandan Rajendra wrote:
>>>> On Monday, March 13, 2017 03:33:07 AM Chris Packham wrote:
>>>>> I've just attempted to build a powerpc kernel from 4.11-rc2 using a
>>>>> custom defconfig (available on request) and I'm hitting the following
>>>>> error in the early stages of compilation.
>>>>>
>>>>> <stdin>:1325:2: error: #warning syscall statx not implemented [-Werror=cpp]
>>>>>
>>>>> Same thing seems to happen with mpc85xx_basic_defconfig.
>>>>>
>>>>> I don't actually need this syscall so I'd be happy to turn something off
>>>>> to get things building. I did a quick search and couldn't see anything
>>>>> on linuxppc-dev but google keeps correcting "statx" to "stats" so I
>>>>> could have missed it.
>>>>
>>>> The upstream commit
>>>> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a528d35e8bfcc521d7cb70aaf03e1bd296c8493f)
>>>> that introduces the statx syscall provides a test program. I will wire-up the
>>>> syscall on ppc64, run that test program and post the patch if the test program
>>>> works well.
>>>
>>> Thanks, I'd be happy to test a patch here.
>>>
>>> In the meantime I worked around the build issue by adding __INGORE_statx
>>> to checksyscalls.sh.
>>
>> Is it actually breaking the build? It's meant to be a warning, and
>> that's all I get.
>
> It breaks my builds for ppc and arm. We do have KCFLAGS=-Werror in our 
> environment but KCPPFLAGS= is not set so I'm not sure why it's stopping 
> compilation.

OK, I guess that must be it.

We turn on -Werror for all of arch/powerpc by default (unless
CONFIG_PPC_DISABLE_WERROR=y), but the syscall checking script is not
under arch/powerpc so shouldn't be affected by that.

cheers
