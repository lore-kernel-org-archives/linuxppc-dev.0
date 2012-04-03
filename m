Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DBDC0B70B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2012 08:05:07 +1000 (EST)
Date: Tue, 03 Apr 2012 18:03:02 -0400 (EDT)
Message-Id: <20120403.180302.342779808900865443.davem@davemloft.net>
To: kaffeemonster@googlemail.com
Subject: Re: [REGRESSION][PATCH V4 3/3] bpf jit: Let the powerpc jit handle
 negative offsets
From: David Miller <davem@davemloft.net>
In-Reply-To: <4F75D2A5.7060407@googlemail.com>
References: <4F75CA89.4010709@googlemail.com> <4F75D2A5.7060407@googlemail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jan Seiffert <kaffeemonster@googlemail.com>
Date: Fri, 30 Mar 2012 17:35:01 +0200

> Now the helper function from filter.c for negative offsets is exported,
> it can be used it in the jit to handle negative offsets.
> 
> First modify the asm load helper functions to handle:
> - know positive offsets
> - know negative offsets
> - any offset
> 
> then the compiler can be modified to explicitly use these helper
> when appropriate.
> 
> This fixes the case of a negative X register and allows to lift
> the restriction that bpf programs with negative offsets can't
> be jited.
> 
> Signed-off-by: Jan Seiffert <kaffeemonster@googlemail.com>
> 
> I have only compile tested this, -ENOHARDWARE.
> Can someone with more powerpc kung-fu review and maybe test this?
> Esp. powerpc asm is not my strong point. I think i botched the
> stack frame in the call setup. Help?

I'm not applying this until a powerpc person tests it.

Also, we have an ARM JIT in the tree which probably needs to
be fixed similarly.
