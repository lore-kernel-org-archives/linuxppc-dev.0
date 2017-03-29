Return-Path: <srs0=73t8=3g=gmail.com=kirjanov@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtM4r14hpzDqGp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 19:54:04 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vtM4r0Xslz8swH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 19:54:04 +1100 (AEDT)
Received: from mail-vk0-x230.google.com (mail-vk0-x230.google.com
 [IPv6:2607:f8b0:400c:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vtM4q3MJtz9s1h
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2017 19:54:03 +1100 (AEDT)
Received: by mail-vk0-x230.google.com with SMTP id z204so9949532vkd.1
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2017 01:54:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87a884evrc.fsf@concordia.ellerman.id.au>
References: <1490603214-30116-1-git-send-email-kda@linux-powerpc.org>
 <87a884evrc.fsf@concordia.ellerman.id.au>
From: Denis Kirjanov <kirjanov@gmail.com>
Date: Wed, 29 Mar 2017 11:54:01 +0300
Message-ID: <CAHj3AV=75sgxCN75isJUrMGw=1xpRj6K=kmYbPBWrMTfsGyTLQ@mail.gmail.com>
Subject: Re: [PATCH] kvm: powerpc: book3s: Disable preemption while accessing
 paca xics_phys filed
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Can you tell me what actual problem (other than the warning) this is
> fixing?

Since we're running with CONFIG_DEBUG_PREEMPT and CONFIG_SMP
get_paca defined as:

 #define get_paca()  ((void) debug_smp_processor_id(), local_paca)

instead of direct access to r13 so it's possible that we're preempted
on a different CPU.

> cheers
>


--=20
Regards / Mit besten Gr=C3=BC=C3=9Fen,
Denis
