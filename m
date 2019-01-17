Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C64C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 04:24:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B221205C9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 04:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="kdIYdQS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B221205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43g9v92km8zDqcw
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 15:24:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=aik@ozlabs.ru; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="kdIYdQS9"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43g9sP0M8ZzDqXJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 15:22:32 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id z23so4113666plo.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 20:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ogtXdKh15ftET7+oql8NpG6cFgdcmSeLgivD3mLK9Xo=;
 b=kdIYdQS9IqpAjSt4g+VWf30z1VzXuNKQZydVey5cBvfpldG7Nz8hlCszZiihrbtfja
 t2a6dTwfL/NOsyhzsjkf4j5szvPpQnPSwhR9ZhwCaozqF11Y0WzBTrlt1m8JwGJe3VLK
 f4T8L3Hots3iYHGjd4M9crXmhY0Lk1QaVpsu/yduFNCmeFg7YgGzq3oEro2GlVb5SRnl
 Mra4QGetBN21WWhhuUPNubitM3Fm98SOLC6qLbUOPI3pZndt+vLNnC+6XuLVclRO1WZr
 qjVgvSKNRPaFFioafR6+zkxAnUX0vxUUeFTFS4HN/hq/3jNgEHUb0RrooWjyePhi9aYK
 +zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=ogtXdKh15ftET7+oql8NpG6cFgdcmSeLgivD3mLK9Xo=;
 b=EOeklDOLl16k/1NjsfCGinCnjtaVgam90F/GrIlNZDk57dazxeZrd8MKleMd8b4RV3
 Sr+n31Efi4EBpfANiSGfyevVvsOEMYxtNJU5WsWAOaSt9ERBIIYSlWjs25GWrDwDnDLi
 Gq2GAevnZyosDjRb7T/9TKEJm3Odkm2JUblTj/pqQyOfuqwhw3rsgU9L3b0Go02CYnmQ
 Oidj7ByBL5q2OX3oyy4Hflj9F9FlbO360YM3JBxmUqU+AvwR7etgRU2Hn2bQIVBvoEuE
 4dNz8M45SredZ4l3TwkqgkoLUxuWhWOgOJ5kMUZyNypNZtSH/HkMCmqT3iN9R48aol+i
 PUAw==
X-Gm-Message-State: AJcUukc3Hi5eigibhhbz0hZMLpy/HKZ3rXESVnxE8LI0BnRcTmF0lohj
 +da5TyKMasqaunClXVGjStT2tpTFiAIVvw==
X-Google-Smtp-Source: ALg8bN6SN5nsS2s4+YvULyJWE4MyytcnfkPsHtX55XqXdwYesoVNQiX1HoluXSWcqwiOhOJxQmRwKg==
X-Received: by 2002:a17:902:bf44:: with SMTP id
 u4mr13527153pls.5.1547698950206; 
 Wed, 16 Jan 2019 20:22:30 -0800 (PST)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id o1sm486424pgn.63.2019.01.16.20.22.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Jan 2019 20:22:29 -0800 (PST)
Subject: Re: [PATCH 2/3] kbuild: add real-prereqs shorthand for $(filter-out
 FORCE, $^)
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 linux-kbuild@vger.kernel.org
References: <1547698231-20985-1-git-send-email-yamada.masahiro@socionext.com>
 <1547698231-20985-2-git-send-email-yamada.masahiro@socionext.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=aik@ozlabs.ru; keydata=
 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
Message-ID: <71a0e80a-c587-4973-cfc3-9c74b2b3a16c@ozlabs.ru>
Date: Thu, 17 Jan 2019 15:22:16 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547698231-20985-2-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Michal Marek <michal.lkml@markovi.net>, Kees Cook <keescook@chromium.org>,
 "Mauro S. M. Rodrigues" <maurosr@linux.vnet.ibm.com>,
 James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
 x86@kernel.org, Mark Greer <mgreer@animalcreek.com>,
 Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Paul Burton <paul.burton@mips.com>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Joel Stanley <joel@jms.id.au>, "H. Peter Anvin" <hpa@zytor.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 17/01/2019 15:10, Masahiro Yamada wrote:
> In Kbuild, if_changed and friends must have FORCE as a prerequisite.
> 
> Hence, $(filter-out FORCE,$^) or $(filter-out $(PHONY),$^) is a common
> pattern to get the names of all the prerequisites except phony targets.
> 
> Add real-prereqs as a shorthand.
> 
> Note:
> We cannot replace $(filter %.o,$^) in cmd_link_multi-m because $^ may
> include auto-generated dependencies from the .*.cmd file when a single
> object module is changed into a multi object module. For details,
> see commit 69ea912fda74 ("kbuild: remove unneeded link_multi_deps").
> I added a comment to avoid accidental breakage.


