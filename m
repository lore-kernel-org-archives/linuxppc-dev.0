Return-Path: <srs0=y+ig=fq=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znGs93w7YzF0q1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 01:27:25 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3znGs83kSkz8tkD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 01:27:24 +1100 (AEDT)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3znGs66FQpz9sDQ
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2018 01:27:22 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id m5so2125385pff.7
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 06:27:22 -0800 (PST)
Date: Fri, 23 Feb 2018 00:26:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, greg@kroah.com, linuxppc-dev@ozlabs.org,
 linux@roeck-us.net, corsac@debian.org
Subject: Re: [PATCH v4.4 backport 3/3] powerpc/64s: Improve RFI L1-D cache
 flush fallback
Message-ID: <20180223002658.21cdaf61@roar.ozlabs.ibm.com>
In-Reply-To: <20180222123545.8946-3-mpe@ellerman.id.au>
References: <20180222065738.GB2428@kroah.com>
 <20180222123545.8946-1-mpe@ellerman.id.au>
 <20180222123545.8946-3-mpe@ellerman.id.au>
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

On Thu, 22 Feb 2018 23:35:45 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> From: Nicholas Piggin <npiggin@gmail.com>
> 
> commit bdcb1aefc5b3f7d0f1dc8b02673602bca2ff7a4b upstream.
> 
> The fallback RFI flush is used when firmware does not provide a way
> to flush the cache. It's a "displacement flush" that evicts useful
> data by displacing it with an uninteresting buffer.
> 
> The flush has to take care to work with implementation specific cache
> replacment policies, so the recipe has been in flux. The initial
> slow but conservative approach is to touch all lines of a congruence
> class, with dependencies between each load. It has since been
> determined that a linear pattern of loads without dependencies is
> sufficient, and is significantly faster.
> 
> Measuring the speed of a null syscall with RFI fallback flush enabled
> gives the relative improvement:
> 
> P8 - 1.83x
> P9 - 1.75x
> 
> The flush also becomes simpler and more adaptable to different cache
> geometries.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> [mpe: Backport to 4.9]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks for doing these. They all look okay to me.

Thanks,
Nick
