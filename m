Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0XBn5LmdzDrL1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 23:04:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@ozlabs.org, haokexin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v3 12/21] powerpc/mm: Convert early cpu/mmu feature check
 to use the new helpers
In-Reply-To: <20160728174931.34fb7437@roar.ozlabs.ibm.com>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
 <1469629097-30859-12-git-send-email-mpe@ellerman.id.au>
 <20160728174931.34fb7437@roar.ozlabs.ibm.com>
Date: Thu, 28 Jul 2016 23:04:45 +1000
Message-ID: <87oa5h7w2a.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> On Thu, 28 Jul 2016 00:18:08 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> This switches early feature checks to use the non static key variant
>> of the function. In later patches we will be switching
>> cpu_has_feature() and mmu_has_feature() to use static keys and we can
>> use them only after static key/jump label is initialized. Any check
>> for feature before jump label init should be done using this new
>> helper.
>
> Can't convince you to call it *_has_feature_early()?

Hmmm, I'll go with early_cpu_has_feature().

Otherwise it reads "does the CPU have feature 'early'".

> Any point to a WARN_ON_ONCE() in these guys that trips if they are
> used after the jump labels are set up?

See patch 20. Though we can't use WARN() as it may be too early in boot
to WARN(), so it just prints() and dumps stack.

cheers
