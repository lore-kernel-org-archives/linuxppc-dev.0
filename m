Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVfkQ1DqWzDrp7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 11:29:18 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Build regression introduced by
 31cdd0c39c7544ced79da53aa0b7e989f3a39582
In-Reply-To: <20160907012356.GA21443@fergus.ozlabs.ibm.com>
References: <829134bc-381a-7f45-a99a-0b7e66642246@physik.fu-berlin.de>
 <20160907012356.GA21443@fergus.ozlabs.ibm.com>
Date: Fri, 09 Sep 2016 11:29:14 +1000
Message-ID: <87a8fhlv2t.fsf@concordia.ellerman.id.au>
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

Paul Mackerras <paulus@ozlabs.org> writes:

> On Tue, Sep 06, 2016 at 11:01:02PM +0200, John Paul Adrian Glaubitz wrote:
>> Hi Paul!
>> 
>> I'm referring to your change [1]:
>> 
>> "powerpc/xmon: Fix SPR read/write commands and add command to dump SPRs"
>> 
>> which introduced assembly code in the new file arch/powerpc/xmon/spr_access.S.
>> 
>> Unfortunately, this code contains assembly instructions which are not available on
>> all ppc targets. In particular, this change breaks the build on PPC e500v2 targets,
>> see the corresponding Debian bug report [2].
>> 
>> Could you have a look and possibly add some guarding #ifdefs for the ppc targets
>> where "ld" is not a supported instruction?
>
> I blame Michael. :)  My original version of the patch didn't have the
> ld instructions, and then Michael did a v2 that was different.  He
> didn't update the patch description so I don't know exactly why he
> changed that.  I'll discuss it with him.

Yep my fault. I changed the code to load the address of the SPR table
from the TOC, and just used ld without thinking.

Interestingly it builds fine for me, even for 32-bit configs, I assume
because my toolchains are 32/64-bit they are able to cope with it. I'll
try and built a 32-bit only toolchain to catch these problems in future.

cheers
