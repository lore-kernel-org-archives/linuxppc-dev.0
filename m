Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0114.outbound.protection.outlook.com [65.55.169.114])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE7311A028E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 13:10:17 +1100 (AEDT)
Message-ID: <1427249404.22867.86.camel@freescale.com>
Subject: Re: [PATCH v2 1/2] powerpc32: put csum_tcpudp_magic inline
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Tue, 24 Mar 2015 21:10:04 -0500
In-Reply-To: <20150203113927.52DA41A5F13@localhost.localdomain>
References: <20150203113927.52DA41A5F13@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-02-03 at 12:39 +0100, Christophe Leroy wrote:
> csum_tcpudp_magic() is only a few instructions, and does not modifies any other
> register than the returned result. So it is not worth having it as a separate
> function and suffer function branching and saving of volatile registers.
> This patch makes it inline by use of the already existing csum_tcpudp_nofold()
> function.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> ---
> v2: no change
> 
>  arch/powerpc/include/asm/checksum.h | 15 +++++++++++++++
>  arch/powerpc/lib/checksum_32.S      | 16 ----------------
>  2 files changed, 15 insertions(+), 16 deletions(-)

The 64-bit version is pretty similar to the 32-bit -- why only use
csum_tcpudp_nofold() on 32-bit?

-Scott
