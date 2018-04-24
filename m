Return-Path: <srs0=yxbz=hn=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VXNS1DrVzF1RV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 15:45:12 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40VXNR4tx5z8vPJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 15:45:11 +1000 (AEST)
Received: from mail-pf0-x22a.google.com (mail-pf0-x22a.google.com
 [IPv6:2607:f8b0:400e:c00::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40VXNQ6rCqz9ryr
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2018 15:45:10 +1000 (AEST)
Received: by mail-pf0-x22a.google.com with SMTP id g14so11312542pfh.3
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 22:45:10 -0700 (PDT)
Date: Tue, 24 Apr 2018 15:44:57 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, msuchanek@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] powerpc/64s: Add barrier_nospec
Message-ID: <20180424154457.78fe8c09@roar.ozlabs.ibm.com>
In-Reply-To: <20180424041559.32410-1-mpe@ellerman.id.au>
References: <20180424041559.32410-1-mpe@ellerman.id.au>
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

On Tue, 24 Apr 2018 14:15:54 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> From: Michal Suchanek <msuchanek@suse.de>
> 
> A no-op form of ori (or immediate of 0 into r31 and the result stored
> in r31) has been re-tasked as a speculation barrier. The instruction
> only acts as a barrier on newer machines with appropriate firmware
> support. On older CPUs it remains a harmless no-op.
> 
> Implement barrier_nospec using this instruction.
> 
> mpe: The semantics of the instruction are believed to be that it
> prevents execution of subsequent instructions until preceding branches
> have been fully resolved and are no longer executing speculatively.
> There is no further documentation available at this time.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
> mpe: Make it Book3S64 only, update comment & change log, add a
>      memory clobber to the asm.

These all seem good to me. Thanks Michal.

We should (eventually) work on the module patching problem too.

Thanks,
Nick
