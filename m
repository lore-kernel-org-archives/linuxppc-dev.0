Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 413Rjy33NRzDr30
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2018 16:55:34 +1000 (AEST)
Message-ID: <3490f7d6f45ec2586858e4547e97474d93bd2d4d.camel@kernel.crashing.org>
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Finn Thain <fthain@telegraphics.com.au>, Michael Schmitz
 <schmitzmic@gmail.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org,
 linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, Geert
 Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 10 Jun 2018 16:55:14 +1000
In-Reply-To: <alpine.LNX.2.21.1806092140410.26@nippy.intranet>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
 <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
 <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com>
 <m2h8mc4ejw.fsf@linux-m68k.org>
 <e1006b0a-a429-4744-7525-203cb91f1d5f@gmail.com>
 <alpine.LNX.2.21.1806092140410.26@nippy.intranet>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2018-06-09 at 22:21 +1000, Finn Thain wrote:
> In anycase, the "v1" and "v2" scheme is obviously inadequate when you 
> consider the range of m68k powerbook models. Also, consider the 
> out-of-tree adaptation of via-pmu by the Nubus-PMac project, which has 
> this ABI break:
> 
> diff --git a/include/linux/pmu.h b/include/linux/pmu.h
> index cafe98d9694..9882a185a52 100644
> --- a/include/linux/pmu.h
> +++ b/include/linux/pmu.h
> @@ -90,6 +90,7 @@ enum {
>          PMU_HEATHROW_BASED,     /* PowerBook G3 series */
>          PMU_PADDINGTON_BASED,   /* 1999 PowerBook G3 */
>          PMU_KEYLARGO_BASED,     /* Core99 motherboard (PMU99) */
> +        PMU_NUBUS_BASED,        /* 1400, 2300, 5300 */
>          PMU_68K_V1,             /* 68K PMU, version 1 */
>          PMU_68K_V2,             /* 68K PMU, version 2 */
>  };
> 
> (BTW, these powerbooks are not "nubus based", they are "pre-PCI", so I 
> wouldn't want this to go upstream in this form. It could be that 
> PMU_NUBUS_BASED should be PMU_UNKNOWN too.)

Pre-PCI is basically "NUBUS" based even in absence of an actual NuBus
slot :-) It has to do with the internal HW architecture. The only ones
that aren't are the even older designs (the 68000 based ones).

What's the situation with those NuBus things ? What do they use as a
bootloader ? The old Apple one or BootX ? We should merge that port of
it's maintained.

Cheers,
Ben.
 
