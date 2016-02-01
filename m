Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 176DC1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 16:55:32 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 1 Feb 2016 15:55:31 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C435F3578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 16:55:25 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u115t7h246923964
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 16:55:15 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u115srHQ006243
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 1 Feb 2016 16:54:53 +1100
Message-ID: <56AEF315.3020109@linux.vnet.ibm.com>
Date: Mon, 01 Feb 2016 11:24:29 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org
CC: aik@ozlabs.ru, lvivier@redhat.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFCv2 2/9] arch/powerpc: Clean up error handling for
 htab_remove_mapping
References: <1454045043-25545-1-git-send-email-david@gibson.dropbear.id.au>
 <1454045043-25545-3-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1454045043-25545-3-git-send-email-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/29/2016 10:53 AM, David Gibson wrote:
> Currently, the only error that htab_remove_mapping() can report is -EINVAL,
> if removal of bolted HPTEs isn't implemeted for this platform.  We make
> a few clean ups to the handling of this:
> 
>  * EINVAL isn't really the right code - there's nothing wrong with the
>    function's arguments - use ENODEV instead

You are right, guess there are other places with this kind of problem as
well.

>  * We were also printing a warning message, but that's a decision better
>    left up to the callers, so remove it
>  * One caller is vmemmap_remove_mapping(), which will just BUG_ON() on
>    error, making the warning message irrelevant, so no change is needed
>    there.

It makes it redundant not irrelevant. It still prints a valid reason why
the remove operation failed.

>  * The other caller is remove_section_mapping().  This is called in the
>    memory hot remove path at a point after vmemmap_remove_mapping() so
>    if hpte_removebolted isn't implemented, we'd expect to have already
>    BUG()ed anyway.  Put a WARN_ON() here, in lieu of a printk() since this
>    really shouldn't be happening.

Right.
