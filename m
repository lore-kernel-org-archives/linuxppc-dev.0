Return-Path: <sam@ravnborg.org>
Received: from pasmtpA.tele.dk (pasmtpa.tele.dk [80.160.77.114])
	by ozlabs.org (Postfix) with ESMTP id 6BA7ADE7CC
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 00:42:35 +1000 (EST)
Date: Thu, 12 Jun 2008 16:43:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: roel kluin <roel.kluin@gmail.com>
Subject: Re: [GIT PULL] one kbuild fix for powerpc
Message-ID: <20080612144317.GA14397@uranus.ravnborg.org>
References: <20080612131650.GA13702@uranus.ravnborg.org>
	<25e057c00806120703g27566bd7ie522a7d5d4664d92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <25e057c00806120703g27566bd7ie522a7d5d4664d92@mail.gmail.com>
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

On Thu, Jun 12, 2008 at 04:03:54PM +0200, roel kluin wrote:
> 2008/6/12 Sam Ravnborg <sam@ravnborg.org>:
> 
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 508c589..b763aba 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -467,6 +467,26 @@ static void parse_elf_finish(struct elf_info *info)
> >        release_file(info->hdr, info->size);
> >  }
> >
> > +static int ignore_undef_symbol(struct elf_info *info, const char *symname)
> > +{
> > +       /* ignore __this_module, it will be resolved shortly */
> > +       if (strcmp(symname, MODULE_SYMBOL_PREFIX "__this_module") == 0)
> > +               return 1;
> > +       /* ignore global offset table */
> > +       if (strcmp(symname, "_GLOBAL_OFFSET_TABLE_") == 0)
> > +               return 1;
> > +       if (info->hdr->e_machine == EM_PPC)
> > +               /* Special register function linked on all modules during final link of .ko */
> > +               if (strncmp(symname, "_restgpr_", sizeof("_restgpr_") - 1) == 0 ||
> > +                   strncmp(symname, "_savegpr_", sizeof("_savegpr_") - 1) == 0 ||
> > +                   strncmp(symname, "_rest32gpr_", sizeof("_rest32gpr_") - 1) == 0 ||
> > +                   strncmp(symname, "_save32gpr_", sizeof("_save32gpr_") - 1) == 0) {
> > +                       return 1;
> > +       }
> 
> Either the indentation is wrong, or you want to move the opening curly
> bracket upwards.

Deleted brackets - they are not needed.
And updated kbuild-fixes.git

	Sam
