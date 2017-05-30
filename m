Return-Path: <srs0=tnod=5e=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcJ2444PRzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 12:48:12 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wcJ243KJ4z8svk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 12:48:12 +1000 (AEST)
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wcJ236l48z9s2P
 for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2017 12:48:11 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id n23so14607065pfb.3
 for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2017 19:48:11 -0700 (PDT)
Date: Tue, 30 May 2017 12:48:00 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, paulus@samba.org,
 npiggin@gmail.com
Subject: Re: [PATCH] powerpc/64: Reclaim CPU_FTR_SUBCORE
Message-ID: <20170530124800.11dbc61b@firefly.ozlabs.ibm.com>
In-Reply-To: <1496022790-2017-1-git-send-email-mpe@ellerman.id.au>
References: <1496022790-2017-1-git-send-email-mpe@ellerman.id.au>
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

On Mon, 29 May 2017 11:53:10 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> We are running low on CPU feature bits, so we only want to use them when
> it's really necessary.
> 
> CPU_FTR_SUBCORE is only used in one place, and only in C, so we don't
> need it in order to make asm patching work. It can only be set on
> "Power8" CPUs, which in practice means POWER8, POWER8E and POWER8NVL.
> There are no plans to implement it on future CPUs, but if there ever
> were we could retrofit it then.
> 
> Although KVM uses subcores, it never looks at the CPU feature, it either
> looks at the ISA level or the threads_per_subcore value.
> 
> So drop the CPU feature and do a PVR check instead. Drop the device tree
> "subcore" feature as we no longer support doing anything with it, and we
> will drop it from skiboot too.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>

I looked at CPU_FTR_DBELL and its used for initialization and in
arch_show_interrupts(), no assembly

it may be another candidate for reclaim

Balbir Singh.
