Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DC5CF1400E0
 for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2014 18:27:23 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 15 May 2014 13:57:21 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 27C2BE0053
 for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2014 13:57:52 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4F8RQ7C45875426
 for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2014 13:57:26 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4F8RGbg024605
 for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2014 13:57:17 +0530
Message-ID: <537479FD.2010200@linux.vnet.ibm.com>
Date: Thu, 15 May 2014 13:55:33 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Pedro Alves <palves@redhat.com>
Subject: Re: [PATCH V2 2/3] powerpc, ptrace: Enable support for transactional
 memory register sets
References: <1399276469-13541-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1399276469-13541-3-git-send-email-khandual@linux.vnet.ibm.com>
 <537252C0.6090005@redhat.com> <53730326.6000400@linux.vnet.ibm.com>
 <53735044.5030008@redhat.com>
In-Reply-To: <53735044.5030008@redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, avagin@openvz.org, linux-kernel@vger.kernel.org,
 oleg@redhat.com, michael@ellerman.id.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/14/2014 04:45 PM, Pedro Alves wrote:
> On 05/14/14 06:46, Anshuman Khandual wrote:
>> On 05/13/2014 10:43 PM, Pedro Alves wrote:
>>> On 05/05/14 08:54, Anshuman Khandual wrote:
>>>> This patch enables get and set of transactional memory related register
>>>> sets through PTRACE_GETREGSET/PTRACE_SETREGSET interface by implementing
>>>> four new powerpc specific register sets i.e REGSET_TM_SPR, REGSET_TM_CGPR,
>>>> REGSET_TM_CFPR, REGSET_CVMX support corresponding to these following new
>>>> ELF core note types added previously in this regard.
>>>>
>>>> 	(1) NT_PPC_TM_SPR
>>>> 	(2) NT_PPC_TM_CGPR
>>>> 	(3) NT_PPC_TM_CFPR
>>>> 	(4) NT_PPC_TM_CVMX
>>>
>>> Sorry that I couldn't tell this from the code, but, what does the
>>> kernel return when the ptracer requests these registers and the
>>> program is not in a transaction?  Specifically I'm wondering whether
>>> this follows the same semantics as the s390 port.
>>>
>>
>> Right now, it still returns the saved state of the registers from thread
>> struct. I had assumed that the user must know the state of the transaction
>> before initiating the ptrace request. I guess its better to check for
>> the transaction status before processing the request. In case if TM is not
>> active on that thread, we should return -EINVAL.
> 
> I think s390 returns ENODATA in that case.
> 
>  https://sourceware.org/ml/gdb-patches/2013-06/msg00273.html
> 
> We'll want some way to tell whether the system actually
> supports this.  That could be ENODATA vs something-else (EINVAL
> or perhaps better EIO for "request is invalid").

As Mickey has pointed out, the transaction memory support in the system can be
checked from the HWCAP2 flags. So when the transaction is not active, we will
return ENODATA instead for TM related ptrace regset requests.
