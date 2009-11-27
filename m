Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8A2591007D2
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Nov 2009 22:00:25 +1100 (EST)
In-Reply-To: <1258712471-3104-1-git-send-email-Joakim.Tjernlund@transmode.se>
References: <1258712471-3104-1-git-send-email-Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 00/10 v6]  Fix 8xx MMU/TLB
Message-ID: <OF44DA1806.2D9916D9-ONC125767B.003BE84B-C125767B.003C3CD7@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Fri, 27 Nov 2009 11:57:57 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott and Rex, I think we need you s-o-b to make it into the kernel proper.

Marcelo and Vitaly, I noticed you guys are listed as 8xx maintainers.
Have you seen this? What do you think?

        Jocke

Joakim Tjernlund <Joakim.Tjernlund@transmode.se> wrote on 20/11/2009 11:21:01:
>
> Yet again an iteration of the series.
> Rex & Scott, please test and signoff.
> Changes since last version:
>  - Fix rlwimi insn(from Scott)
>
> Joakim Tjernlund (10):
>   8xx: invalidate non present TLBs
>   8xx: Update TLB asm so it behaves as linux mm expects.
>   8xx: Tag DAR with 0x00f0 to catch buggy instructions.
>   8xx: Always pin kernel instruction TLB
>   8xx: Fixup DAR from buggy dcbX instructions.
>   8xx: Add missing Guarded setting in DTLB Error.
>   8xx: Restore _PAGE_WRITETHRU
>   8xx: start using dcbX instructions in various copy routines
>   8xx: Remove DIRTY pte handling in DTLB Error.
>   8xx: DTLB Miss cleanup
>
>  arch/powerpc/include/asm/pte-8xx.h |   14 +-
>  arch/powerpc/kernel/head_8xx.S     |  315 ++++++++++++++++++++++--------------
>  arch/powerpc/kernel/misc_32.S      |   18 --
>  arch/powerpc/lib/copy_32.S         |   24 ---
>  arch/powerpc/mm/fault.c            |    8 +-
>  5 files changed, 211 insertions(+), 168 deletions(-)
>
