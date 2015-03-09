Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 904141A1480
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2015 01:49:21 +1100 (AEDT)
Date: Mon, 9 Mar 2015 14:48:31 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/5] arm: factor out mmap ASLR into mmap_rnd
Message-ID: <20150309144831.GM8656@n2100.arm.linux.org.uk>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
 <1425341988-1599-2-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425341988-1599-2-git-send-email-keescook@chromium.org>
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

On Mon, Mar 02, 2015 at 04:19:44PM -0800, Kees Cook wrote:
> In preparation for exporting per-arch mmap randomization functions,
> this moves the ASLR calculations for mmap on ARM into a separate routine.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks fine, thanks.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

> ---
>  arch/arm/mm/mmap.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
> index 5e85ed371364..0f8bc158f2c6 100644
> --- a/arch/arm/mm/mmap.c
> +++ b/arch/arm/mm/mmap.c
> @@ -169,14 +169,21 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>  	return addr;
>  }
>  
> -void arch_pick_mmap_layout(struct mm_struct *mm)
> +static unsigned long mmap_rnd(void)
>  {
> -	unsigned long random_factor = 0UL;
> +	unsigned long rnd = 0UL;
>  
>  	/* 8 bits of randomness in 20 address space bits */
>  	if ((current->flags & PF_RANDOMIZE) &&
>  	    !(current->personality & ADDR_NO_RANDOMIZE))
> -		random_factor = (get_random_int() % (1 << 8)) << PAGE_SHIFT;
> +		rnd = (get_random_int() % (1 << 8)) << PAGE_SHIFT;
> +
> +	return rnd;
> +}
> +
> +void arch_pick_mmap_layout(struct mm_struct *mm)
> +{
> +	unsigned long random_factor = mmap_rnd();
>  
>  	if (mmap_is_legacy()) {
>  		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
> -- 
> 1.9.1
> 

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
