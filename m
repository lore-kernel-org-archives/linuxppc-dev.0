Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 563141A22AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:50:16 +1100 (AEDT)
Date: Mon, 9 Mar 2015 14:49:44 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 2/5] mm: expose arch_mmap_rnd when available
Message-ID: <20150309144944.GN8656@n2100.arm.linux.org.uk>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
 <1425341988-1599-3-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425341988-1599-3-git-send-email-keescook@chromium.org>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mips@linux-mips.org, Arun Chandran <achandran@mvista.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
 Min-Hua Chen <orca.chen@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Yann Droneaud <ydroneaud@opteya.com>, linux-s390@vger.kernel.org,
 Andrey Ryabinin <a.ryabinin@samsung.com>, x86@kernel.org,
 Hector Marco-Gisbert <hecmargi@upv.es>, "David A. Long" <dave.long@linaro.org>,
 Borislav Petkov <bp@suse.de>, Ben Hutchings <ben@decadent.org.uk>,
 Will Deacon <will.deacon@arm.com>, linux-fsdevel@vger.kernel.org,
 Alex Smith <alex@alex-smith.me.uk>,
 Michael Holzheu <holzheu@linux.vnet.ibm.com>,
 linux-arm-kernel@lists.infradead.org, Jeff Bailey <jeffbailey@google.com>,
 Paul Burton <paul.burton@imgtec.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Andy Lutomirski <luto@amacapital.net>,
 Vineeth Vijayan <vvijayan@mvista.com>,
 Markos Chandras <markos.chandras@imgtec.com>,
 Jan-Simon =?iso-8859-1?Q?M=F6ller?= <dl9pf@gmx.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 02, 2015 at 04:19:45PM -0800, Kees Cook wrote:
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 9f1f09a2bc9b..248d99cabaa8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -3,6 +3,7 @@ config ARM
>  	default y
>  	select ARCH_BINFMT_ELF_RANDOMIZE_PIE
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
> +	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_HAVE_CUSTOM_GPIO_H
>  	select ARCH_HAS_GCOV_PROFILE_ALL
> diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
> index 0f8bc158f2c6..3c1fedb034bb 100644
> --- a/arch/arm/mm/mmap.c
> +++ b/arch/arm/mm/mmap.c
> @@ -169,7 +169,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>  	return addr;
>  }
>  
> -static unsigned long mmap_rnd(void)
> +unsigned long arch_mmap_rnd(void)
>  {
>  	unsigned long rnd = 0UL;
>  
> @@ -183,7 +183,7 @@ static unsigned long mmap_rnd(void)
>  
>  void arch_pick_mmap_layout(struct mm_struct *mm)
>  {
> -	unsigned long random_factor = mmap_rnd();
> +	unsigned long random_factor = arch_mmap_rnd();
>  
>  	if (mmap_is_legacy()) {
>  		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;

For the above,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
