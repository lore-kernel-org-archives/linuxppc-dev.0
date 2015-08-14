Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28BE41A1DA8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 15:36:14 +1000 (AEST)
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E9F50140216
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 15:36:13 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 14 Aug 2015 15:36:11 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 229FF2BB0057
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 15:36:10 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7E5a2ii66978016
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 15:36:10 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7E5ZaNJ025260
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Aug 2015 15:35:37 +1000
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, mpe <mpe@ellerman.id.au>,
 benh <benh@kernel.crashing.org>, cyrilbur <cyrilbur@gmail.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 Manoj Kumar <kumarmn@us.ibm.com>, mikey <mikey@neuling.org>
Subject: Re: [PATCH v4 03/11] cxl: Allocate and release the SPA with the AFU
In-reply-to: <1439439089-25151-4-git-send-email-dja@axtens.net>
References: <1439439089-25151-1-git-send-email-dja@axtens.net>
 <1439439089-25151-4-git-send-email-dja@axtens.net>
Date: Fri, 14 Aug 2015 15:35:10 +1000
Message-Id: <1439529915-sup-2035@delenn.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Excerpts from Daniel Axtens's message of 2015-08-13 14:11:21 +1000:
> Previously the SPA was allocated and freed upon entering and leaving
> AFU-directed mode. This causes some issues for error recovery - contexts
> hold a pointer inside the SPA, and they may persist after the AFU has
> been detached.
> 
> We would ideally like to allocate the SPA when the AFU is allocated, and
> release it until the AFU is released. However, we don't know how big the
> SPA needs to be until we read the AFU descriptor.
> 
> Therefore, restructure the code:
> 
>  - Allocate the SPA only once, on the first attach.
> 
>  - Release the SPA only when the entire AFU is being released (not
>    detached). Guard the release with a NULL check, so we don't free
>    if it was never allocated (e.g. dedicated mode)

This is certainly an improvement, though in the long run I wonder if we
should consider making the contexts increase the refcount of the AFU so
that we can be sure that the AFU structure will outlive the contexts?

That would be a more significant rework though, and this patch is needed
either way and solves an immediate problem, so:

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
