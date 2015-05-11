Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 08A5A1A0010
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 21:53:48 +1000 (AEST)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 11 May 2015 12:53:45 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0EF692190056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 12:53:24 +0100 (BST)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com
 [9.149.37.217])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4BBrgKO6095202
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 11:53:42 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4B6lfVO004762
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 02:47:41 -0400
Message-ID: <55509844.7010304@linux.vnet.ibm.com>
Date: Mon, 11 May 2015 13:53:40 +0200
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Enabling sys_kcmp for CRIU
References: <20150511103115.DFE85140187@ozlabs.org>
In-Reply-To: <20150511103115.DFE85140187@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/05/2015 12:31, Michael Ellerman wrote:
> On Tue, 2015-05-05 at 15:30:21 UTC, Laurent Dufour wrote:
>> The commit 8170a83f15ee ("powerpc: Wireup the kcmp syscall to sys_ni") has
>> disabled the kcmp syscall for powerpc.  This has been done due to the use
>> of unsigned long parameters which may require a dedicated wrapper to handle
>> 32bit process on top of 64bit kernel.  However in the kcmp() case, the 2
>> unsigned long parameters are currently only used to carry file descriptors
>> from user space to the kernel.  Since such a parameter is passed through
>> register, and file descriptor doesn't need to get extended, there is,
>> today, no need for a wrapper.
>>
>> In the case there will be a need to pass address in or out of this system
>> call, then a wrapper could be required, it will then be to care of it.
>>
>> As today this is not the case, it is safe to enable kcmp() on powerpc.
> 
> That's mostly convincing. Though I see that s390 does have a compat wrapper,
> i386 doesn't. So who knows what that means.
> 
> But, there's a selftest in tools/testing/selftests/kcmp. So can you run that as
> 32-bit and confirm it works? Then I'd be 100% convinced :)

Hi Michael,

I was myself a bit confused about this system call, so to be sure before
sending the patch I ran the selftest/kcmp series on 64bit, 32bit, and
also build it in 32bit and run it on top of a 64bit kernel without any
trouble...

Cheers,
Laurent.
