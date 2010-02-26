Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9A714B7C59
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2010 00:10:39 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id o1R0AdGF023152
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2010 11:10:39 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1QD5BBG1319042
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2010 00:05:11 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1QDAcqV007184
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2010 00:10:39 +1100
Message-ID: <4B87C84C.9020405@in.ibm.com>
Date: Fri, 26 Feb 2010 18:40:36 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix lwsync feature fixup vs. modules on 64-bit
References: <1267169407.23523.1798.camel@pasglop>
In-Reply-To: <1267169407.23523.1798.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> Anton's commit enabling the use of the lwsync fixup mechanism on 64-bit
> breaks modules. The lwsync fixup section uses .long instead of the
> FTR_ENTRY_OFFSET macro used by other fixups sections, and thus will
> generate 32-bit relocations that our module loader cannot resolve.
>
> This changes it to use the same type as other feature sections.
>
> Note however that we might want to consider using 32-bit for all the
> feature fixup offsets and add support for R_PPC_REL32 to module_64.c
> instead as that would reduce the size of the kernel image. I'll leave
> that as an exercise for the reader for now...
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/include/asm/feature-fixups.h |    2 +-
>  arch/powerpc/lib/feature-fixups.c         |    3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>   
Thanks for the patch Ben.

I can boot -next on my power boxes with it.

thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
