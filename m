Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wTLw4hC1zDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 08:44:55 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id k2-v6so7214592pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 15:44:55 -0700 (PDT)
Date: Wed, 30 May 2018 08:44:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 4/4] powerpc/mm/radix: Change pte relax sequence to
 handle nest MMU hang
Message-ID: <20180530084443.58e4f754@roar.ozlabs.ibm.com>
In-Reply-To: <20180529142841.19428-4-aneesh.kumar@linux.ibm.com>
References: <20180529142841.19428-1-aneesh.kumar@linux.ibm.com>
 <20180529142841.19428-4-aneesh.kumar@linux.ibm.com>
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

On Tue, 29 May 2018 19:58:41 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:

> When relaxing access (read -> read_write update), pte needs to be marked invalid
> to handle a nest MMU bug. We also need to do a tlb flush after the pte is
> marked invalid before updating the pte with new access bits.
> 
> We also move tlb flush to platform specific __ptep_set_access_flags. This will
> help us to gerid of unnecessary tlb flush on BOOK3S 64 later. We don't do that
> in this patch. This also helps in avoiding multiple tlbies with coprocessor
> attached.

I thought you should move this part of the change back into patch 3 as
well.

Thanks,
Nick
