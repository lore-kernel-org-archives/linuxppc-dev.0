Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EA2D62C0097
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 20:33:43 +1000 (EST)
Received: by mail-pa0-f52.google.com with SMTP id kq13so1827895pab.25
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 03:33:41 -0700 (PDT)
Message-ID: <51F0FEF4.9030309@ozlabs.ru>
Date: Thu, 25 Jul 2013 20:33:24 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH] powerpc: Prepare to support kernel handling of IOMMU
 map/unmap
References: <1374707624.6142.16.camel@pasglop>
 <1374747961-28501-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1374747961-28501-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=KOI8-R
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/25/2013 08:26 PM, Alexey Kardashevskiy wrote:
> The current VFIO-on-POWER implementation supports only user mode
> driven mapping, i.e. QEMU is sending requests to map/unmap pages.
> However this approach is really slow, so we want to move that to KVM.
> Since H_PUT_TCE can be extremely performance sensitive (especially with
> network adapters where each packet needs to be mapped/unmapped) we chose
> to implement that as a "fast" hypercall directly in "real
> mode" (processor still in the guest context but MMU off).
> 
> To be able to do that, we need to provide some facilities to
> access the struct page count within that real mode environment as things
> like the sparsemem vmemmap mappings aren't accessible.
> 
> This adds an API to get page struct when MMU is off.
> 
> This adds to MM a new function put_page_unless_one() which drops a page
> if counter is bigger than 1. It is going to be used when MMU is off
> (real mode on PPC64 is the first user) and we want to make sure that page
> release will not happen in real mode as it may crash the kernel in
> a horrible way.


Yes, my english needs to be polished, I even know where :)


-- 
Alexey
