Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9PQ91tLMzDrCL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:30:25 +1000 (AEST)
Message-ID: <1470958199.25630.266.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Zhao Qiang <qiang.zhao@nxp.com>, "David
 S.Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 stable@vger.kernel.org
Date: Thu, 11 Aug 2016 18:29:59 -0500
In-Reply-To: <20160808160858.4B9251A2452@localhost.localdomain>
References: <20160808160858.4B9251A2452@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] soc: fsl/qe: fix Oops on CPM1 (and likely CPM2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-08-08 at 18:08 +0200, Christophe Leroy wrote:
> Commit 0e6e01ff694ee ("CPM/QE: use genalloc to manage CPM/QE muram")
> has changed the way muram is managed.
> genalloc uses kmalloc(), hence requires the SLAB to be up and running.
> 
> On powerpc 8xx, cpm_reset() is called early during startup.
> cpm_reset() then calls cpm_muram_init() before SLAB is available,
> hence the following Oops.
> 
> cpm_reset() cannot be called during initcalls because the CPM is
> needed for console
> 
> This patch splits cpm_muram_init() in two parts. The first part,
> related to mappings, is kept as cpm_muram_init()
> The second part is named cpm_muram_pool_init() and is called
> the first time cpm_muram_alloc() is used

Why do you need to split it, versus calling the full cpm_muram_init() on
demand?

-Scott
