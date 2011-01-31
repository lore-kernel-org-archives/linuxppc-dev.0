Return-Path: <jwboyer@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 74720B70E9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Feb 2011 06:25:11 +1100 (EST)
Received: by wwb29 with SMTP id 29so6541899wwb.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Jan 2011 11:25:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110131191109.5727.87742.sendpatchset@squad5-lp1.lab.bos.redhat.com>
References: <20110131191109.5727.87742.sendpatchset@squad5-lp1.lab.bos.redhat.com>
Date: Mon, 31 Jan 2011 14:25:04 -0500
Message-ID: <AANLkTimnKthzUg79qQcEF4K6dkyuYwE22Hzp-U=yZmK9@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm: add devmem_is_allowed() for STRICT_DEVMEM
	checking
From: Josh Boyer <jwboyer@gmail.com>
To: Steve Best <sfbest@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 31, 2011 at 2:16 PM, Steve Best <sfbest@us.ibm.com> wrote:
> =A0 =A0Provide devmem_is_allowed() routine to restrict access to kernel
> =A0 =A0memory from userspace.
> =A0 =A0Set CONFIG_STRICT_DEVMEM config option to switch on checking.
>
> Signed-off-by: Steve Best <sfbest@us.ibm.com>
>
> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> index 2d38a50..6805d5d 100644
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -299,4 +299,16 @@ config PPC_EARLY_DEBUG_CPM_ADDR
> =A0 =A0 =A0 =A0 =A0platform probing is done, all platforms selected must
> =A0 =A0 =A0 =A0 =A0share the same address.
>
> +config STRICT_DEVMEM
> + =A0 =A0 =A0 =A0def_bool y
> + =A0 =A0 =A0 =A0prompt "Filter access to /dev/mem"
> + =A0 =A0 =A0 =A0---help---
> + =A0 =A0 =A0 =A0 =A0This option restricts access to /dev/mem. =A0If this=
 option is
> + =A0 =A0 =A0 =A0 =A0disabled, you allow userspace access to all memory, =
including
> + =A0 =A0 =A0 =A0 =A0kernel and userspace memory. Accidental memory acces=
s is likely
> + =A0 =A0 =A0 =A0 =A0to be disastrous.
> + =A0 =A0 =A0 =A0 =A0Memory access is required for experts who want to de=
bug the kernel.
> +
> + =A0 =A0 =A0 =A0 =A0If you are unsure, say Y.
> +
> =A0endmenu
> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/p=
age.h
> index 53b64be..f225032 100644
> --- a/arch/powerpc/include/asm/page.h
> +++ b/arch/powerpc/include/asm/page.h
> @@ -262,6 +262,11 @@ extern void copy_user_page(void *to, void *from, uns=
igned long vaddr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct page *p);
> =A0extern int page_is_ram(unsigned long pfn);
>
> +static inline int devmem_is_allowed(unsigned long pfn)
> +{
> + =A0 =A0 =A0 =A0return 0;
> +}
> +

Er, should this be toggled via CONFIG_STRICT_DEVMEM somehow?  Or I
guess I'm missing why the config option had to be added if not.

josh
