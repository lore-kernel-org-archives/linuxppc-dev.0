Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0129.outbound.protection.outlook.com [65.55.169.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 34F511A01FC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 10:31:24 +1000 (AEST)
Message-ID: <1435019470.2818.2.camel@freescale.com>
Subject: Re: [PATCH 1/2] powerpc32: checksum_wrappers_64 becomes
 checksum_wrappers
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, "Joakim
 Tjernlund" <joakim.tjernlund@transmode.se>
Date: Mon, 22 Jun 2015 19:31:10 -0500
In-Reply-To: <0636b88c7d11acb6a4d638e39bfcbb98c1d86045.1434978970.git.christophe.leroy@c-s.fr>
References: <cover.1434978970.git.christophe.leroy@c-s.fr>
 <0636b88c7d11acb6a4d638e39bfcbb98c1d86045.1434978970.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-06-22 at 19:01 +0200, Christophe Leroy wrote:
> The powerpc64 checksum wrapper functions adds the 
> csum_and_copy_to_user() which
> otherwise is implemented in include/net/checksum.h by using 
> csum_partial() then
> copy_to_user()
> 
> Those two wrapper fonctions are also applicable to powerpc32 as it 
> is based on
> the use of csum_partial_copy_generic() which also exists on powerpc32
> 
> This patch renames arch/powerpc/lib/checksum_wrappers_64.c to
> arch/powerpc/lib/checksum_wrappers.c and
> makes it non-conditional to CONFIG_WORD_SIZE
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/checksum.h     |   9 ---
>  arch/powerpc/lib/Makefile               |   3 +-
>  arch/powerpc/lib/checksum_wrappers.c    | 102 
> ++++++++++++++++++++++++++++++++
>  arch/powerpc/lib/checksum_wrappers_64.c | 102 ----------------------
> ----------

Please pass "-M -C" to git format-patch so we can see if anything 
changed while being moved.

-Scott
