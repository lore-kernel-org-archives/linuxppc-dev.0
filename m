Return-Path: <sam@ravnborg.org>
Received: from pfepb.post.tele.dk (unknown [195.41.46.236])
	by ozlabs.org (Postfix) with ESMTP id 62E3BB7BC0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Sep 2009 05:46:04 +1000 (EST)
Date: Fri, 25 Sep 2009 21:45:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Yuri Frolov <yfrolov@ru.mvista.com>
Subject: Re: [patch] powerpc: build modules outside the kernel tree fails,
	if it was built using O=
Message-ID: <20090925194557.GA3323@merkur.ravnborg.org>
References: <4ABB57CB.3000409@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4ABB57CB.3000409@ru.mvista.com>
Cc: rep.dot.nop@gmail.com, linuxppc-dev@lists.ozlabs.org,
	linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 24, 2009 at 03:28:11PM +0400, Yuri Frolov wrote:
> Hello,
> 
> here is a corresponding bug: http://bugzilla.kernel.org/show_bug.cgi?id=11143
> This patch should correctly export crtsavres.o in order to make O= option working.
> Please, consider to apply.

Hi Yuri.

I like the way you do the extra link in Makefile.modpost.
But you need to redo some parts as per comments below.

> 
> 
> Fix linking modules against crtsavres.o

Please elaborate more on what this commit does.

> 
> Previously we got
>   CC      drivers/char/hw_random/rng-core.mod.o
>   LD [M]  drivers/char/hw_random/rng-core.ko
> /there/src/buildroot.git.ppc/build_powerpc_nofpu/staging_dir/usr/bin/powerpc-linux-uclibc-ld: arch/powerpc/lib/crtsavres.o: No such file: No such file or directory

Always good to include error messages.

> 	* Makefile (LDFLAGS_MODULE_PREREQ): New variable to hold prerequisite
>           files for modules.
> 	* arch/powerpc/Makefile: add crtsavres.o to LDFLAGS_MODULE_PREREQ.
> 	* scripts/Makefile.modpost (cmd_as_o_S): Copy from Makefile.build.
> 	  (cmd_ld_ko_o): Also link LDFLAGS_MODULE_PREREQ.
> 	  Provide rule to build objects from assembler.
But this GNUism can go - we do not use it in the kernel.
 
> 
> Signed-off-by:  Bernhard Reutner-Fischer  <rep.dot.nop@gmail.com>
> Signed-off by:  Yuri Frolov <yfrolov@ru.mvista.com>
> 
> Makefile                 |    2 ++
> arch/powerpc/Makefile    |    2 +-
> scripts/Makefile.modpost |   12 ++++++++++--
> 3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff -urpN -X linux-2.6/Documentation/dontdiff linux-2.6/arch/powerpc/Makefile linux-2.6-powerpc-crtsavres/arch/powerpc/Makefile
> --- linux-2.6/arch/powerpc/Makefile	2009-09-17 20:04:31.000000000 +0400
> +++ linux-2.6-powerpc-crtsavres/arch/powerpc/Makefile	2009-09-23 22:08:03.000000000 +0400
> @@ -93,7 +93,7 @@ else
>  	KBUILD_CFLAGS += $(call cc-option,-mtune=power4)
>  endif
>  else
> -LDFLAGS_MODULE	+= arch/powerpc/lib/crtsavres.o
> +LDFLAGS_MODULE_PREREQ += arch/powerpc/lib/crtsavres.o
>  endif

The naming sucks.
How about:

KBUILD_MODULE_LINK_SOURCE

This would tell the reader that this is source to be linked on a module.

And this is an arch specific thing so no need to preset it in top-level
Makefile.
But it is mandatory to include a description in Documentation/kbuild/kbuild.txt


> --- linux-2.6/scripts/Makefile.modpost	2009-09-17 20:04:42.000000000 +0400
> +++ linux-2.6-powerpc-crtsavres/scripts/Makefile.modpost	2009-09-23 22:15:00.000000000 +0400
> @@ -122,14 +122,22 @@ quiet_cmd_cc_o_c = CC      $@
>        cmd_cc_o_c = $(CC) $(c_flags) $(CFLAGS_MODULE)	\
>  		   -c -o $@ $<
>  
> -$(modules:.ko=.mod.o): %.mod.o: %.mod.c FORCE
> +quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
> +cmd_as_o_S       = $(CC) $(a_flags) $(AFLAGS_MODULE) -c -o $@ $<

Align this so cmd_as_o_S is under each other - as we do for cmd_cc_o_c


> +
> +$(LDFLAGS_MODULE_PREREQ): %.o: %.S FORCE
> +	$(Q)mkdir -p $(dir $@)
> +	$(call if_changed_dep,as_o_S)
Good catch with the mkdir - needed for O= builds.
I think we shall wrap this in
ifdef KBUILD_MODULE_LINK_SOURCE
...
endif

So we do not have an empty rule when it is not defined.

Please fix up these things and resubmit.

Thanks,
	Sam
