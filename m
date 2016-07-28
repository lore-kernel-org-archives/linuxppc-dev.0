Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0PC80N74zDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 17:49:40 +1000 (AEST)
Received: from mail-pf0-x233.google.com (mail-pf0-x233.google.com
 [IPv6:2607:f8b0:400e:c00::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s0PC73l2dz9srY
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jul 2016 17:49:39 +1000 (AEST)
Received: by mail-pf0-x233.google.com with SMTP id x72so19563861pfd.2
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jul 2016 00:49:39 -0700 (PDT)
Date: Thu, 28 Jul 2016 17:49:31 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: <linuxppc-dev@ozlabs.org>, haokexin@gmail.com,
 aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH v3 12/21] powerpc/mm: Convert early cpu/mmu feature
 check to use the new helpers
Message-ID: <20160728174931.34fb7437@roar.ozlabs.ibm.com>
In-Reply-To: <1469629097-30859-12-git-send-email-mpe@ellerman.id.au>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
 <1469629097-30859-12-git-send-email-mpe@ellerman.id.au>
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

On Thu, 28 Jul 2016 00:18:08 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> This switches early feature checks to use the non static key variant
> of the function. In later patches we will be switching
> cpu_has_feature() and mmu_has_feature() to use static keys and we can
> use them only after static key/jump label is initialized. Any check
> for feature before jump label init should be done using this new
> helper.

Can't convince you to call it *_has_feature_early()?

Any point to a WARN_ON_ONCE() in these guys that trips if they are
used after the jump labels are set up?

Thanks,
Nick
