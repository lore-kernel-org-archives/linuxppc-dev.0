Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2023D1A009A
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Nov 2014 05:00:40 +1100 (AEDT)
Date: Sat, 01 Nov 2014 14:00:35 -0400 (EDT)
Message-Id: <20141101.140035.13626854970331774.davem@davemloft.net>
To: kda@linux-powerpc.org
Subject: Re: [PATCH v2] PPC: bpf_jit_comp: add SKF_AD_PKTTYPE instruction
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAOJe8K2FzuPTZ5pch8_UK7X==+=k8RKLnfz0mZb2hca19aU4pg@mail.gmail.com>
References: <CAOJe8K31iB9+7c1BnS=6DdriU08WUisM7sYgj8nOBo4Fg=XUBg@mail.gmail.com>
 <20141101.133957.1365371956675094081.davem@davemloft.net>
 <CAOJe8K2FzuPTZ5pch8_UK7X==+=k8RKLnfz0mZb2hca19aU4pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, matt@ozlabs.org,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Sat, 1 Nov 2014 21:49:27 +0400

> David, you need a feedback from other guys to apply this patch, right?
> 
> Alexei wanted some output before/after the patch.
> Michael Ellerman wanted the explanation what a BPF_ANC | SKF_AD_PKTTYPE means.
> So I'm waiting  the ack/nack from them...

I don't really think performance metrics are necessary just for adding
SKF_AD_PKTTYPE support, that's sort of an over the top requirement
if you ask me.

It's pretty obvious that we should support as many operations as
possible to each JIT, because all of program has to do is use that
unsupported opcode and then we have none of that program being JIT'd.