What is this series made on top of? This does not apply on top of master
from https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git



> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  Documentation/devicetree/bindings/Makefile |  2 +-
>  arch/mips/boot/Makefile                    |  2 +-
>  arch/powerpc/boot/Makefile                 |  2 +-
>  arch/x86/realmode/rm/Makefile              |  3 +--
>  scripts/Kbuild.include                     |  4 ++++
>  scripts/Makefile.build                     |  9 ++++++---
>  scripts/Makefile.lib                       | 18 +++++++++---------
>  scripts/Makefile.modpost                   |  2 +-
>  8 files changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index 6e5cef0..e4eb5d1 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -15,7 +15,7 @@ DT_TMP_SCHEMA := processed-schema.yaml
>  extra-y += $(DT_TMP_SCHEMA)
>  
>  quiet_cmd_mk_schema = SCHEMA  $@
> -      cmd_mk_schema = $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(filter-out FORCE, $^)
> +      cmd_mk_schema = $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(real-prereqs)
>  
>  DT_DOCS = $(shell cd $(srctree)/$(src) && find * -name '*.yaml')
>  DT_SCHEMA_FILES ?= $(addprefix $(src)/,$(DT_DOCS))
> diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
> index 35704c2..3ce4dd5 100644
> --- a/arch/mips/boot/Makefile
> +++ b/arch/mips/boot/Makefile
> @@ -115,7 +115,7 @@ endif
>  targets += vmlinux.its.S
>  
>  quiet_cmd_its_cat = CAT     $@
> -      cmd_its_cat = cat $(filter-out $(PHONY), $^) >$@
> +      cmd_its_cat = cat $(real-prereqs) >$@
>  
>  $(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS)) FORCE
>  	$(call if_changed,its_cat)
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index 0e8dadd..73d1f35 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -218,7 +218,7 @@ quiet_cmd_bootas = BOOTAS  $@
>        cmd_bootas = $(BOOTCC) -Wp,-MD,$(depfile) $(BOOTAFLAGS) -c -o $@ $<
>  
>  quiet_cmd_bootar = BOOTAR  $@
> -      cmd_bootar = $(BOOTAR) $(BOOTARFLAGS) $@.$$$$ $(filter-out FORCE,$^); mv $@.$$$$ $@
> +      cmd_bootar = $(BOOTAR) $(BOOTARFLAGS) $@.$$$$ $(real-prereqs); mv $@.$$$$ $@
>  
>  $(obj-libfdt): $(obj)/%.o: $(srctree)/scripts/dtc/libfdt/%.c FORCE
>  	$(call if_changed_dep,bootcc)
> diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
> index 4463fa7..394377c 100644
> --- a/arch/x86/realmode/rm/Makefile
> +++ b/arch/x86/realmode/rm/Makefile
> @@ -37,8 +37,7 @@ REALMODE_OBJS = $(addprefix $(obj)/,$(realmode-y))
>  sed-pasyms := -n -r -e 's/^([0-9a-fA-F]+) [ABCDGRSTVW] (.+)$$/pa_\2 = \2;/p'
>  
>  quiet_cmd_pasyms = PASYMS  $@
> -      cmd_pasyms = $(NM) $(filter-out FORCE,$^) | \
> -		   sed $(sed-pasyms) | sort | uniq > $@
> +      cmd_pasyms = $(NM) $(real-prereqs) | sed $(sed-pasyms) | sort | uniq > $@
>  
>  targets += pasyms.h
>  $(obj)/pasyms.h: $(REALMODE_OBJS) FORCE
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 3081603..d93250b 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -24,6 +24,10 @@ depfile = $(subst $(comma),_,$(dot-target).d)
>  basetarget = $(basename $(notdir $@))
>  
>  ###
> +# real prerequisites without phony targets
> +real-prereqs = $(filter-out $(PHONY), $^)
> +
> +###
>  # Escape single quote for use in echo statements
>  escsq = $(subst $(squote),'\$(squote)',$1)
>  
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 681ab58..9800178 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -399,8 +399,7 @@ $(sort $(subdir-obj-y)): $(subdir-ym) ;
>  ifdef builtin-target
>  
>  quiet_cmd_ar_builtin = AR      $@
> -      cmd_ar_builtin = rm -f $@; \
> -                     $(AR) rcSTP$(KBUILD_ARFLAGS) $@ $(filter $(real-obj-y), $^)
> +      cmd_ar_builtin = rm -f $@; $(AR) rcSTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
>  
>  $(builtin-target): $(real-obj-y) FORCE
>  	$(call if_changed,ar_builtin)
> @@ -428,7 +427,7 @@ ifdef lib-target
>  quiet_cmd_link_l_target = AR      $@
>  
>  # lib target archives do get a symbol table and index
> -cmd_link_l_target = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(lib-y)
> +cmd_link_l_target = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
>  
>  $(lib-target): $(lib-y) FORCE
>  	$(call if_changed,link_l_target)
> @@ -453,6 +452,10 @@ targets += $(obj)/lib-ksyms.o
>  
>  endif
>  
> +# NOTE:
> +# Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
> +# module is turned into a multi object module, $^ will contain header file
> +# dependencies recorded in the .*.cmd file.
>  quiet_cmd_link_multi-m = LD [M]  $@
>  cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^) $(cmd_secanalysis)
>  
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index ebaa348..c6fc295 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -231,7 +231,7 @@ $(obj)/%: $(src)/%_shipped
>  # ---------------------------------------------------------------------------
>  
>  quiet_cmd_ld = LD      $@
> -cmd_ld = $(LD) $(ld_flags) $(filter-out FORCE,$^) -o $@
> +      cmd_ld = $(LD) $(ld_flags) $(real-prereqs) -o $@
>  
>  # Objcopy
>  # ---------------------------------------------------------------------------
> @@ -243,7 +243,7 @@ cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
>  # ---------------------------------------------------------------------------
>  
>  quiet_cmd_gzip = GZIP    $@
> -      cmd_gzip = cat $(filter-out FORCE,$^) | gzip -n -f -9 > $@
> +      cmd_gzip = cat $(real-prereqs) | gzip -n -f -9 > $@
>  
>  # DTC
>  # ---------------------------------------------------------------------------
> @@ -321,7 +321,7 @@ dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
>  # append the size as a 32-bit littleendian number as gzip does.
>  size_append = printf $(shell						\
>  dec_size=0;								\
> -for F in $(filter-out FORCE,$^); do					\
> +for F in $(real-prereqs); do					\
>  	fsize=$$($(CONFIG_SHELL) $(srctree)/scripts/file-size.sh $$F);	\
>  	dec_size=$$(expr $$dec_size + $$fsize);				\
>  done;									\
> @@ -335,19 +335,19 @@ printf "%08x\n" $$dec_size |						\
>  )
>  
>  quiet_cmd_bzip2 = BZIP2   $@
> -      cmd_bzip2 = (cat $(filter-out FORCE,$^) | bzip2 -9 && $(size_append)) > $@
> +      cmd_bzip2 = (cat $(real-prereqs) | bzip2 -9 && $(size_append)) > $@
>  
>  # Lzma
>  # ---------------------------------------------------------------------------
>  
>  quiet_cmd_lzma = LZMA    $@
> -      cmd_lzma = (cat $(filter-out FORCE,$^) | lzma -9 && $(size_append)) > $@
> +      cmd_lzma = (cat $(real-prereqs) | lzma -9 && $(size_append)) > $@
>  
>  quiet_cmd_lzo = LZO     $@
> -      cmd_lzo = (cat $(filter-out FORCE,$^) | lzop -9 && $(size_append)) > $@
> +      cmd_lzo = (cat $(real-prereqs) | lzop -9 && $(size_append)) > $@
>  
>  quiet_cmd_lz4 = LZ4     $@
> -      cmd_lz4 = (cat $(filter-out FORCE,$^) | lz4c -l -c1 stdin stdout && \
> +      cmd_lz4 = (cat $(real-prereqs) | lz4c -l -c1 stdin stdout && \
>                    $(size_append)) > $@
>  
>  # U-Boot mkimage
> @@ -390,11 +390,11 @@ quiet_cmd_uimage = UIMAGE  $@
>  # big dictionary would increase the memory usage too much in the multi-call
>  # decompression mode. A BCJ filter isn't used either.
>  quiet_cmd_xzkern = XZKERN  $@
> -cmd_xzkern = (cat $(filter-out FORCE,$^) | \
> +      cmd_xzkern = (cat $(real-prereqs) | \
>  	sh $(srctree)/scripts/xz_wrap.sh && $(size_append)) > $@
>  
>  quiet_cmd_xzmisc = XZMISC  $@
> -cmd_xzmisc = (cat $(filter-out FORCE,$^) | \
> +      cmd_xzmisc = (cat $(real-prereqs) | \
>  	xz --check=crc32 --lzma2=dict=1MiB) > $@
>  
>  # ASM offsets
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 7d4af0d0..c0b7f52 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -122,7 +122,7 @@ quiet_cmd_ld_ko_o = LD [M]  $@
>        cmd_ld_ko_o =                                                     \
>  	$(LD) -r $(KBUILD_LDFLAGS)                                      \
>                   $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)             \
> -                 -o $@ $(filter-out FORCE,$^) ;                         \
> +                 -o $@ $(real-prereqs) ;                                \
>  	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
>  
>  $(modules): %.ko :%.o %.mod.o FORCE
> 

-- 
Alexey
