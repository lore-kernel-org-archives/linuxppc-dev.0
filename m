Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GsbF33jBzF3QF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 21:59:37 +1000 (AEST)
In-Reply-To: <3c4cddf185438cc7200908b4f971a8e6ed7472fd.1536558233.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jianlin Shi <jishi@redhat.com>,
 Xin Long <lucien.xin@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: powerpc: fix csum_ipv6_magic() on little endian platforms
Message-Id: <42GsbF1vw9z9sCR@ozlabs.org>
Date: Fri, 21 Sep 2018 21:59:37 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-09-10 at 06:09:04 UTC, Christophe Leroy wrote:
> On little endian platforms, csum_ipv6_magic() keeps len and proto in
> CPU byte order. This generates a bad results leading to ICMPv6 packets
> from other hosts being dropped by powerpc64le platforms.
> 
> In order to fix this, len and proto should be converted to network
> byte order ie bigendian byte order. However checksumming 0x12345678
> and 0x56341278 provide the exact same result so it is enough to
> rotate the sum of len and proto by 1 byte.
> 
> PPC32 only support bigendian so the fix is needed for PPC64 only
> 
> Fixes: e9c4943a107b ("powerpc: Implement csum_ipv6_magic in assembly")
> Reported-by: Jianlin Shi <jishi@redhat.com>
> Reported-by: Xin Long <lucien.xin@gmail.com>
> Cc: <stable@vger.kernel.org> # 4.18+
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Tested-by: Xin Long <lucien.xin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/85682a7e3b9c664995ad477520f917

cheers
