Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CDC041007DD
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jun 2010 20:28:29 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o59ALmHI026808
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jun 2010 04:21:48 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o59ASJTc121022
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jun 2010 04:28:23 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o59ASHOA011588
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Jun 2010 04:28:19 -0600
Date: Wed, 9 Jun 2010 06:28:15 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Christoph Egger <siccegge@cs.fau.de>
Subject: Re: [PATCH 4/5] Removing dead CONFIG_SERIAL_TEXT_DEBUG
Message-ID: <20100609102815.GG7801@zod.rchland.ibm.com>
References: <cover.1275925219.git.siccegge@cs.fau.de>
	<ddcbd960ff300073939bb0c6f20a38118c0875d4.1275925219.git.siccegge@cs.fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ddcbd960ff300073939bb0c6f20a38118c0875d4.1275925219.git.siccegge@cs.fau.de>
Cc: vamos@i4.informatik.uni-erlangen.de, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 09, 2010 at 12:00:46PM +0200, Christoph Egger wrote:
>CONFIG_SERIAL_TEXT_DEBUG doesn't exist in Kconfig, therefore removing all
>references for it from the source code.
>
>Signed-off-by: Christoph Egger <siccegge@cs.fau.de>

It would be better to conver this to work with CONFIG_PPC_EARLY_DEBUG and
CONFIG_PPC_EARLY_DEBUG_40x.  I'd rather just leave this for now until we can
get it switched over.

josh

>---
> arch/powerpc/kernel/head_40x.S |   19 -------------------
> 1 files changed, 0 insertions(+), 19 deletions(-)
>
>diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
>index a90625f..1a10e4d 100644
>--- a/arch/powerpc/kernel/head_40x.S
>+++ b/arch/powerpc/kernel/head_40x.S
>@@ -939,25 +939,6 @@ initial_mmu:
> 	tlbwe	r4,r0,TLB_DATA		/* Load the data portion of the entry */
> 	tlbwe	r3,r0,TLB_TAG		/* Load the tag portion of the entry */
>
>-#if defined(CONFIG_SERIAL_TEXT_DEBUG) && defined(SERIAL_DEBUG_IO_BASE)
>-
>-	/* Load a TLB entry for the UART, so that ppc4xx_progress() can use
>-	 * the UARTs nice and early.  We use a 4k real==virtual mapping. */
>-
>-	lis	r3,SERIAL_DEBUG_IO_BASE@h
>-	ori	r3,r3,SERIAL_DEBUG_IO_BASE@l
>-	mr	r4,r3
>-	clrrwi	r4,r4,12
>-	ori	r4,r4,(TLB_WR|TLB_I|TLB_M|TLB_G)
>-
>-	clrrwi	r3,r3,12
>-	ori	r3,r3,(TLB_VALID | TLB_PAGESZ(PAGESZ_4K))
>-
>-	li	r0,0			/* TLB slot 0 */
>-	tlbwe	r4,r0,TLB_DATA
>-	tlbwe	r3,r0,TLB_TAG
>-#endif /* CONFIG_SERIAL_DEBUG_TEXT && SERIAL_DEBUG_IO_BASE */
>-
> 	isync
>
> 	/* Establish the exception vector base
>-- 
>1.6.3.3
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
