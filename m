Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4072X86s4mzF1V0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 23:14:16 +1100 (AEDT)
Subject: Re: [PATCH 12/19] powerpc/powermac: Add missing prototype for
 note_bootable_part()
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
References: <20180322202007.23088-1-malat@debian.org>
 <20180322202007.23088-13-malat@debian.org>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <d521e9d4-4ad3-0990-bf83-39e6cfeeeee4@c-s.fr>
Date: Fri, 23 Mar 2018 13:14:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180322202007.23088-13-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/03/2018 à 21:19, Mathieu Malaterre a écrit :
> Add a missing prototype for function `note_bootable_part` to silence a
> warning treated as error with W=1:
> 
>    arch/powerpc/platforms/powermac/setup.c:361:12: error: no previous prototype for ‘note_bootable_part’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/platforms/powermac/setup.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
> index ab668cb72263..e3d00f8af441 100644
> --- a/arch/powerpc/platforms/powermac/setup.c
> +++ b/arch/powerpc/platforms/powermac/setup.c
> @@ -352,6 +352,7 @@ static int pmac_late_init(void)
>   }
>   machine_late_initcall(powermac, pmac_late_init);
>   
> +extern void note_bootable_part(dev_t dev, int part, int goodness);

extern keyword is not needed

Christophe

>   /*
>    * This is __ref because we check for "initializing" before
>    * touching any of the __init sensitive things and "initializing"
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
