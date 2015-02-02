Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C86F41A0C23
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 09:01:31 +1100 (AEDT)
Date: Tue, 3 Feb 2015 09:01:29 +1100
From: Anton Blanchard <anton@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/mm: Add trace point for tracking hash pte fault
Message-ID: <20150203090129.5e3c7494@kryten>
In-Reply-To: <87vbjk707w.fsf@linux.vnet.ibm.com>
References: <1421753750-17135-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1421809627.4900.1.camel@ellerman.id.au>
 <87d268v7xm.fsf@linux.vnet.ibm.com>
 <1422425467.11009.2.camel@ellerman.id.au>
 <20150202212607.7585dedb@kryten>
 <87vbjk707w.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Aneesh,

> yes. We do use jump label. I also verified that looking at .s
> 
> #APP
>  # 23 "./arch/powerpc/include/asm/jump_label.h" 1
>         1:
>         nop
>         .pushsection __jump_table,  "aw"
>         .llong 1b, .L201, __tracepoint_hash_fault+8      #,
>         .popsection
> 
>  # 0 "" 2

So we insert a single nop, and the slow path is in another section. I'd
be surprised if we could measure this, unless the nop causes a branch
target alignment issue the slow path caused some hot path icache layout
issues.

> Without patch
> sys: 0m11.2425
> 
> With patch:
> sys: 0m11.3258
>
> ie, a -0.7% impact 
> 
> If that impact is high we could possibly put that tracepoint within
> #ifdef CONFIG_DEBUG_VM ?

Did the real time change? I'd be careful about comparing based on
system time.

My feeling is we should not hide it behind CONFIG_DEBUG_VM.

Anton
