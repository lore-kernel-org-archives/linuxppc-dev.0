Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZl7b17CxzDsY0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 03:01:46 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8FH0lIB117581
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 13:01:45 -0400
Received: from e24smtp02.br.ibm.com (e24smtp02.br.ibm.com [32.104.18.86])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25fr9hgj3b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 13:01:44 -0400
Received: from localhost
 by e24smtp02.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 15 Sep 2016 14:01:42 -0300
Received: from d24relay04.br.ibm.com (d24relay04.br.ibm.com [9.18.232.146])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id E8162352006C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 13:01:16 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay04.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8FH1eJI33292316
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 14:01:40 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8FH1dss030023
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 14:01:40 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, Eric Richter <erichte@linux.vnet.ibm.com>
Cc: sfr@canb.auug.org.au, mm-commits@vger.kernel.org,
 Mimi Zohar <zohar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: +
 powerpc-add-purgatory-for-kexec_file_load-implementation-fix.patch added to
 -mm tree
Date: Thu, 15 Sep 2016 14:01:20 -0300
In-Reply-To: <57cf1635.x7x1nHHs5jsf4Su7%akpm@linux-foundation.org>
References: <57cf1635.x7x1nHHs5jsf4Su7%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <1640906.2L7LLfBX4l@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Andrew and Stephen,

Am Dienstag, 06 September 2016, 12:17:09 schrieb akpm@linux-foundation.org:
> The patch titled
>      Subject: powerpc-add-purgatory-for-kexec_file_load-implementation-fix
> has been added to the -mm tree.  Its filename is
>      powerpc-add-purgatory-for-kexec_file_load-implementation-fix.patch
> 
> This patch should soon appear at
>    
> http://ozlabs.org/~akpm/mmots/broken-out/powerpc-add-purgatory-for-kexec_
> file_load-implementation-fix.patch and later at
>    
> http://ozlabs.org/~akpm/mmotm/broken-out/powerpc-add-purgatory-for-kexec_
> file_load-implementation-fix.patch
> 
> Before you just go and hit "reply", please:
>    a) Consider who else should be cc'ed
>    b) Prefer to cc a suitable mailing list as well
>    c) Ideally: find the original patch on the mailing list and do a
>       reply-to-all to that, adding suitable additional cc's
> 
> *** Remember to use Documentation/SubmitChecklist when testing your code
> ***
> 
> The -mm tree is included into linux-next and is updated
> there every 3-4 working days

I noticed that both the kexec_file_load implementation for powerpc and the 
kexec hand-over buffer patches were removed from -mm and linux-next.

kexec_file_load is desired even without the kexec hand-over buffer feature 
because it enables one to only allow loading of signed kernels, and also to 
measure the loaded kernel and initramfs. There are users interested in both 
of those features on powerpc and since IMA already supports them via its 
hooks in kexec_file_load, the only missing piece in the puzzle is the 
kexec_file_load implementation itself.

The latest version of the kexec_file_load series is v8:

https://lists.infradead.org/pipermail/kexec/2016-September/017123.html

which is also part of the next-kexec-restore branch at 
git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git

I'm not aware of any issue with v8, so could you consider it for -mm and 
linux-next independently of the kexec buffer hand-over series?
 
