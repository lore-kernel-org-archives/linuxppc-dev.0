Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F00B8B7B75
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Sep 2009 11:12:31 +1000 (EST)
Subject: Re: [patch] powerpc: build modules outside the kernel tree fails,
	if it was built using O=
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yuri Frolov <yfrolov@ru.mvista.com>
In-Reply-To: <4ABB57CB.3000409@ru.mvista.com>
References: <4ABB57CB.3000409@ru.mvista.com>
Content-Type: text/plain
Date: Fri, 25 Sep 2009 11:12:21 +1000
Message-Id: <1253841141.7103.489.camel@pasglop>
Mime-Version: 1.0
Cc: rep.dot.nop@gmail.com, linuxppc-dev@lists.ozlabs.org,
	Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-09-24 at 15:28 +0400, Yuri Frolov wrote:
> Hello,
> 
> here is a corresponding bug: http://bugzilla.kernel.org/show_bug.cgi?id=11143
> This patch should correctly export crtsavres.o in order to make O= option working.
> Please, consider to apply.
> 
> 
> Fix linking modules against crtsavres.o

Hi !

This is the same patch you already posted as "


[PATCH] Fix linking modules against
crtsavres.o
"

Or it's an update ?

I've asked Sam to review it already since it affects the main kernel
makefiles, waiting for his answer.

Cheers,
Ben.

> Previously we got
>   CC      drivers/char/hw_random/rng-core.mod.o
>   LD [M]  drivers/char/hw_random/rng-core.ko
> /there/src/buildroot.git.ppc/build_powerpc_nofpu/staging_dir/usr/bin/powerpc-linux-uclibc-ld: arch/powerpc/lib/crtsavres.o: No such file: No such file or directory
> 
> 	* Makefile (LDFLAGS_MODULE_PREREQ): New variable to hold prerequisite
>           files for modules.
> 	* arch/powerpc/Makefile: add crtsavres.o to LDFLAGS_MODULE_PREREQ.
> 	* scripts/Makefile.modpost (cmd_as_o_S): Copy from Makefile.build.
> 	  (cmd_ld_ko_o): Also link LDFLAGS_MODULE_PREREQ.
> 	  Provide rule to build objects from assembler.
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
>  
>  ifeq ($(CONFIG_TUNE_CELL),y)
> diff -urpN -X linux-2.6/Documentation/dontdiff linux-2.6/Makefile linux-2.6-powerpc-crtsavres/Makefile
> --- linux-2.6/Makefile	2009-09-17 20:04:30.000000000 +0400
> +++ linux-2.6-powerpc-crtsavres/Makefile	2009-09-23 21:41:16.000000000 +0400
> @@ -326,6 +326,7 @@ MODFLAGS	= -DMODULE
>  CFLAGS_MODULE   = $(MODFLAGS)
>  AFLAGS_MODULE   = $(MODFLAGS)
>  LDFLAGS_MODULE  = -T $(srctree)/scripts/module-common.lds
> +LDFLAGS_MODULE_PREREQ  =
>  CFLAGS_KERNEL	=
>  AFLAGS_KERNEL	=
>  CFLAGS_GCOV	= -fprofile-arcs -ftest-coverage
> @@ -355,6 +356,7 @@ export VERSION PATCHLEVEL SUBLEVEL KERNE
>  export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
>  export CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE
>  export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
> +export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE LDFLAGS_MODULE_PREREQ CHECK CHECKFLAGS
>  
>  export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
>  export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE CFLAGS_GCOV
> diff -urpN -X linux-2.6/Documentation/dontdiff linux-2.6/scripts/Makefile.modpost linux-2.6-powerpc-crtsavres/scripts/Makefile.modpost
> --- linux-2.6/scripts/Makefile.modpost	2009-09-17 20:04:42.000000000 +0400
> +++ linux-2.6-powerpc-crtsavres/scripts/Makefile.modpost	2009-09-23 22:15:00.000000000 +0400
> @@ -122,14 +122,22 @@ quiet_cmd_cc_o_c = CC      $@
>        cmd_cc_o_c = $(CC) $(c_flags) $(CFLAGS_MODULE)	\
>  		   -c -o $@ $<
>  
> -$(modules:.ko=.mod.o): %.mod.o: %.mod.c FORCE
> +quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
> +cmd_as_o_S       = $(CC) $(a_flags) $(AFLAGS_MODULE) -c -o $@ $<
> +
> +$(LDFLAGS_MODULE_PREREQ): %.o: %.S FORCE
> +	$(Q)mkdir -p $(dir $@)
> +	$(call if_changed_dep,as_o_S)
> +
> +$(modules:.ko=.mod.o): %.mod.o: %.mod.c $(LDFLAGS_MODULE_PREREQ) FORCE
>  	$(call if_changed_dep,cc_o_c)
>  
>  targets += $(modules:.ko=.mod.o)
>  
>  # Step 6), final link of the modules
>  quiet_cmd_ld_ko_o = LD [M]  $@
> -      cmd_ld_ko_o = $(LD) -r $(LDFLAGS) $(LDFLAGS_MODULE) -o $@		\
> +      cmd_ld_ko_o = $(LD) -r $(LDFLAGS) $(LDFLAGS_MODULE_PREREQ)	\
> +			  $(LDFLAGS_MODULE) -o $@			\
>  			  $(filter-out FORCE,$^)
>  
>  $(modules): %.ko :%.o %.mod.o FORCE
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
