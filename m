Return-Path: <jwboyer@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
 [209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 30A8DB6F75
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 22:43:51 +1100 (EST)
Received: by vcbfl15 with SMTP id fl15so267056vcb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 03:43:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322630640-13708-4-git-send-email-tony@bakeyournoodle.com>
References: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
 <1322630640-13708-4-git-send-email-tony@bakeyournoodle.com>
Date: Wed, 30 Nov 2011 06:43:48 -0500
Message-ID: <CA+5PVA637ckfo60Foc_G_yhuJg6=fbuyQcjFDwYV_XFLkd6whA@mail.gmail.com>
Subject: Re: [PATCH 3/6] 44x: Removing dead CONFIG_PPC47x
From: Josh Boyer <jwboyer@gmail.com>
To: Tony Breeds <tony@bakeyournoodle.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christoph Egger <siccegge@cs.fau.de>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 30, 2011 at 12:23 AM, Tony Breeds <tony@bakeyournoodle.com> wro=
te:
> From: Christoph Egger <siccegge@cs.fau.de>
>
> CONFIG_PPC47x doesn't exist in Kconfig, therefore removing all
> references for it from the source code.
>
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> ---
> =A0arch/powerpc/mm/44x_mmu.c | =A0 =A04 ----
> =A01 files changed, 0 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/mm/44x_mmu.c b/arch/powerpc/mm/44x_mmu.c
> index f60e006..5d4e3ff 100644
> --- a/arch/powerpc/mm/44x_mmu.c
> +++ b/arch/powerpc/mm/44x_mmu.c
> @@ -78,11 +78,7 @@ static void __init ppc44x_pin_tlb(unsigned int virt, u=
nsigned int phys)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"tlbwe =A0%1,%3,%5\n"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"tlbwe =A0%0,%3,%6\n"
> =A0 =A0 =A0 =A0:
> -#ifdef CONFIG_PPC47x
> - =A0 =A0 =A0 : "r" (PPC47x_TLB2_S_RWX),
> -#else
> =A0 =A0 =A0 =A0: "r" (PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_SX | PPC=
44x_TLB_G),
> -#endif

That doesn't look right.  The code is there doing something, why is it
just being removed?  I would think the change would be to use
CONFIG_PPC_47x?

Or if the code there isn't needed any longer, the changelog should say why.

josh
