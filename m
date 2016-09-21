Return-Path: <htejun@gmail.com>
Received: from mail-yb0-x22d.google.com (mail-yb0-x22d.google.com
 [IPv6:2607:f8b0:4002:c09::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfMLW2YFpzDt2D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 00:23:47 +1000 (AEST)
Received: by mail-yb0-x22d.google.com with SMTP id u125so32188965ybg.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 07:23:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 21 Sep 2016 10:23:43 -0400
From: Tejun Heo <tj@kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] percpu: improve generic percpu modify-return
 implementation
Message-ID: <20160921142343.GA10734@htj.duckdns.org>
References: <20160921085137.862-1-npiggin@gmail.com>
 <20160921205711.4e804777@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160921205711.4e804777@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Nick.

How have you been? :)

On Wed, Sep 21, 2016 at 08:57:11PM +1000, Nicholas Piggin wrote:
> On Wed, 21 Sep 2016 18:51:37 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> > Some architectures require an additional load to find the address of
> > percpu pointers. In some implemenatations, the C aliasing rules do not
> > allow the result of that load to be kept over the store that modifies
> > the percpu variable, which causes additional loads.
> 
> Sorry I picked up an old patch here. This one should be better.
> 
> From d0cb9052d6f4c31d24f999b7b0cecb34681eee9b Mon Sep 17 00:00:00 2001
> From: Nicholas Piggin <npiggin@gmail.com>
> Date: Wed, 21 Sep 2016 18:23:43 +1000
> Subject: [PATCH] percpu: improve generic percpu modify-return implementations
> 
> Some architectures require an additional load to find the address of
> percpu pointers. In some implemenatations, the C aliasing rules do not
> allow the result of that load to be kept over the store that modifies
> the percpu variable, which causes additional loads.
> 
> Work around this by finding the pointer first, then operating on that.
> 
> It's also possible to mark things as restrict and those kind of games,
> but that can require larger and arch specific changes.
> 
> On powerpc, __this_cpu_inc_return compiles to:
> 
>         ld 10,48(13)
>         ldx 9,3,10
>         addi 9,9,1
>         stdx 9,3,10
>         ld 9,48(13)
>         ldx 3,9,3
> 
> With this patch it compiles to:
> 
>         ld 10,48(13)
>         ldx 9,3,10
>         addi 9,9,1
>         stdx 9,3,10
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Patch looks good to me but seems QP encoded.  Can you please resend?

Thanks and it's great to see you again!

-- 
tejun
