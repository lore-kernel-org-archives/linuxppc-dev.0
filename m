Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYNvR6R3CzDsTp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 22:16:35 +1000 (AEST)
In-Reply-To: <1473400477-23548-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org, glaubitz@physik.fu-berlin.de
Subject: Re: powerpc/xmon: Don't use ld on 32-bit
Message-Id: <3sYNvR3mDVz9t14@ozlabs.org>
Date: Tue, 13 Sep 2016 22:16:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-09-09 at 05:54:37 UTC, Michael Ellerman wrote:
> In commit 31cdd0c39c75 ("powerpc/xmon: Fix SPR read/write commands and
> add command to dump SPRs") I added two uses of the "ld" instruction in
> spr_access.S. "ld" is a 64-bit instruction, so shouldn't be used on
> 32-bit CPUs.
> 
> Replace it with PPC_LL which is a macro that gives us either "ld" or
> "lwz" depending on whether we're 64 or 32-bit.
> 
> Fixes: 31cdd0c39c75 ("powerpc/xmon: Fix SPR read/write commands and add command to dump SPRs")
> Cc: stable@vger.kernel.org # v4.7+
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/b42d9023a31e384504f5b53fc9

cheers
