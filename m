Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6D76DB7043
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 09:03:57 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n9FM3sIj013747
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 15:03:54 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n9FM6wL6004441
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 17:06:59 -0500 (CDT)
Message-ID: <4AD79C64.9060206@freescale.com>
Date: Thu, 15 Oct 2009 17:04:20 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 0/8]  Fix 8xx MMU/TLB
References: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>
In-Reply-To: <1255597466-30976-1-git-send-email-Joakim.Tjernlund@transmode.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Joakim Tjernlund wrote:
> Now updated with Scott's remarks.
> There is still(probably) a trivial conflict in pte-8xx.h
> 
> Joakim Tjernlund (8):
>   8xx: invalidate non present TLBs
>   8xx: Update TLB asm so it behaves as linux mm expects.
>   8xx: Tag DAR with 0x00f0 to catch buggy instructions.
>   8xx: Fixup DAR from buggy dcbX instructions.
>   8xx: Add missing Guarded setting in DTLB Error.
>   8xx: Restore _PAGE_WRITETHRU
>   8xx: start using dcbX instructions in various copy routines
>   8xx: Remove DIRTY pte handling in DTLB Error.
> 
>  arch/powerpc/include/asm/pte-8xx.h |   14 +-
>  arch/powerpc/kernel/head_8xx.S     |  341 +++++++++++++++++++++++------------
>  arch/powerpc/kernel/misc_32.S      |   18 --
>  arch/powerpc/lib/copy_32.S         |   24 ---
>  arch/powerpc/mm/fault.c            |    8 +-
>  5 files changed, 238 insertions(+), 167 deletions(-)

I still see the lockup with the dcbX patch.  Reverting that (and with 
Rex's patch) things look OK.

-Scott
