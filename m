Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xclNM3G22zDqmf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 21:20:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 9e5050e1-e0cc-0e0e-7b31-5dcb38b307f4@linux.vnet.ibm.com
Subject: Re: [PATCH V9 2/2] powerpc/nodes: Ensure enough nodes avail for
 operations
In-Reply-To: <83b05ed2-8d18-3d5c-2003-b022d0d55eb2@linux.vnet.ibm.com>
References: <83b05ed2-8d18-3d5c-2003-b022d0d55eb2@linux.vnet.ibm.com>
Date: Wed, 23 Aug 2017 21:20:50 +1000
Message-ID: <87h8wyy1gt.fsf@concordia.ellerman.id.au>
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

Michael Bringmann <mwb@linux.vnet.ibm.com> writes:

> To: linuxppc-dev@lists.ozlabs.org
>
> From: Michael Bringmann <mwb@linux.vnet.ibm.com>
>
> To: linux-kernel@vger.kernel.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>
> Cc: John Allen <jallen@linux.vnet.ibm.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Subject: [PATCH V9 2/2] powerpc/nodes: Ensure enough nodes avail for operations
>
> powerpc/nodes: On systems like PowerPC which allow 'hot-add' of CPU
> or memory resources, it may occur that the new resources are to be
> inserted into nodes that were not used for these resources at bootup.
> In the kernel, any node that is used must be defined and initialized
> at boot.
>
> This patch extracts the value of the lowest domain level (number of
> allocable resources) from the "rtas" device tree property
> "ibm,max-associativity-domains" to use as the maximum number of nodes
> to setup as possibly available in the system.  This new setting will
> override the instruction,

Thanks for implementing my suggestion of using "ibm,max-associativity-domains".

However I don't think it's correct to use the lowest domain level.

It's not very clearly specified in PAPR, but I think you need to treat
it like an associativity property and index into based on the
associativity reference points.

You should be able to use min_common_depth as the index.

cheers
