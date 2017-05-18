Return-Path: <srs0=8ybw=4y=gmail.com=breno.debian@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wTLFt5MRvzDqcM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 05:04:18 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wTLFt4pbmz8tBf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 May 2017 05:04:18 +1000 (AEST)
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wTLFt1DNLz9s5j
 for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2017 05:04:17 +1000 (AEST)
Received: by mail-qk0-f193.google.com with SMTP id k74so7288828qke.2
 for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2017 12:04:17 -0700 (PDT)
Date: Thu, 18 May 2017 16:04:11 -0300
From: Breno Leitao <leitao@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, keescook@chromium.org,
 labbott@redhat.com, bsingharora@gmail.com, khandual@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/mm: Fix virt_addr_valid() etc. on 64-bit hash
Message-ID: <20170518190410.GA19855@gmail.com>
References: <1495103851-14916-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495103851-14916-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 18, 2017 at 08:37:31PM +1000, Michael Ellerman wrote:
> virt_addr_valid() is supposed to tell you if it's OK to call virt_to_page() on
> an address. What this means in practice is that it should only return true for
> addresses in the linear mapping which are backed by a valid PFN.
> 
> We are failing to properly check that the address is in the linear mapping,
> because virt_to_pfn() will return a valid looking PFN for more or less any
> address. That bug is actually caused by __pa(), used in virt_to_pfn().
> 
> eg: __pa(0xc000000000010000) = 0x10000  # Good
>     __pa(0xd000000000010000) = 0x10000  # Bad!
>     __pa(0x0000000000010000) = 0x10000  # Bad!
> 
> This started happening after commit bdbc29c19b26 ("powerpc: Work around gcc
> miscompilation of __pa() on 64-bit") (Aug 2013), where we changed the definition
> of __pa() to work around a GCC bug. Prior to that we subtracted PAGE_OFFSET from
> the value passed to __pa(), meaning __pa() of a 0xd or 0x0 address would give
> you something bogus back.
> 
> Until we can verify if that GCC bug is no longer an issue, or come up with
> another solution, this commit does the minimal fix to make virt_addr_valid()
> work, by explicitly checking that the address is in the linear mapping region.
> 
> Fixes: bdbc29c19b26 ("powerpc: Work around gcc miscompilation of __pa() on 64-bit")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Tested-by: Breno Leitao <breno.leitao@gmail.com>
