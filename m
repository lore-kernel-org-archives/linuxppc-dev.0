Return-Path: <palves@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 20AB5140080
 for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2014 21:15:29 +1000 (EST)
Message-ID: <53735044.5030008@redhat.com>
Date: Wed, 14 May 2014 12:15:16 +0100
From: Pedro Alves <palves@redhat.com>
MIME-Version: 1.0
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Pedro Alves <palves@redhat.com>
Subject: Re: [PATCH V2 2/3] powerpc, ptrace: Enable support for transactional
 memory register sets
References: <1399276469-13541-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1399276469-13541-3-git-send-email-khandual@linux.vnet.ibm.com>
 <537252C0.6090005@redhat.com> <53730326.6000400@linux.vnet.ibm.com>
In-Reply-To: <53730326.6000400@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mikey@neuling.org, avagin@openvz.org, oleg@redhat.com,
 linux-kernel@vger.kernel.org, michael@ellerman.id.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/14/14 06:46, Anshuman Khandual wrote:
> On 05/13/2014 10:43 PM, Pedro Alves wrote:
>> On 05/05/14 08:54, Anshuman Khandual wrote:
>>> This patch enables get and set of transactional memory related register
>>> sets through PTRACE_GETREGSET/PTRACE_SETREGSET interface by implementing
>>> four new powerpc specific register sets i.e REGSET_TM_SPR, REGSET_TM_CGPR,
>>> REGSET_TM_CFPR, REGSET_CVMX support corresponding to these following new
>>> ELF core note types added previously in this regard.
>>>
>>> 	(1) NT_PPC_TM_SPR
>>> 	(2) NT_PPC_TM_CGPR
>>> 	(3) NT_PPC_TM_CFPR
>>> 	(4) NT_PPC_TM_CVMX
>>
>> Sorry that I couldn't tell this from the code, but, what does the
>> kernel return when the ptracer requests these registers and the
>> program is not in a transaction?  Specifically I'm wondering whether
>> this follows the same semantics as the s390 port.
>>
> 
> Right now, it still returns the saved state of the registers from thread
> struct. I had assumed that the user must know the state of the transaction
> before initiating the ptrace request. I guess its better to check for
> the transaction status before processing the request. In case if TM is not
> active on that thread, we should return -EINVAL.

I think s390 returns ENODATA in that case.

 https://sourceware.org/ml/gdb-patches/2013-06/msg00273.html

We'll want some way to tell whether the system actually
supports this.  That could be ENODATA vs something-else (EINVAL
or perhaps better EIO for "request is invalid").

s390 actually screwed that, though it got away because
there's a bit in HWCAP to signal transactions support.  See:

 https://sourceware.org/ml/gdb-patches/2013-11/msg00080.html

Are you adding something to HWCAP too?

> 
> I am not familiar with the s390 side of code. But if we look at the
> s390_tdb_get function it checks for (regs->int_code & 0x200) before
> processing the request. Not sure what 0x200 signifies though.

-- 
Pedro Alves
