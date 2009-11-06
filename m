Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CDA8DB7B9C
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 11:33:03 +1100 (EST)
Date: Thu, 5 Nov 2009 18:33:05 -0600
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 0/8] 8xx: Misc fixes for buggy insn
Message-ID: <20091106003305.GA15814@loki.buserror.net>
References: <1257341920-29277-1-git-send-email-Joakim.Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1257341920-29277-1-git-send-email-Joakim.Tjernlund@transmode.se>
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

On Wed, Nov 04, 2009 at 02:38:32PM +0100, Joakim Tjernlund wrote:
> Here is the latest(last?) round of this series. I
> hope I got everything right now.
> Scott and Rex, please test and send ACK/NACK.
> 
>   Jocke
> 
> Joakim Tjernlund (8):
>   8xx: invalidate non present TLBs

This works, and is an important fix -- it should be applied even if the rest
of the patchset isn't ready.

>   8xx: Update TLB asm so it behaves as linux mm expects.
>   8xx: Tag DAR with 0x00f0 to catch buggy instructions.

Up through this point works.

>   8xx: Fixup DAR from buggy dcbX instructions.

With this, the kernel hangs after "Mount-cache hash table entries: 512".

>   8xx: Add missing Guarded setting in DTLB Error.
>   8xx: Restore _PAGE_WRITETHRU
>   8xx: start using dcbX instructions in various copy routines

Once I get up to this patch, it no longer hangs, but I get some user
processes consistently failing with EFAULT.

>   8xx: Remove DIRTY pte handling in DTLB Error.

No change after this patch.

-Scott
