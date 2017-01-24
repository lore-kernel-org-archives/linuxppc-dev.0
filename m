Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v74380m1CzDqRL
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 21:21:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Joel Stanley  <joel@jms.id.au>,
 stewart@linux.vnet.ibm.com  <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Validate memcons descriptor and output
 buffer
In-Reply-To: <1484783570-6298-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1484783570-6298-1-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Tue, 24 Jan 2017 21:21:22 +1100
Message-ID: <87d1fcahct.fsf@concordia.ellerman.id.au>
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

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> Currently, it's assumed that memcons and its output buffer are included
> in the linear mapping. It's not true when "mem=384M" is included in
> bootargs. The system runs into kernel crash eventually.
>
>    # od -x /proc/device-tree/ibm,opal/ibm,opal-memcons
>    0000000 0000 0000 0b30 0010
>    0000010
>
> This validates memcons descriptor and its output buffer to ensure they
> are valid in linear mapping. Otherwise, the interface won't be populated
> to avoid kernel crash during system boot.
>
> Cc: stable@vger.kernel.org #3.15+
> Fixes: bfc36894a48 ("powerpc/powernv: Add OPAL message log interface")
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Hmm.

Arguably the memcons shouldn't be in the linear map at all.

AFAICS the kernel only ever reads from it, so really it should be
explicitly mapped, and mapped read only.

That would also fix this problem :D

cheers
