Return-Path: <aaro.koskinen@iki.fi>
Received: from emh07.mail.saunalahti.fi (emh07.mail.saunalahti.fi
 [62.142.5.117])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402gbP0Bw7zDqrQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2018 20:46:56 +1100 (AEDT)
Date: Fri, 16 Mar 2018 11:37:47 +0200
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: build warning in drivers/macintosh/rack-meter.c
Message-ID: <20180316093747.dxle5xhwwi2nptqz@darkstar.musicnaut.iki.fi>
References: <20180316164614.07f2f573@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180316164614.07f2f573@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Fri, Mar 16, 2018 at 04:46:14PM +1100, Stephen Rothwell wrote:
> These warnings have beeen around for a while now;
> 
> drivers/macintosh/rack-meter.c:157:2: warning: 'memset' used with length equal to number of elements without multiplication by element size [-Wmemset-elt-size]
>   memset(rdma->buf1, 0, ARRAY_SIZE(rdma->buf1));
>   ^~~~~~
> drivers/macintosh/rack-meter.c:158:2: warning: 'memset' used with length equal to number of elements without multiplication by element size [-Wmemset-elt-size]
>   memset(rdma->buf2, 0, ARRAY_SIZE(rdma->buf2));
>   ^~~~~~
> 
> Introduced by commit
> 
>   4f7bef7a9f69 ("drivers: macintosh: rack-meter: fix bogus memsets")
> 
> I guess updating to a newer compiler has started generating these.

Eh, that's really embarrassing. Obviously it should be sizeof(). I can send
a fix for this and test on Xserve.

A.
