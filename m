Return-Path: <gorcunov@gmail.com>
Received: from mail-lb0-x244.google.com (mail-lb0-x244.google.com
 [IPv6:2a00:1450:4010:c04::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32EC81A09D5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 01:09:09 +1100 (AEDT)
Received: by mail-lb0-x244.google.com with SMTP id tz10so23620784lbb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jan 2016 06:09:09 -0800 (PST)
Date: Sun, 10 Jan 2016 17:09:02 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH next] mm: make swapoff more robust against soft dirty
Message-ID: <20160110140902.GA31017@uranus>
References: <alpine.LSU.2.11.1601091651130.9808@eggly.anvils>
 <alpine.LSU.2.11.1601091656491.9808@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LSU.2.11.1601091656491.9808@eggly.anvils>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jan 09, 2016 at 04:59:42PM -0800, Hugh Dickins wrote:
> Both s390 and powerpc have hit the issue of swapoff hanging, when
> CONFIG_HAVE_ARCH_SOFT_DIRTY and CONFIG_MEM_SOFT_DIRTY ifdefs were
> not quite as x86_64 had them.  I think it would be much clearer if
> HAVE_ARCH_SOFT_DIRTY was just a Kconfig option set by architectures
> to determine whether the MEM_SOFT_DIRTY option should be offered,
> and the actual code depend upon CONFIG_MEM_SOFT_DIRTY alone.
> 
> But won't embark on that change myself: instead make swapoff more
> robust, by using pte_swp_clear_soft_dirty() on each pte it encounters,
> without an explicit #ifdef CONFIG_MEM_SOFT_DIRTY.  That being a no-op,
> whether the bit in question is defined as 0 or the asm-generic fallback
> is used, unless soft dirty is fully turned on.
> 
> Why "maybe" in maybe_same_pte()?  Rename it pte_same_as_swp().
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Cyrill Gorcunov <gorcunov@openvz.org>

Thanks a lot, Hugh!
