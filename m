Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B0C21A02C0
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Feb 2016 10:45:48 +1100 (AEDT)
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DE13814032F
 for <linuxppc-dev@ozlabs.org>; Sun,  7 Feb 2016 10:45:46 +1100 (AEDT)
Date: Sun, 7 Feb 2016 10:45:32 +1100
From: Anton Blanchard <anton@samba.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, Alan Modra
 <amodra@gmail.com>
Subject: Re: [PATCH] powerpc: fix dedotify for binutils >= 2.26
Message-ID: <20160207104532.51e110ac@kryten>
In-Reply-To: <87bn7vm1pg.fsf@linux-m68k.org>
References: <87bn7vm1pg.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linuxppc-dev.linuxppc.org>


> Since binutils 2.26 BFD is doing suffix merging on STRTAB sections.
> But dedotify modifies the symbol names in place, which can also modify
> unrelated symbols with a name that matches a suffix of a dotted
> name.  To remove the leading dot of a symbol name we can just
> increment the pointer into the STRTAB section instead.

Thanks Andreas.

> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

I think we should get it into stable too.

Anton

> ---
>  arch/powerpc/kernel/module_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/module_64.c
> b/arch/powerpc/kernel/module_64.c index ac64ffd..08b7a40 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -340,7 +340,7 @@ static void dedotify(Elf64_Sym *syms, unsigned
> int numsyms, char *strtab) if (name[0] == '.') {
>  				if (strcmp(name+1, "TOC.") == 0)
>  					syms[i].st_shndx = SHN_ABS;
> -				memmove(name, name+1, strlen(name));
> +				syms[i].st_name++;
>  			}
>  		}
>  	}
