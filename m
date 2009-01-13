Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AF472DE17C
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 02:45:33 +1100 (EST)
Message-Id: <EE4E2626-FCCA-4DEB-9CDC-085838C74165@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <1228793699-23110-5-git-send-email-tpiepho@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 5/5] powerpc: booke: Allow larger CAM sizes than 256 MB
Date: Tue, 13 Jan 2009 09:43:24 -0600
References: <1228793699-23110-1-git-send-email-tpiepho@freescale.com>
	<1228793699-23110-5-git-send-email-tpiepho@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 8, 2008, at 9:34 PM, Trent Piepho wrote:

> The code that maps kernel low memory would only use page sizes up to  
> 256
> MB.  On E500v2 pages up to 4 GB are supported.
>
> However, a page must be aligned to a multiple of the page's size.   
> I.e.
> 256 MB pages must aligned to a 256 MB boundary.  This was enforced  
> by a
> requirement that the physical and virtual addresses of the start of  
> lowmem
> be aligned to 256 MB.  Clearly requiring 1GB or 4GB alignment to allow
> pages of that size isn't acceptable.
>
> To solve this, I simply have adjust_total_lowmem() take alignment into
> account when it decides what size pages to use.  Give it PAGE_OFFSET =
> 0x7000_0000, PHYSICAL_START = 0x3000_0000, and 2GB of RAM, and it  
> will map
> pages like this:
> PA 0x3000_0000 VA 0x7000_0000 Size 256 MB
> PA 0x4000_0000 VA 0x8000_0000 Size 1 GB
> PA 0x8000_0000 VA 0xC000_0000 Size 256 MB
> PA 0x9000_0000 VA 0xD000_0000 Size 256 MB
> PA 0xA000_0000 VA 0xE000_0000 Size 256 MB
>
> Because the lowmem mapping code now takes alignment into account,
> PHYSICAL_ALIGN can be lowered from 256 MB to 64 MB.  Even lower  
> might be
> possible.  The lowmem code will work down to 4 kB but it's possible  
> some of
> the boot code will fail before then.  Poor alignment will force  
> small pages
> to be used, which combined with the limited number of TLB1 pages  
> available,
> will result in very little memory getting mapped.  So alignments  
> less than
> 64 MB probably aren't very useful anyway.
>
> Signed-off-by: Trent Piepho <tpiepho@freescale.com>
> ---
> arch/powerpc/Kconfig            |    2 +-
> arch/powerpc/mm/fsl_booke_mmu.c |   14 +++++++++++++-
> 2 files changed, 14 insertions(+), 2 deletions(-)

applied

- k
