Return-Path: <bsingharora@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40GlDF0CXszF1bH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 11:12:12 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id g20-v6so16732697plo.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Apr 2018 18:12:12 -0700 (PDT)
Date: Thu, 5 Apr 2018 11:11:56 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
 mpe@ellerman.id.au
Subject: Re: [RESEND 1/3] powerpc/mce: Bug fixes for MCE handling in kernel
 space
Message-ID: <20180405111156.09cd3150@gmail.com>
In-Reply-To: <20180405094900.3ce4be8b@roar.ozlabs.ibm.com>
References: <20180404231943.29581-1-bsingharora@gmail.com>
 <20180404231943.29581-2-bsingharora@gmail.com>
 <20180405094900.3ce4be8b@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 5 Apr 2018 09:49:00 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Thu,  5 Apr 2018 09:19:41 +1000
> Balbir Singh <bsingharora@gmail.com> wrote:
> 
> > The code currently assumes PAGE_SHIFT as the shift value of
> > the pfn, this works correctly (mostly) for user space pages,
> > but the correct thing to do is  
> 
> It would be good to actually explain the problem in the
> changelog. I would have thought pte_pfn returns a
> PAGE_SIZE based pfn value?
>

The issue is hidden inside of hugepte_offset() as invoked by __find_linux_pte().
I will send a new version because the code needs to do
<< (shift - PAGE_SHIFT) for instruction address.

> > 
> > 1. Extrace the shift value returned via the pte-walk API's  
> 
>       ^^^ extract?

Thanks, yes, typo!

Balbir Singh.
