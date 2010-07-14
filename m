Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id 0C9F0B6F17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Jul 2010 12:26:38 +1000 (EST)
Received: by gxk26 with SMTP id 26so3828330gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Jul 2010 19:26:36 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100713114322.57c8b166.sfr@canb.auug.org.au>
References: <20100713114322.57c8b166.sfr@canb.auug.org.au>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 13 Jul 2010 20:26:16 -0600
Message-ID: <AANLkTimC_vXCAOrfTSndZyk8lgkjTlILVSYVYeIg6cUt@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Enable building defconfigs from Kconfig files
To: Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Marek <mmarek@suse.cz>, Linus <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[cc'ing rmk and linux-arm-kernel]

On Mon, Jul 12, 2010 at 7:43 PM, Stephen Rothwell <sfr@canb.auug.org.au> wr=
ote:
> After this change, doing a "make xxx_defconfig" will check first for
> a file called arch/<arch>/configs/Kconfig.xxx and use that to generate
> the .config (effectively starting from an allnoconfig). =A0If that file
> doesn't exist, it will use arch/<ARCH>/configs/xxx_defconfig as now.

Oops, I hadn't seen this patch when I wrote mine this afternoon[1].
:-)  A few minor differences, but essentially the same solution.

[1] http://patchwork.ozlabs.org/patch/58823/

I chose to use -D /dev/null (defconfig from an empty file) instead of
-n (allnoconfig) so that default values in Kconfig would get
respected.  For the benefit of everyone else, here's an excerpt from
our IRC conversation this afternoon:

19:49 < gcl> sfr: [...] Your patch and my patch are
             essentially doing exactly the same thing, except that I used '=
-d'
             and you used '-n'.
19:50 < gcl> s/-d/-D/
19:55 < sfr> right
19:55 < sfr> Linus wanted us to use -n
19:55 < sfr> because that way you get what you asked for, not what the defa=
ults
             say ...
19:58 < gcl> I suppose we don't currently have a way to say "select FOO=3Dn=
", so
             I suppose that makes sense
19:58 < gcl> although I think using the defaults unless told not to is a be=
tter
             approach in the long run
19:59 < gcl> most of the time I *don't want* to ask for something in the
             defconfig.  :-)
20:00 < gcl> I just want TheBestOrCorrectAnswer to be chosen for me
20:04 < sfr> gcl: go read Linus' vision :-)

> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
> =A0scripts/kconfig/Makefile | =A0 14 +++++++++++++-
> =A01 files changed, 13 insertions(+), 1 deletions(-)
>
> Hi Linus,
>
> Is this more the direction you want to take?
>
> There are still 2 main problems with is approach:
>
> =A0 =A0 =A0 =A0- there are some config options that are globally and
> unconditionally enabled that some platforms may not want. =A0The only way
> currently to turn them off is to reproduce the config entry with the
> different default. =A0I am not sure if we need a wa to turn them off or t=
o
> just change them to being neede to be selected by those that do want them=
.
> =A0 =A0 =A0 =A0- we have no way to select options that are neither bool o=
r
> tristate to suitable values. =A0Again the only way to do that currently i=
s
> to reproduce the config entry with a different default value.

For both of the above problems, what if we added syntax like the
following to Kconfig?

config FOO
        bool
        select BAR =3D n
        select FOO_VALUE =3D 54

> I am currently working towards using this to recreate the PowerPC
> defconfigs, but it is a slow process as they have some much stuff enabled
> in them and some of it is probably actually not relevant.

If the trimmed configs are merged, then there is no rush on this.  We
can keep them around and switch them over as people want to make
changes.

> This process is made easier by the recent commit "kbuild: Warn on
> selecting symbols with unmet direct dependencies" that is in the kbuild
> tree (and linux-next).

Ah, I didn't know that change was being merged.  That indeed makes
things easier, and eliminates the post-test that I do to make sure
that the resulting config is actually valid.

> diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
> index 7ea649d..1ab8f45 100644
> --- a/scripts/kconfig/Makefile
> +++ b/scripts/kconfig/Makefile
> @@ -117,9 +117,21 @@ else
> =A0 =A0 =A0 =A0$(Q)$< -D arch/$(SRCARCH)/configs/$(KBUILD_DEFCONFIG) $(Kc=
onfig)
> =A0endif
>
> -%_defconfig: $(obj)/conf
> +configs_dir :=3D $(srctree)/arch/$(SRCARCH)/configs
> +# We check a level of sub directories because arch/powerpc
> +# has its defconfig files arranged that way
> +old_defconfigs :=3D $(patsubst $(configs_dir)/%,%,\
> + =A0 =A0 =A0 $(wildcard $(configs_dir)/*_defconfig) \
> + =A0 =A0 =A0 $(wildcard $(configs_dir)/*/*_defconfig))
> +defconfigs :=3D $(patsubst $(configs_dir)/Kconfig.%,%_defconfig,\
> + =A0 =A0 =A0 $(wildcard $(configs_dir)/Kconfig.*))
> +

Ugh.  My first impression is that all this shouldn't be necessary, and
it should be okay to just make the two following rules include a
pattern dependency for the source file.  However, as I play with it, I
cannot seem to get the rules right to handle the sub directories.  The
$(defconfigs) patsubst at least could be done solely with dependencies
on the target rule if the files were named *.Kconfig instead of
Kconfig.* (because subdirectories are not handled in that case).  For
example:

%_defconfig: $(obj)/conf arch/$(SRCARCH)/configs/%.Kconfig
        $(Q)$< -n arch/$(SRCARCH)/configs/$*.Kconfig

> +$(old_defconfigs): %_defconfig: $(obj)/conf
> =A0 =A0 =A0 =A0$(Q)$< -D arch/$(SRCARCH)/configs/$@ $(Kconfig)
>
> +$(defconfigs): %_defconfig: $(obj)/conf
> + =A0 =A0 =A0 $(Q)$< -n arch/$(SRCARCH)/configs/Kconfig.$*
> +
> =A0# Help text used by make help
> =A0help:
> =A0 =A0 =A0 =A0@echo =A0' =A0config =A0 =A0 =A0 =A0 =A0- Update current c=
onfig utilising a line-oriented program'

Cheers,
g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
