Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vc6cQ5PwFzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 15:43:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
Cc: anton@samba.org, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] crypto: powerpc - Fix initialisation of crc32c context
In-Reply-To: <20170303065655.7317-1-dja@axtens.net>
References: <20170303065655.7317-1-dja@axtens.net>
Date: Mon, 06 Mar 2017 15:43:31 +1100
Message-ID: <87tw77ow0c.fsf@concordia.ellerman.id.au>
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

Daniel Axtens <dja@axtens.net> writes:

> Turning on crypto self-tests on a POWER8 shows:
>
>     alg: hash: Test 1 failed for crc32c-vpmsum
>     00000000: ff ff ff ff
>
> Comparing the code with the Intel CRC32c implementation on which
> ours is based shows that we are doing an init with 0, not ~0
> as CRC32c requires.
>
> This probably wasn't caught because btrfs does its own weird
> open-coded initialisation.
>
> Initialise our internal context to ~0 on init.
>
> This makes the self-tests pass, and btrfs continues to work.
>
> Fixes: 6dd7a82cc54e ("crypto: powerpc - Add POWER8 optimised crc32c")
> Cc: Anton Blanchard <anton@samba.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  arch/powerpc/crypto/crc32c-vpmsum_glue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This driver was originally merged via the crypto tree, so I'll assume
Herbert will pick up the fix. If he hasn't in a few days I'll take it.

cheers
