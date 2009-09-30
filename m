Return-Path: <yfrolov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 4D3C5B7B7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Sep 2009 23:50:18 +1000 (EST)
Message-ID: <4AC36217.7010506@ru.mvista.com>
Date: Wed, 30 Sep 2009 17:50:15 +0400
From: Yuri Frolov <yfrolov@ru.mvista.com>
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [patch] powerpc: build modules outside the kernel tree fails,
	if it was built using O=
References: <4ABB57CB.3000409@ru.mvista.com>
	<20090925194557.GA3323@merkur.ravnborg.org>
	<4ABE0CFF.5040001@ru.mvista.com>
In-Reply-To: <4ABE0CFF.5040001@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Hello,

Any news yet?
Any sort of correction needed?

Thank you,
Yuri

On 09/26/2009 04:45 PM, Yuri Frolov wrote:
> Hello, here is a fixed version.
> 
> Compile and export arch/powerpc/lib/crtsavres.o in order to fix the
> "arch/powerpc/lib/crtsavres.o not found" error when "O=" option
> is employed for external module compilation.
> crtsavres.o is a support file, containing save/restore code from gcc,
> simplified down for powerpc architecture needs.
> This file needs to be linked against every module and thus to be built
> before any module.
> 
> Documentation/kbuild/kbuild.txt |    8 ++++++++
> Makefile                        |    2 +-
> arch/powerpc/Makefile           |    2 +-
> scripts/Makefile.modpost        |   14 ++++++++++++--
> 4 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff -urpN -X linux-2.6/Documentation/dontdiff linux-2.6/arch/powerpc/Makefile linux-2.6-powerpc-crtsavres/arch/powerpc/Makefile
> --- linux-2.6/arch/powerpc/Makefile	2009-09-17 20:04:31.000000000 +0400
> +++ linux-2.6-powerpc-crtsavres/arch/powerpc/Makefile	2009-09-26 13:35:32.000000000 +0400
> @@ -93,7 +93,7 @@ else
>  	KBUILD_CFLAGS += $(call cc-option,-mtune=power4)
>  endif
>  else
> -LDFLAGS_MODULE	+= arch/powerpc/lib/crtsavres.o
> +KBUILD_MODULE_LINK_SOURCE += arch/powerpc/lib/crtsavres.o
>  endif
>  
>  ifeq ($(CONFIG_TUNE_CELL),y)
> diff -urpN -X linux-2.6/Documentation/dontdiff linux-2.6/Documentation/kbuild/kbuild.txt linux-2.6-powerpc-crtsavres/Documentation/kbuild/kbuild.txt
> --- linux-2.6/Documentation/kbuild/kbuild.txt	2009-09-17 20:04:30.000000000 +0400
> +++ linux-2.6-powerpc-crtsavres/Documentation/kbuild/kbuild.txt	2009-09-26 16:03:50.000000000 +0400
> @@ -132,3 +132,11 @@ For tags/TAGS/cscope targets, you can sp
>  to be included in the databases, separated by blank space. E.g.:
>  
>      $ make ALLSOURCE_ARCHS="x86 mips arm" tags
> +
> +KBUILD_MODULE_LINK_SOURCE
> +--------------------------------------------------
> +Compile and export arch/powerpc/lib/crtsavres.o
> +when "O=" option is employed for powerpc external module compilation.
> +This file needs to be linked against every module and thus to be built
> +before any module.
> +
> diff -urpN -X linux-2.6/Documentation/dontdiff linux-2.6/Makefile linux-2.6-powerpc-crtsavres/Makefile
> --- linux-2.6/Makefile	2009-09-17 20:04:30.000000000 +0400
> +++ linux-2.6-powerpc-crtsavres/Makefile	2009-09-26 14:23:27.000000000 +0400
> @@ -354,7 +354,7 @@ KERNELVERSION = $(VERSION).$(PATCHLEVEL)
>  export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
>  export ARCH SRCARCH CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
>  export CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE
> -export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
> +export HOSTCXX HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS KBUILD_MODULE_LINK_SOURCE
>  
>  export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
>  export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE CFLAGS_GCOV
> diff -urpN -X linux-2.6/Documentation/dontdiff linux-2.6/scripts/Makefile.modpost linux-2.6-powerpc-crtsavres/scripts/Makefile.modpost
> --- linux-2.6/scripts/Makefile.modpost	2009-09-17 20:04:42.000000000 +0400
> +++ linux-2.6-powerpc-crtsavres/scripts/Makefile.modpost	2009-09-26 14:34:28.000000000 +0400
> @@ -122,14 +122,24 @@ quiet_cmd_cc_o_c = CC      $@
>        cmd_cc_o_c = $(CC) $(c_flags) $(CFLAGS_MODULE)	\
>  		   -c -o $@ $<
>  
> -$(modules:.ko=.mod.o): %.mod.o: %.mod.c FORCE
> +quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
> +      cmd_as_o_S = $(CC) $(a_flags) $(AFLAGS_MODULE) -c -o $@ $<
> +
> +ifdef KBUILD_MODULE_LINK_SOURCE
> +$(KBUILD_MODULE_LINK_SOURCE): %.o: %.S FORCE
> +	$(Q)mkdir -p $(dir $@)
> +	$(call if_changed_dep,as_o_S)
> +endif
> +
> +$(modules:.ko=.mod.o): %.mod.o: %.mod.c $(KBUILD_MODULE_LINK_SOURCE) FORCE
>  	$(call if_changed_dep,cc_o_c)
>  
>  targets += $(modules:.ko=.mod.o)
>  
>  # Step 6), final link of the modules
>  quiet_cmd_ld_ko_o = LD [M]  $@
> -      cmd_ld_ko_o = $(LD) -r $(LDFLAGS) $(LDFLAGS_MODULE) -o $@		\
> +      cmd_ld_ko_o = $(LD) -r $(LDFLAGS) $(KBUILD_MODULE_LINK_SOURCE)	\
> +			  $(LDFLAGS_MODULE) -o $@			\
>  			  $(filter-out FORCE,$^)
>  
>  $(modules): %.ko :%.o %.mod.o FORCE
> 
> On 09/25/2009 11:45 PM, Sam Ravnborg wrote:
>> On Thu, Sep 24, 2009 at 03:28:11PM +0400, Yuri Frolov wrote:
>>> Hello,
>>>
>>> here is a corresponding bug: http://bugzilla.kernel.org/show_bug.cgi?id=11143
>>> This patch should correctly export crtsavres.o in order to make O= option working.
>>> Please, consider to apply.
>> Hi Yuri.
>>
>> I like the way you do the extra link in Makefile.modpost.
>> But you need to redo some parts as per comments below.
>>
>>> Fix linking modules against crtsavres.o
>> Please elaborate more on what this commit does.
>>
>>> Previously we got
>>>   CC      drivers/char/hw_random/rng-core.mod.o
>>>   LD [M]  drivers/char/hw_random/rng-core.ko
>>> /there/src/buildroot.git.ppc/build_powerpc_nofpu/staging_dir/usr/bin/powerpc-linux-uclibc-ld: arch/powerpc/lib/crtsavres.o: No such file: No such file or directory
>> Always good to include error messages.
>>
>>> 	* Makefile (LDFLAGS_MODULE_PREREQ): New variable to hold prerequisite
>>>           files for modules.
>>> 	* arch/powerpc/Makefile: add crtsavres.o to LDFLAGS_MODULE_PREREQ.
>>> 	* scripts/Makefile.modpost (cmd_as_o_S): Copy from Makefile.build.
>>> 	  (cmd_ld_ko_o): Also link LDFLAGS_MODULE_PREREQ.
>>> 	  Provide rule to build objects from assembler.
>> But this GNUism can go - we do not use it in the kernel.
>>  
>>> Signed-off-by:  Bernhard Reutner-Fischer  <rep.dot.nop@gmail.com>
>>> Signed-off by:  Yuri Frolov <yfrolov@ru.mvista.com>
>>>
>>> Makefile                 |    2 ++
>>> arch/powerpc/Makefile    |    2 +-
>>> scripts/Makefile.modpost |   12 ++++++++++--
>>> 3 files changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff -urpN -X linux-2.6/Documentation/dontdiff linux-2.6/arch/powerpc/Makefile linux-2.6-powerpc-crtsavres/arch/powerpc/Makefile
>>> --- linux-2.6/arch/powerpc/Makefile	2009-09-17 20:04:31.000000000 +0400
>>> +++ linux-2.6-powerpc-crtsavres/arch/powerpc/Makefile	2009-09-23 22:08:03.000000000 +0400
>>> @@ -93,7 +93,7 @@ else
>>>  	KBUILD_CFLAGS += $(call cc-option,-mtune=power4)
>>>  endif
>>>  else
>>> -LDFLAGS_MODULE	+= arch/powerpc/lib/crtsavres.o
>>> +LDFLAGS_MODULE_PREREQ += arch/powerpc/lib/crtsavres.o
>>>  endif
>> The naming sucks.
>> How about:
>>
>> KBUILD_MODULE_LINK_SOURCE
>>
>> This would tell the reader that this is source to be linked on a module.
>>
>> And this is an arch specific thing so no need to preset it in top-level
>> Makefile.
>> But it is mandatory to include a description in Documentation/kbuild/kbuild.txt
>>
>>
>>> --- linux-2.6/scripts/Makefile.modpost	2009-09-17 20:04:42.000000000 +0400
>>> +++ linux-2.6-powerpc-crtsavres/scripts/Makefile.modpost	2009-09-23 22:15:00.000000000 +0400
>>> @@ -122,14 +122,22 @@ quiet_cmd_cc_o_c = CC      $@
>>>        cmd_cc_o_c = $(CC) $(c_flags) $(CFLAGS_MODULE)	\
>>>  		   -c -o $@ $<
>>>  
>>> -$(modules:.ko=.mod.o): %.mod.o: %.mod.c FORCE
>>> +quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
>>> +cmd_as_o_S       = $(CC) $(a_flags) $(AFLAGS_MODULE) -c -o $@ $<
>> Align this so cmd_as_o_S is under each other - as we do for cmd_cc_o_c
>>
>>
>>> +
>>> +$(LDFLAGS_MODULE_PREREQ): %.o: %.S FORCE
>>> +	$(Q)mkdir -p $(dir $@)
>>> +	$(call if_changed_dep,as_o_S)
>> Good catch with the mkdir - needed for O= builds.
>> I think we shall wrap this in
>> ifdef KBUILD_MODULE_LINK_SOURCE
>> ...
>> endif
>>
>> So we do not have an empty rule when it is not defined.
>>
>> Please fix up these things and resubmit.
>>
>> Thanks,
>> 	Sam
> 
