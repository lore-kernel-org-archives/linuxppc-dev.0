Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjCsc73DCzDqw2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 22:57:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
 Chandan Rajendra <chandan@linux.vnet.ibm.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>
Subject: Re: syscall statx not implemented on powerpc
In-Reply-To: <6226603a58ba485391854ba231193741@svr-chch-ex1.atlnz.lc>
References: <7dba3a5469d34ac3890a5eaa16822a75@svr-chch-ex1.atlnz.lc>
 <4396749.JbYdqAFZXV@localhost.localdomain>
 <6226603a58ba485391854ba231193741@svr-chch-ex1.atlnz.lc>
Date: Tue, 14 Mar 2017 22:57:39 +1100
Message-ID: <87o9x4ul3g.fsf@concordia.ellerman.id.au>
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

> On 13/03/17 21:52, Chandan Rajendra wrote:
>> On Monday, March 13, 2017 03:33:07 AM Chris Packham wrote:
>>> Hi,
>>>
>>> I've just attempted to build a powerpc kernel from 4.11-rc2 using a
>>> custom defconfig (available on request) and I'm hitting the following
>>> error in the early stages of compilation.
>>>
>>> <stdin>:1325:2: error: #warning syscall statx not implemented [-Werror=cpp]
>>>
>>> Same thing seems to happen with mpc85xx_basic_defconfig.
>>>
>>> I don't actually need this syscall so I'd be happy to turn something off
>>> to get things building. I did a quick search and couldn't see anything
>>> on linuxppc-dev but google keeps correcting "statx" to "stats" so I
>>> could have missed it.
>>>
>>
>> The upstream commit
>> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a528d35e8bfcc521d7cb70aaf03e1bd296c8493f)
>> that introduces the statx syscall provides a test program. I will wire-up the
>> syscall on ppc64, run that test program and post the patch if the test program
>> works well.
>>
>
> Thanks, I'd be happy to test a patch here.
>
> In the meantime I worked around the build issue by adding __INGORE_statx 
> to checksyscalls.sh.

Is it actually breaking the build? It's meant to be a warning, and
that's all I get.

cheers
