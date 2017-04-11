Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2Bts5wNGzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 13:12:37 +1000 (AEST)
Message-ID: <1491880344.4166.224.camel@kernel.crashing.org>
Subject: Re: clear_page, copy_page address align question?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Tue, 11 Apr 2017 13:12:24 +1000
In-Reply-To: <20170411030823.GB6545@bbox>
References: <20170411030823.GB6545@bbox>
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

On Tue, 2017-04-11 at 12:08 +0900, Minchan Kim wrote:
> Hello,
> 
> When I tested zram in ppc64, I got random corruption.
> With investigation, it seems clear_page corrupted the memory.
> I passed 64K kmalloced(kmalloc(PAGE_SIZE)) address to clear_page
> and turned on slub debug so address is not aligned with PAGE_SIZE.
> Is it a valid usecase that non-PAGE_SIZE aligned address is
> used for clear_page in ppc64?
> 
> As well, copy_page have same rule, too?
> 
> Anyway, when I changed clear_page to memset, it seems the problem
> is gone.

Yes, both clear_page and copy_page assume a PAGE_SHIFT alignment and
are highly optimize according to this.

I wouldn't be surprised of other architectures implementations are the
same.

I don't think it's ever legit to call these functions for something
that isn't a naturally aligned page.

Cheers,
Ben.
