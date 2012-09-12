Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7E73D2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 10:59:24 +1000 (EST)
Message-ID: <504FDE3F.1060309@freescale.com>
Date: Tue, 11 Sep 2012 19:58:39 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V9 09/11] arch/powerpc: Add 64TB support
References: <1347281577-5460-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1347281577-5460-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1347281577-5460-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/10/2012 07:52 AM, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> Increase max addressable range to 64TB. This is not tested on
> real hardware yet.
> 
> Reviewed-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/mmu-hash64.h        |   42 ++++++++++++++++++++------
>  arch/powerpc/include/asm/pgtable-ppc64-4k.h  |    2 +-
>  arch/powerpc/include/asm/pgtable-ppc64-64k.h |    2 +-
>  arch/powerpc/include/asm/processor.h         |    4 +--
>  arch/powerpc/include/asm/sparsemem.h         |    4 +--
>  arch/powerpc/kernel/exceptions-64s.S         |    4 ++-
>  arch/powerpc/mm/slb_low.S                    |   12 ++++++++
>  7 files changed, 54 insertions(+), 16 deletions(-)

Bisect shows this patch to be the one that causes hangs on p5020.  It
gets stuck in a loop of TLB misses, bailing on a PUD entry of zero.  The
page fault path runs and returns, but doesn't fix the situation, so it
repeats.  AFAICT the miss handler is behaving correctly.  I'll try to
see what's going on in the page fault code.

-Scott
