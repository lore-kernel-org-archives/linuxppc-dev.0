Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9D3C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 May 2022 22:14:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L3S2f2jsfz3bY5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 May 2022 08:14:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=xmission.com (client-ip=166.70.13.232;
 helo=out02.mta.xmission.com; envelope-from=ebiederm@xmission.com;
 receiver=<UNKNOWN>)
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L3S2541v1z2x9p
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2022 08:14:03 +1000 (AEST)
Received: from in02.mta.xmission.com ([166.70.13.52]:60424)
 by out02.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1nrRva-003Y9P-Hy; Wed, 18 May 2022 16:13:58 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38702
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in02.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1nrRvZ-002wWx-3I; Wed, 18 May 2022 16:13:58 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
References: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com>
Date: Wed, 18 May 2022 16:59:37 -0500
In-Reply-To: <20220518181828.645877-1-naveen.n.rao@linux.vnet.ibm.com> (Naveen
 N. Rao's message of "Wed, 18 May 2022 23:48:28 +0530")
Message-ID: <87ee0q7b92.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nrRvZ-002wWx-3I; ; ;
 mid=<87ee0q7b92.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=68.227.174.4; ; ; frm=ebiederm@xmission.com;
 ; ; spf=softfail
X-XM-AID: U2FsdGVkX19j5afT7cfR1QMALWtaSChY2lnR9xJRogY=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> Since commit d1bcae833b32f1 ("ELF: Don't generate unused section
> symbols") [1], binutils (v2.36+) started dropping section symbols that
> it thought were unused.  This isn't an issue in general, but with
> kexec_file.c, gcc is placing kexec_arch_apply_relocations[_add] into a
> separate .text.unlikely section and the section symbol ".text.unlikely"
> is being dropped. Due to this, recordmcount is unable to find a non-weak
> symbol in .text.unlikely to generate a relocation record against.
>
> Address this by dropping the weak attribute from these functions:
> - arch_kexec_apply_relocations() is not overridden by any architecture
>   today, so just drop the weak attribute.
> - arch_kexec_apply_relocations_add() is only overridden by x86 and s390.
>   Retain the function prototype for those and move the weak
>   implementation into the header as a static inline for other
>   architectures.
>
> [1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d1bcae833b32f1

Any chance you can also get machine_kexec_post_load,
crash_free_reserved_phys_range, arch_kexec_protect_protect_crashkres,
arch_kexec_unprotect_crashkres, arch_kexec_kernel_image_probe,
arch_kexec_kernel_image_probe, arch_kimage_file_post_load_cleanup,
arch_kexec_kernel_verify_sig, and arch_kexec_locate_mem_hole as well.

That is everything in kexec that uses a __weak symbol.  If we can't
count on them working we might as well just get rid of the rest
preemptively.

Could you also address Andrews concerns by using a Kconfig symbol that
the architectures that implement the symbol can select.

I don't want to ask too much of a volunteer but if you are willing
addressing both of those would be a great help.

Eric

> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  include/linux/kexec.h | 28 ++++++++++++++++++++++++----
>  kernel/kexec_file.c   | 19 +------------------
>  2 files changed, 25 insertions(+), 22 deletions(-)
>
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 58d1b58a971e34..e656f981f43a73 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -193,10 +193,6 @@ void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name);
>  int arch_kexec_kernel_image_probe(struct kimage *image, void *buf,
>  				  unsigned long buf_len);
>  void *arch_kexec_kernel_image_load(struct kimage *image);
> -int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> -				     Elf_Shdr *section,
> -				     const Elf_Shdr *relsec,
> -				     const Elf_Shdr *symtab);
>  int arch_kexec_apply_relocations(struct purgatory_info *pi,
>  				 Elf_Shdr *section,
>  				 const Elf_Shdr *relsec,
> @@ -229,6 +225,30 @@ extern int crash_exclude_mem_range(struct crash_mem *mem,
>  				   unsigned long long mend);
>  extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
>  				       void **addr, unsigned long *sz);
> +
> +#if defined(CONFIG_X86_64) || defined(CONFIG_S390)
> +int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> +				     Elf_Shdr *section,
> +				     const Elf_Shdr *relsec,
> +				     const Elf_Shdr *symtab);
> +#else
> +/*
> + * arch_kexec_apply_relocations_add - apply relocations of type RELA
> + * @pi:		Purgatory to be relocated.
> + * @section:	Section relocations applying to.
> + * @relsec:	Section containing RELAs.
> + * @symtab:	Corresponding symtab.
> + *
> + * Return: 0 on success, negative errno on error.
> + */
> +static inline int
> +arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
> +				 const Elf_Shdr *relsec, const Elf_Shdr *symtab)
> +{
> +	pr_err("RELA relocation unsupported.\n");
> +	return -ENOEXEC;
> +}
> +#endif /* CONFIG_X86_64 || CONFIG_S390 */
>  #endif /* CONFIG_KEXEC_FILE */
>  
>  #ifdef CONFIG_KEXEC_ELF
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 8347fc158d2b96..6bae253b4d315e 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -108,23 +108,6 @@ int __weak arch_kexec_kernel_verify_sig(struct kimage *image, void *buf,
>  }
>  #endif
>  
> -/*
> - * arch_kexec_apply_relocations_add - apply relocations of type RELA
> - * @pi:		Purgatory to be relocated.
> - * @section:	Section relocations applying to.
> - * @relsec:	Section containing RELAs.
> - * @symtab:	Corresponding symtab.
> - *
> - * Return: 0 on success, negative errno on error.
> - */
> -int __weak
> -arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
> -				 const Elf_Shdr *relsec, const Elf_Shdr *symtab)
> -{
> -	pr_err("RELA relocation unsupported.\n");
> -	return -ENOEXEC;
> -}
> -
>  /*
>   * arch_kexec_apply_relocations - apply relocations of type REL
>   * @pi:		Purgatory to be relocated.
> @@ -134,7 +117,7 @@ arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
>   *
>   * Return: 0 on success, negative errno on error.
>   */
> -int __weak
> +int
>  arch_kexec_apply_relocations(struct purgatory_info *pi, Elf_Shdr *section,
>  			     const Elf_Shdr *relsec, const Elf_Shdr *symtab)
>  {
>
> base-commit: ef1302160bfb19f804451d0e919266703501c875
