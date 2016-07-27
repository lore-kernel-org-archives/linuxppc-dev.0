Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzrs82GpZzDqQL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 20:32:12 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rzrs74Xr8z9srY
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jul 2016 20:32:11 +1000 (AEST)
Message-ID: <1469612976.5978.143.camel@kernel.crashing.org>
Subject: Re: _PAGE_PRESENT and _PAGE_ACCESSED
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: LEROY Christophe <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org
Date: Wed, 27 Jul 2016 19:49:36 +1000
In-Reply-To: <20160726195245.Horde.xJWqCTeuxQeC7gAnGhJItg6@messagerie.si.c-s.fr>
References: <20160726195245.Horde.xJWqCTeuxQeC7gAnGhJItg6@messagerie.si.c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-07-26 at 19:52 +0200, LEROY Christophe wrote:
> In ppc8xx tlbmiss handler, we consider a page valid if both  
> _PAGE_PRESENT and _PAGE_ACCESSED are set.
> Is there any chance to have _PAGE_ACCESSED set and not _PAGE_PRESENT ?
> Otherwise we could simplify the handler by considering the page valid  
> only when _PAGE_ACCESSED is set

When _PAGE_PRESENT is not set, the PTE becomes a swap PTE and a pile
of the other bits can be repurposed, you may want to verify if
_PAGE_ACCESSED is one of them.

Cheers,
Ben.
