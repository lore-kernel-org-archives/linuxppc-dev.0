Return-Path: <sam.mj@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 928131A1D3B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 16:13:53 +1000 (AEST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6AC3A14031D
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 16:13:53 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.mj@au1.ibm.com>;
 Tue, 28 Jul 2015 16:13:51 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 28C9F2CE8054
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 16:13:50 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6S6Dc5s28246092
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 16:13:46 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6S6DHAo007542
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 16:13:17 +1000
Reply-To: sam.mj@au1.ibm.com
Subject: Re: [RFC PATCH] powerpc/kexec: Wait 1s for secondaries to enter OPAL
References: <1437544469-20028-1-git-send-email-sam.mj@au1.ibm.com>
 <m3r3nukut9.fsf@oc8180480414.ibm.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Message-ID: <55B71D89.7000308@au1.ibm.com>
Date: Tue, 28 Jul 2015 16:13:29 +1000
MIME-Version: 1.0
In-Reply-To: <m3r3nukut9.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/07/15 15:56, Stewart Smith wrote:
> Samuel Mendoza-Jonas <sam.mj@au1.ibm.com> writes:
>> Always include a timeout when waiting for secondary cpus to enter OPAL
>> in the kexec path, rather than only when crashing.
> 
> This *sounds* reasonable... but I wonder what actual worse case could
> be and why we'd get stuck too long waiting for things?
> 
> What was the original bug/problem that inspired this patch?
> 
> and is 1s enough?

"It sounds reasonable" was more or less the inspiration :)
While I was going over some of the code relating to the previous kexec
fix with Ben he pointed this out and suggested there wasn't
much of a reason to differentiate between a crashing/non-crashing
cpu as far as the timeout goes - if we're not 'crashing' we still
don't want to spin forever.

I'll let Ben comment on whether 1s per cpu is enough.

> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 


-- 
-----------
LTC Ozlabs
IBM
