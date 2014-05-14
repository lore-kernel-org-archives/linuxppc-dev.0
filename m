Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E509F1400DD
 for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2014 15:48:05 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 14 May 2014 15:48:04 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id BA17E2CE8052
 for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2014 15:47:59 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4E5liFa11075842
 for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2014 15:47:44 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4E5lxkL031188
 for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2014 15:47:59 +1000
Message-ID: <53730326.6000400@linux.vnet.ibm.com>
Date: Wed, 14 May 2014 11:16:14 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Pedro Alves <palves@redhat.com>
Subject: Re: [PATCH V2 2/3] powerpc, ptrace: Enable support for transactional
 memory register sets
References: <1399276469-13541-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1399276469-13541-3-git-send-email-khandual@linux.vnet.ibm.com>
 <537252C0.6090005@redhat.com>
In-Reply-To: <537252C0.6090005@redhat.com>
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

On 05/13/2014 10:43 PM, Pedro Alves wrote:
> On 05/05/14 08:54, Anshuman Khandual wrote:
>> This patch enables get and set of transactional memory related register
>> sets through PTRACE_GETREGSET/PTRACE_SETREGSET interface by implementing
>> four new powerpc specific register sets i.e REGSET_TM_SPR, REGSET_TM_CGPR,
>> REGSET_TM_CFPR, REGSET_CVMX support corresponding to these following new
>> ELF core note types added previously in this regard.
>>
>> 	(1) NT_PPC_TM_SPR
>> 	(2) NT_PPC_TM_CGPR
>> 	(3) NT_PPC_TM_CFPR
>> 	(4) NT_PPC_TM_CVMX
> 
> Sorry that I couldn't tell this from the code, but, what does the
> kernel return when the ptracer requests these registers and the
> program is not in a transaction?  Specifically I'm wondering whether
> this follows the same semantics as the s390 port.
> 

Right now, it still returns the saved state of the registers from thread
struct. I had assumed that the user must know the state of the transaction
before initiating the ptrace request. I guess its better to check for
the transaction status before processing the request. In case if TM is not
active on that thread, we should return -EINVAL.

I am not familiar with the s390 side of code. But if we look at the
s390_tdb_get function it checks for (regs->int_code & 0x200) before
processing the request. Not sure what 0x200 signifies though.
