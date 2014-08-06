Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D48CA1A072E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 16:27:50 +1000 (EST)
Message-ID: <1407306457.3073.71.camel@pasglop>
Subject: Re: [PATCH v4 11/16] powerpc/powernv: Release replaced TCE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 06 Aug 2014 16:27:37 +1000
In-Reply-To: <1406712695-9491-12-git-send-email-aik@ozlabs.ru>
References: <1406712695-9491-1-git-send-email-aik@ozlabs.ru>
 <1406712695-9491-12-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Ellerman <michael@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-07-30 at 19:31 +1000, Alexey Kardashevskiy wrote:
> 
> This adds a set_and_get() callback to iommu_table_ops which does the
> same
> thing as set() plus it returns replaced TCE(s) so the caller can
> release
> the pages afterwards.

Call it xchg() instead of set_and_get(), it better reflects the
atomicity requirement.

Cheers,
Ben.