> ------------------------------------------------------
> From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Subject: powerpc-add-purgatory-for-kexec_file_load-implementation-fix
> 
> The change below to arch/powerpc/purgatory/Makefile fixes the cross build
> from ppc64 BE to ppc64 LE.
> 
> I also noticed that building the purgatory during archprepare is not
> necessary, so I also made the change below to arch/powerpc/Makefile.
> 
> I'm preparing a v8 of the kexec_file_load implementation for powerpc
> series with those changes and will send it shortly.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/powerpc/Makefile           |    3 ---
>  arch/powerpc/purgatory/Makefile |    8 +++++---
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff -puN
> arch/powerpc/Makefile~powerpc-add-purgatory-for-kexec_file_load-implement
> ation-fix arch/powerpc/Makefile ---
> a/arch/powerpc/Makefile~powerpc-add-purgatory-for-kexec_file_load-impleme
> ntation-fix +++ a/arch/powerpc/Makefile
> @@ -378,9 +378,6 @@ archclean:
>  	$(Q)$(MAKE) $(clean)=$(boot)
> 
>  archprepare: checkbin
> -ifeq ($(CONFIG_KEXEC_FILE),y)
> -	$(Q)$(MAKE) $(build)=arch/powerpc/purgatory
> arch/powerpc/purgatory/kexec-purgatory.c -endif
> 
>  # Use the file '.tmp_gas_check' for binutils tests, as gas won't output
>  # to stdout and these checks are run even on install targets.
> diff -puN
> arch/powerpc/purgatory/Makefile~powerpc-add-purgatory-for-kexec_file_load
> -implementation-fix arch/powerpc/purgatory/Makefile ---
> a/arch/powerpc/purgatory/Makefile~powerpc-add-purgatory-for-kexec_file_lo
> ad-implementation-fix +++ a/arch/powerpc/purgatory/Makefile
> @@ -23,10 +23,12 @@ KBUILD_AFLAGS := -fno-exceptions -msoft-
>  		-D__ASSEMBLY__
> 
>  ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
> -KBUILD_CFLAGS += $(call cc-option,-mabi=elfv2,$(call
> cc-option,-mcall-aixdesc)) -KBUILD_AFLAGS += $(call
> cc-option,-mabi=elfv2)
> +KBUILD_CFLAGS += $(call cc-option,-mabi=elfv2,$(call
> cc-option,-mcall-aixdesc)) \ +		-mlittle-endian
> +KBUILD_AFLAGS += $(call cc-option,-mabi=elfv2) -mlittle-endian
>  else
> -KBUILD_CFLAGS += $(call cc-option,-mcall-aixdesc)
> +KBUILD_CFLAGS += $(call cc-option,-mcall-aixdesc) -mbig-endian
> +KBUILD_AFLAGS += -mbig-endian
>  endif
> 
>  $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
> _
> 
> Patches currently in -mm which might be from bauerman@linux.vnet.ibm.com
> are
> 
> kexec_file-allow-arch-specific-memory-walking-for-kexec_add_buffer.patch
> kexec_file-change-kexec_add_buffer-to-take-kexec_buf-as-argument.patch
> kexec_file-factor-out-kexec_locate_mem_hole-from-kexec_add_buffer.patch
> powerpc-change-places-using-config_kexec-to-use-config_kexec_core-instead.
> patch
> powerpc-factor-out-relocation-code-from-module_64c-to-elf_util_64c.patch
> powerpc-generalize-elf64_apply_relocate_add.patch
> powerpc-adapt-elf64_apply_relocate_add-for-kexec_file_load.patch
> powerpc-add-functions-to-read-elf-files-of-any-endianness.patch
> powerpc-implement-kexec_file_load.patch
> powerpc-add-code-to-work-with-device-trees-in-kexec_file_load.patch
> powerpc-add-support-for-loading-elf-kernels-with-kexec_file_load.patch
> powerpc-add-purgatory-for-kexec_file_load-implementation.patch
> powerpc-add-purgatory-for-kexec_file_load-implementation-fix.patch
> powerpc-enable-config_kexec_file-in-powerpc-server-defconfigs.patch
> kexec_file-add-buffer-hand-over-support-for-the-next-kernel.patch
> powerpc-kexec_file-add-buffer-hand-over-support-for-the-next-kernel.patch
> kexec_file-allow-skipping-checksum-calculation-for-some-segments.patch
> kexec_file-add-mechanism-to-update-kexec-segments.patch
> ima-on-soft-reboot-save-the-measurement-list.patch

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
