Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdLgX4TwgzDrKv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 20:51:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/4] powerpc/32: remove a NOP from memset()
In-Reply-To: <ae2205dedfe437e4df2dd0cc7605d62189833221.1503277387.git.christophe.leroy@c-s.fr>
References: <cover.1503277387.git.christophe.leroy@c-s.fr>
 <ae2205dedfe437e4df2dd0cc7605d62189833221.1503277387.git.christophe.leroy@c-s.fr>
Date: Thu, 24 Aug 2017 20:51:03 +1000
Message-ID: <871so1w86g.fsf@concordia.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> memset() is patched after initialisation to activate the
> optimised part which uses cache instructions.
>
> Today we have a 'b 2f' to skip the optimised patch, which then gets
> replaced by a NOP, implying a useless cycle consumption.
> As we have a 'bne 2f' just before, we could use that instruction
> for the live patching, hence removing the need to have a
> dedicated 'b 2f' to be replaced by a NOP.
>
> This patch changes the 'bne 2f' by a 'b 2f'. During init, that
> 'b 2f' is then replaced by 'bne 2f'

I'm not sure what the sequence is during boot for the 32-bit code, but
can you use an ALT_FTR section for this? Possibly that doesn't get done
at the right time though.

cheers
