Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryZrN2f7zzDqhN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 18:57:08 +1000 (AEST)
Received: by mail-pf0-x22f.google.com with SMTP id h186so62097969pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 01:57:08 -0700 (PDT)
Date: Mon, 25 Jul 2016 18:56:57 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH for-4.8 V2 03/10] powerpc/mm/radix: Add radix_set_pte to
 use in early init
Message-ID: <20160725185657.7732f1c1@roar.ozlabs.ibm.com>
In-Reply-To: <87shuyyv0m.fsf@concordia.ellerman.id.au>
References: <1469265163-1491-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1469265163-1491-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87shuyyv0m.fsf@concordia.ellerman.id.au>
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

On Mon, 25 Jul 2016 18:36:09 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> 
> > We want to use the static key based feature check in set_pte_at.
> > Since we call radix__map_kernel_page early in boot before jump
> > label is initialized we can't call set_pte_at there. Add
> > radix__set_pte for the same.  
> 
> Although this is an OK solution to this problem, I think it
> highlights a bigger problem, which is that we're still doing the
> feature patching too late.
> 
> If we can move the feature patching prior to MMU init, then all (or
> more of) these problems with pre vs post patching go away.
> 
> I'll see if I can come up with something tomorrow.

Agreed, that would be much nicer if you can make it work.

Thanks,
Nick
