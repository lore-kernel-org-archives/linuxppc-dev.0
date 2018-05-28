Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40vW5754SfzF12M
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 May 2018 18:59:39 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id az12-v6so6852652plb.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 May 2018 01:59:39 -0700 (PDT)
Date: Mon, 28 May 2018 18:59:26 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/mm/radix: Change pte relax sequence to
 handle nest MMU hang
Message-ID: <20180528185926.64e4288b@roar.ozlabs.ibm.com>
In-Reply-To: <20180525154917.23163-2-aneesh.kumar@linux.ibm.com>
References: <20180525154917.23163-1-aneesh.kumar@linux.ibm.com>
 <20180525154917.23163-2-aneesh.kumar@linux.ibm.com>
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

On Fri, 25 May 2018 21:19:17 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> When relaxing access (read -> read_write update), pte need to be marked invalid
> to handle a nest MMU bug. We also need to do a tlb flush after the pte is
> marked invalid before updating the pte with new access bits.
> 
> We also move tlb flush to platform specific __ptep_set_access_flags. This will
> help us to gerid of unnecessary tlb flush on BOOK3S 64 later. We don't do that
> in this patch. This also helps in avoiding multiple tlbies with coprocessor
> attached.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

I think these look good to me, but same comment: can you split the API
change from the NMMU fix? The fix is just a couple of lines, and the
rest of the API change should leave generated code almost unchanged, so
it would be easier to review if these are split.

Thanks,
Nick
