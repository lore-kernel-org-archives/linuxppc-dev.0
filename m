Return-Path: <roel.kluin@gmail.com>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.186])
	by ozlabs.org (Postfix) with ESMTP id D212ADDFCB
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 00:03:57 +1000 (EST)
Received: by gv-out-0910.google.com with SMTP id y18so829021gvf.14
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 07:03:55 -0700 (PDT)
Message-ID: <25e057c00806120703g27566bd7ie522a7d5d4664d92@mail.gmail.com>
Date: Thu, 12 Jun 2008 16:03:54 +0200
From: "roel kluin" <roel.kluin@gmail.com>
To: "Sam Ravnborg" <sam@ravnborg.org>
Subject: Re: [GIT PULL] one kbuild fix for powerpc
In-Reply-To: <20080612131650.GA13702@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080612131650.GA13702@uranus.ravnborg.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2008/6/12 Sam Ravnborg <sam@ravnborg.org>:

> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 508c589..b763aba 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -467,6 +467,26 @@ static void parse_elf_finish(struct elf_info *info)
>        release_file(info->hdr, info->size);
>  }
>
> +static int ignore_undef_symbol(struct elf_info *info, const char *symname)
> +{
> +       /* ignore __this_module, it will be resolved shortly */
> +       if (strcmp(symname, MODULE_SYMBOL_PREFIX "__this_module") == 0)
> +               return 1;
> +       /* ignore global offset table */
> +       if (strcmp(symname, "_GLOBAL_OFFSET_TABLE_") == 0)
> +               return 1;
> +       if (info->hdr->e_machine == EM_PPC)
> +               /* Special register function linked on all modules during final link of .ko */
> +               if (strncmp(symname, "_restgpr_", sizeof("_restgpr_") - 1) == 0 ||
> +                   strncmp(symname, "_savegpr_", sizeof("_savegpr_") - 1) == 0 ||
> +                   strncmp(symname, "_rest32gpr_", sizeof("_rest32gpr_") - 1) == 0 ||
> +                   strncmp(symname, "_save32gpr_", sizeof("_save32gpr_") - 1) == 0) {
> +                       return 1;
> +       }

Either the indentation is wrong, or you want to move the opening curly
bracket upwards.

> +       /* Do not ignore this symbol */
> +       return 0;
> +}
> +
>  #define CRC_PFX     MODULE_SYMBOL_PREFIX "__crc_"
>  #define KSYMTAB_PFX MODULE_SYMBOL_PREFIX "__ksymtab_"
>
> @@ -493,11 +513,7 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
>                if (ELF_ST_BIND(sym->st_info) != STB_GLOBAL &&
>                    ELF_ST_BIND(sym->st_info) != STB_WEAK)
>                        break;
> -               /* ignore global offset table */
> -               if (strcmp(symname, "_GLOBAL_OFFSET_TABLE_") == 0)
> -                       break;
> -               /* ignore __this_module, it will be resolved shortly */
> -               if (strcmp(symname, MODULE_SYMBOL_PREFIX "__this_module") == 0)
> +               if (ignore_undef_symbol(info, symname))
>                        break;
>  /* cope with newer glibc (2.3.4 or higher) STT_ definition in elf.h */
>  #if defined(STT_REGISTER) || defined(STT_SPARC_REGISTER)
