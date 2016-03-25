Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qWqjR171bzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 04:16:58 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Sat, 26 Mar 2016 03:16:57 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E610A2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 04:16:53 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2PHGjJY55509022
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 04:16:53 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2PHGKZj023232
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 04:16:21 +1100
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: cxl: fix setting of _PAGE_USER bit when handling page faults
In-reply-to: <3qWf364wYxz9sDG@ozlabs.org>
References: <3qWf364wYxz9sDG@ozlabs.org>
Date: Fri, 25 Mar 2016 12:15:49 -0500
Message-Id: <1458925788-sup-2032@x230.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Michael Ellerman's message of 2016-03-25 05:01:38 -0500:
> I think you can (should) use is_kernel_addr() for the DAR check.
> 
> I'm also slightly worried by that logic in the case of a non-kernel context.
> 
> ie. if ctx->kernel is false, we get:
> 
>     if (true || !is_kernel_addr(dar))
>          access |= _PAGE_USER;
> 
> Which means we just add _PAGE_USER for any address. What am I missing here?

It's been ages since I did a deep dive on the related mm code, so I
don't recall the precise details so take this with a grain of salt, but
if memory serves the call to copro_handle_mm_fault will fail if a user
is trying to access a kernel region since it won't be mapped in the mm.

-Ian
