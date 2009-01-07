Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BAEFFDE531
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 02:10:26 +1100 (EST)
Message-Id: <545635DB-30D6-4387-8CA1-9485698A441C@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Liu Yu <Yu.Liu@freescale.com>, Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <1229654093-11398-1-git-send-email-yu.liu@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v2] powerpc/fsl-booke: declare tlbcam_index for use in c
	file
Date: Wed, 7 Jan 2009 09:09:04 -0600
References: <1229654093-11398-1-git-send-email-yu.liu@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Trent Piepho <tpiepho@freescale.com>, kvm-ppc <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 18, 2008, at 8:34 PM, Liu Yu wrote:

> KVM on E500 platform currently utilize TLB1 entries without  
> bothering host,
> that is using unused TLB1 entries.
>
> So, KVM needs to read tlbcam_index to know exactly
> which TLB1 entry is unused by host.
>
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> [v2]
> Remove num_tlbcam_entries declare and read from SPRN_TLB1CFG in KVM  
> instead.
>
> arch/powerpc/include/asm/mmu-fsl-booke.h |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mmu-fsl-booke.h b/arch/powerpc/ 
> include/asm/mmu-fsl-booke.h
> index 925d93c..c86af6c 100644
> --- a/arch/powerpc/include/asm/mmu-fsl-booke.h
> +++ b/arch/powerpc/include/asm/mmu-fsl-booke.h
> @@ -73,6 +73,8 @@
>
> #ifndef __ASSEMBLY__
>
> +extern unsigned int tlbcam_index;
> +
> typedef struct {
> 	unsigned long id;
> 	unsigned long vdso_base;
> -- 
> 1.5.4

Acked-by: Kumar Gala <galak@kernel.crashing.org>

(Hollis will you deal with sending this via the KVM tree?)

- k
